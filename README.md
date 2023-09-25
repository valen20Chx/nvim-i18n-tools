# nvim-i18n-tools

## A plugin to help manage, edit, and generate translations.

This is partially functional and is in development.

Please feel free to contact me if you want to help, and we'll see what to do.
This is a learning opportunity for me so don't expect this to be a complete plugin soon.

## Installation

I don't know yet how to make it work with Packer or LazyVim, will look it up later.

For now just copy the `init.lua` file.

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
