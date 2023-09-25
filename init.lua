local function i(value)
  print(vim.inspect(value))
end

---@return string: calls
---
local function node_text(value, bufnr)
  return vim.treesitter.get_node_text(value, bufnr)
end

---@param bufnr integer Source buffer to search
---@param start ( integer | nil ) Starting line for the search
---@param stop ( integer | nil ) Stopping line for the search (end-exclusive)
---
local function get_t_calls(bufnr, start, stop)
  local language_tree = vim.treesitter.get_parser(bufnr)
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[1]:root()
  local language = language_tree:lang()

  if not vim.tbl_contains({ "javascript", "typescript" }, language) then
    print("Language not supported")
    return {}
  end

  local query = vim.treesitter.query.parse(
    language_tree:lang(),
    [[
(call_expression
  function: (identifier) @t_func (#eq? @t_func "t")
  arguments: (arguments
    (string
      (string_fragment) @str_frag
    )
  )
)
    ]]
  )

  local t_nodes = {}

  for _, match in query:iter_matches(root, bufnr, start, stop) do
    -- TODO  : Getting the function name might be useless
    local func = match[1]
    local args = match[2]
    table.insert(t_nodes, { func, args })
  end

  return t_nodes
end

local function get_translation_for_key(key)
  local project_folder = vim.fn.getcwd()

  local nvim_conf_dir = vim.fn.resolve(project_folder .. "/.nvim/")

  local conf = dofile(vim.fn.resolve(nvim_conf_dir .. "/i18n-tools.lua"))

  local translations_path = vim.fn.resolve(nvim_conf_dir .. "/" .. conf.translations)

  -- TODO : Cache json file as to not load it on each refresh
  local translations = vim.fn.json_decode(vim.fn.readfile(translations_path))

  local result = translations
  for part in string.gmatch(key, "[^.]+") do
    if result[part] then
      result = result[part]
    else
      print("i18n : Not found " .. part)
      result = "i18n : Not found"
    end
  end

  if type(result) ~= "string" then
    result = "i18n : Not a string"
  end

  return result
end

local bufnr_to_ns_id = {}

local function apply_translations()
  local bufnr = vim.api.nvim_get_current_buf()
  local t_nodes = get_t_calls(bufnr)

  local ns_id = bufnr_to_ns_id[bufnr]
  if ns_id then
    -- TODO : This is not clearing the buffer
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  else
    ns_id = vim.api.nvim_create_namespace("i18n_hints" .. bufnr)
    bufnr_to_ns_id[bufnr] = ns_id
  end

  -- iterate over t_nodes if it has a size
  for _, t_node in ipairs(t_nodes) do
    -- TODO : Check that arg is a string /["`'].*["`']/g
    local t_key = t_node[2]
    local start_row, start_col = t_key:range()
    local replacement_text = get_translation_for_key(node_text(t_key, bufnr))

    -- Set virtual text for the specified range on the line
    vim.api.nvim_buf_set_extmark(bufnr, ns_id, start_row, start_col, {
      virt_text = { { replacement_text, "WarningMsg" } },
      -- TODO : For now the translation will be put at the end of the line
      -- later we can replace the key with the translation
      -- virt_text_pos = "overlay", -- Overlay on top of existing text
      virt_text_pos = "eol",
    })
  end
end

local M = {
  exec = function()
    apply_translations()
  end,
}

-- This is for development perposes
vim.keymap.set("n", "<leader>h", function()
  package.loaded.i18n_tools = nil
  require("plugins.nvim-i18n-tools").exec()
end)

return M
