# nvim-tabline

nvim port of [tabline.vim](https://github.com/mkitt/tabline.vim), written in Lua.
It is basically a drop-in replacement but with [some differences](#Differences).

![nvim-tabline-screenshots](screenshots/nvim-tabline.png)

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

### Mappings

Vim's tabpage commands are powerful enough, `:help tabpage` for details.
If you need switch between tabs, [here is a great tutorial](https://superuser.com/questions/410982/in-vim-how-can-i-quickly-switch-between-tabs).

### Highlights

The highlighting of the tab pages line follows vim settings. See `:help setting-tabline` for details.

### Differences

nvim-tabline is not exactly a Lua translation. There are some differences for configuration:

- Control whether to display tab number (`show_index`) and buffer modification indicator (`show_modify`)
- Specify no name buffer name
- Close button (`g:tablineclosebutton`) is not supported
