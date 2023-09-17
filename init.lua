local function i(value)
  print(vim.inspect(value))
end

---@return (table<TSNode,TSNode>): calls
local function node_text(value, bufnr)
  return vim.treesitter.get_node_text(value, bufnr)
end

local function get_file_t_calls(bufnr)
  local language_tree = vim.treesitter.get_parser(bufnr)
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[1]:root()

  local query = vim.treesitter.query.parse(
    language_tree:lang(),
    [[
      (call_expression
        function: (identifier) @function (#eq? @function "t")
        arguments: (arguments) @arguments
      )
    ]]
  )

  local t_nodes = {}

  for _, match in query:iter_matches(root, bufnr) do
    local func = match[1]
    local args = match[2]
    table.insert(t_nodes, { func, args })
  end

  return t_nodes
end

local function apply_translations()
  local t_nodes = get_file_t_calls(vim.fn.bufnr())
end
