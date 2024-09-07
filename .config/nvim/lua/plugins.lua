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
			"RRethy/nvim-treesitter-textsubjects",
		},
		build = function()
			vim.cmd("TSUpdate")
		end,
		config = function()
			require('nvim-treesitter.configs').setup {
				highlight = {
					enable = true,
					use_languagetree = true,
				},
				indent = {
					enable = true,
				},
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
				function() require'align'.align_to_char({ length = 1 }) end,
				{ noremap = true, silent = true }
			)
		end
	},
}
local opts = {
  root = "~/.config/nvim/lazy",
}

lazy.setup(plugins, opts)
