<h4><div align="right">
    <a href="#installation">Installation</a>
    <span> | </span>
    <a href="#default-configuration">Configuration</a>
    <span> | </span>
    <a href="#customization">Customization</a>
    <span> &nbsp;&nbsp;&nbsp; &nbsp; </span>
</div></h4>

**Dark** and **Light** Themes for neovim >= 0.5 based on [onedark.nvim](https://github.com/navarasu/onedark.nvim) theme written in lua with [TreeSitter](https://github.com/nvim-treesitter/nvim-treesitter) syntax highlight.

*For latest [TreeSitter](https://github.com/nvim-treesitter/nvim-treesitter) syntax highlight, upgraded to NeoVim 0.8.0 or later built with tree-sitter 0.20.3+*

### Features
  * Light, and Dark variants set by the 'background' option.
  <!-- * Supporting multiple plugins with hand picked proper colors -->
  <!-- * Customize `Colors`, `Highlights` and `Code style` of the theme as you like (Refer [Customization](#customization)) -->

## Themes

## Installation
Install via your favourite package manager
```vim
" Using Vim-Plug
Plug 'sobh/caironoon.nvim'
```

```lua
-- Using Packer
use 'sobh/caironoon.nvim'
```

## Configuration

### Enable theme

```lua
-- Lua
require('caironoon').load()
```

```vim
" Vim
colorscheme caironoon
```

## Default Configuration

```lua
-- Lua
require('caironoon').setup  {
    -- Main options --
    transparent = false,     -- don't set background
    term_colors = true,      -- if true enable the terminal
    ending_tildes = false,    -- show the end-of-buffer tildes
    cmp_itemkind_reverse = false,    -- reverse item kind highlights in cmp menu

    -- Changing Formats --
    code_style = {
        comments  = 'none',
        keywords  = 'italic',
        functions = 'bold',
        strings   = 'none',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = false, -- center bar (c) transparency
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Related --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl for diagnostics
        background = true,    -- use background color for virtual text
    },
}
```

### Vimscript configuration

Onedark can be configured also with Vimscript, using the global dictionary `g:caironoon_config`.
**NOTE**: when setting boolean values use `v:true` and `v:false` instead of 0 and 1

Example:
``` vim
let g:caironoon_config = {
  \ 'ending_tildes': v:true,
  \ 'diagnostics': {
    \ 'darker': v:false,
    \ 'background': v:false,
  \ },
\ }
colorscheme caironoon
```

## Customization

Example custom colors and Highlights config

```lua
require('caironoon').setup {
  colors = {
    bright_orange = "#ff8800",    -- define a new color
    green = '#00ffaa',            -- redefine an existing color
  },
  highlights = {
    ["@keyword"] = {fg = '$green'},
    ["@string"] = {fg = '$bright_orange', bg = '#00ff00', fmt = 'bold'},
    ["@function"] = {fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic'},
    ["@function.builtin"] = {fg = '#0059ff'}
  }
}
```
Note that TreeSitter keywords have been changed after neovim version 0.8 and onwards.
TS prefix is trimmed and lowercase words should be used separated with '.'

The old way before neovim 0.8 looks like this.
For all keywords see [this](https://github.com/sobh/caironoon.nvim/blob/master/lua/caironoon/highlights.lua#L133-L257) file from line 133 to 257

```lua
require('caironoon').setup {
  colors = {
    bright_orange = "#ff8800",    -- define a new color
    green = '#00ffaa',            -- redefine an existing color
  },
  highlights = {
    TSKeyword = {fg = '$green'},
    TSString = {fg = '$bright_orange', bg = '#00ff00', fmt = 'bold'},
    TSFunction = {fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic'},
    TSFuncBuiltin = {fg = '#0059ff'}
  }
}
```

## Plugins Configuration

### Enable lualine
To Enable the `caironoon` theme for `Lualine`, specify theme as `caironoon`:

```lua
require('lualine').setup {
  options = {
    theme = 'caironoon'
    -- ... your lualine config
  }
}
```

## Plugins Supported
  + [TreeSitter](https://github.com/nvim-treesitter/nvim-treesitter)
  + [LSPDiagnostics](https://neovim.io/doc/user/lsp.html)
  + [NvimTree](https://github.com/kyazdani42/nvim-tree.lua)
  + [Telescope](https://github.com/nvim-telescope/telescope.nvim)
  + [WhichKey](https://github.com/folke/which-key.nvim)
  + [Dashboard](https://github.com/glepnir/dashboard-nvim)
  + [Lualine](https://github.com/hoob3rt/lualine.nvim)
  + [GitGutter](https://github.com/airblade/vim-gitgutter)
  + [GitSigns](https://github.com/lewis6991/gitsigns.nvim)
  + [VimFugitive](https://github.com/tpope/vim-fugitive)
  + [DiffView](https://github.com/sindrets/diffview.nvim)
  + [Hop](https://github.com/phaazon/hop.nvim)
  + [Mini](https://github.com/echasnovski/mini.nvim)
  + [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
  + [Neotest](https://github.com/nvim-neotest/neotest)
  + [Barbecue](https://github.com/utilyre/barbecue.nvim)
  + [IndentBlankline](https://github.com/lukas-reineke/indent-blankline.nvim)

## Reference
* [tokyodark.nvim](https://github.com/tiagovla/tokyodark.nvim)
* [onedark.nvim](https://github.com/navarasu/onedark.nvim)

## Contributing

Pull requests are welcome 🎉👍.

## License

[MIT](https://choosealicense.com/licenses/mit/)
