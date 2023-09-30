# nvim-i18n-tools

## A plugin to help manage, edit, and generate translations.

This is partially functional and is in development.

| ![image](https://github.com/valen20Chx/nvim-i18n-tools/assets/33943799/ca578dfd-e2bb-45d1-96f3-e393ea8fc43b) | ![image](https://github.com/valen20Chx/nvim-i18n-tools/assets/33943799/7bf646a5-40a9-4ba1-85b8-8b2273a111b4) |
| --- | ---|



Please feel free to contact me if you want to help, and we'll see what to do.
This is a learning opportunity for me so don't expect this to be a complete plugin soon.

## Installation

### Lazy.nvim

```lua
return {
  "valen20Chx/nvim-i18n-tools",
  config = function()
    require("nvim-i18n-tools").setup()
  end,
}
```

## Usage

You will need a `.nvim/` directory at the root of your project (directory you open neovim from),
in it you must put a `i18n-tools.lua` file with this inside:

```lua
return {
  -- path to the i18n file relative to this one (i18n-tools.lua)
  translations = "../path/to/the/translation/file.json",
}
```

## Future

- Handle multi projects directory
- Edit translations (some kind of popup)
- Generate translations
- Add more languages (translations files and programming language)
