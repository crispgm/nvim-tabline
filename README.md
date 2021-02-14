# nvim-tabline

nvim ports of [tabline.vim](https://github.com/mkitt/tabline.vim), written in Lua.
It is basically a drop-in replacement but with [some differences](/#Differences).

## Installation

With vim-plug:

```viml
Plug 'crispgm/nvim-tabline'
```

## Configuration

```lua
require'tabline'.setup{}
```

### Defaults

```lua
require'tabline'.setup{
    show_index = true,    -- show tab index
    show_modify = true,   -- show buffer modification indicator
    no_name = '[No name]' -- no name buffer name
}
```

### Highlights

The highlights support is a drop-in feature from `tabline.vim`.

### Differences

nvim-tabline is not exactly a Lua translation. There are some differences for configuration:

- Control whether to display tab number (`show_index`) and buffer modification indicator (`show_modify`)
- Specify no name buffer name
- Close button (`g:tablineclosebutton`) is not supported
