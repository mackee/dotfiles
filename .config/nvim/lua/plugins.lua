local lazypath = "~/.config/nvim/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
local lazy = require("lazy")
local plugins = {
  {
    "altercation/vim-colors-solarized",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("filetype indent plugin on")
      vim.cmd("let g:solarized_termcolors=256")
      vim.cmd("syntax enable")
      vim.cmd("set background=dark")
      vim.cmd("colorscheme solarized")
    end,
  },
  require("lualine_config"),
  require("ddc_config"),
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	event = { "InsertEnter" },
	-- 	opts = {
	-- 		suggestion = {
	-- 			enabled = true,
	-- 			auto_trigger = true,
	-- 			debounce = 75,
	-- 			keymap = {
  --         accept = "<C-a>",
  --         dismiss = "<C-]>",
	-- 			}
	-- 		},
	-- 	},
	-- },
	{
		"j-hui/fidget.nvim",
		config = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textsubjects",
		},
		build = function()
			vim.cmd("TSUpdate")
			require('nvim-treesitter.configs').setup {
				textsubjects = {
					enable = true,
					prev_selection = ',',
					keymaps = {
							['.'] = 'textsubjects-smart',
							[';'] = 'textsubjects-container-outer',
							['i;'] = { 'textsubjects-container-inner', desc = "Select inside containers (classes, functions, etc.)" },
					},
				},
			}
		end,
		config = true,
	},
  {
		"chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = { useDefaultKeymaps = true },
	},
	{
		"shellRaining/hlchunk.nvim",
		event = { "UIEnter" },
		config = true,
	},
	{
		"monaqa/dial.nvim",
		config = function ()
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
		"tpope/vim-fugitive",
		dependencies = { "tpope/vim-rhubarb" },
	},
	require("ddu_config"),
	require("textmanip_config"),
}
local opts = {
  root = "~/.config/nvim/lazy",
}

lazy.setup(plugins, opts)
