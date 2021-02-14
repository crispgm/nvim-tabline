# nvim-tabline

nvim ports of [tabline.vim](https://github.com/mkitt/tabline.vim), written in Lua.

## Installation

```viml
Plug 'crispgm/nvim-tabline'
```

## Configuration

```lua
require'tabline'.setup{}
```

Default setups:

```lua
require'tabline'.setup{
    show_index = true,
    show_modify = true,
    no_name = '[No name]'
}
```
