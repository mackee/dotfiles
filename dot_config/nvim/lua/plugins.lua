local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")
local plugins = {
  -- {
  --   "altercation/vim-colors-solarized",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd("filetype indent plugin on")
  --     vim.cmd("let g:solarized_termcolors=256")
  --     vim.cmd("syntax enable")
  --     vim.cmd("set background=dark")
  --     vim.cmd("colorscheme solarized")
  --   end,
  -- },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true

      vim.cmd("syntax enable")
      vim.cmd("colorscheme duskfox")
    end,
  },
  require("lualine_config"),
  { "neovim/nvim-lspconfig" },
  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_no_maps = true
    end,
    config = function()
      vim.keymap.set('i', '<C-l>', 'copilot#Accept("")', {
        expr = true, replace_keycodes = false, silent = true,
      })
      vim.keymap.set('i', '<C-j>', '<Plug>(copilot-accept-word)')
      vim.keymap.set('i', '<C-k>', '<Plug>(copilot-accept-line)')
      vim.keymap.set('i', '<C-]>', '<Plug>(copilot-dismiss)')
      vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)')
      vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)')
    end,
  },
  -- {
  --  "zbirenbaum/copilot.lua",
  --  event = { "InsertEnter" },
  --  opts = {
  --    suggestion = {
  --      enabled = true,
  --      auto_trigger = true,
  --      debounce = 75,
  --      keymap = {
  --         accept = "<C-a>",
  --         dismiss = "<C-]>",
  --      }
  --    },
  --  },
  -- },
  {
    "j-hui/fidget.nvim",
    config = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter').setup({})

      local ensure_installed = {
        'bash', 'css', 'go', 'gomod', 'gosum', 'gotmpl',
        'graphql', 'hcl', 'html', 'javascript', 'json', 'jsonc',
        'jsonnet', 'lua', 'markdown', 'markdown_inline', 'perl',
        'php', 'python', 'query', 'ruby', 'slim', 'sql',
        'terraform', 'toml', 'tsx', 'typescript', 'vhs', 'vim',
        'vimdoc', 'yaml',
      }
      require('nvim-treesitter').install(ensure_installed)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if not lang then return end
          if pcall(vim.treesitter.start, args.buf, lang) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = {
      keymaps = {
        useDefaults = true,
      },
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = true,
  },
  {
    "monaqa/dial.nvim",
    config = function()
      vim.keymap.set("n", "<C-a>", function()
        require("dial.map").manipulate("increment", "normal")
      end)
      vim.keymap.set("n", "<C-x>", function()
        require("dial.map").manipulate("decrement", "normal")
      end)
      vim.keymap.set("n", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gnormal")
      end)
      vim.keymap.set("n", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gnormal")
      end)
      vim.keymap.set("v", "<C-a>", function()
        require("dial.map").manipulate("increment", "visual")
      end)
      vim.keymap.set("v", "<C-x>", function()
        require("dial.map").manipulate("decrement", "visual")
      end)
      vim.keymap.set("v", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gvisual")
      end)
      vim.keymap.set("v", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gvisual")
      end)
    end,
  },
  {
    "Wansmer/treesj",
    config = { max_join_length = 1000 },
  },
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
  },
  require("ddu_config"),
  require("textmanip_config"),
  { "mattn/vim-goaddtags" },
  {
    'Vonr/align.nvim',
    branch = "v2",
    lazy = true,
    init = function()
      vim.keymap.set(
        'x',
        'aa',
        function() require 'align'.align_to_char({ length = 1 }) end,
        { noremap = true, silent = true }
      )
    end
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons"
  --   }
  -- },
  -- require("avante_config"),
}
local opts = {
  root = "~/.config/nvim/lazy",
}

lazy.setup(plugins, opts)
