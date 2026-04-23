-- "textmanip
-- xmap <Space>d <Plug>(textmanip-duplicate-down)
-- nmap <Space>d <Plug>(textmanip-duplicate-down)
-- xmap <Space>D <Plug>(textmanip-duplicate-up)
-- nmap <Space>D <Plug>(textmanip-duplicate-up)
-- 
-- xmap <C-j> <Plug>(textmanip-move-down)
-- xmap <C-k> <Plug>(textmanip-move-up)
-- xmap <C-h> <Plug>(textmanip-move-left)
-- xmap <C-l> <Plug>(textmanip-move-right)
return {
	't9md/vim-textmanip',
	config = function()
		vim.api.nvim_set_keymap('x', '<Space>d', '<Plug>(textmanip-duplicate-down)', {})
		vim.api.nvim_set_keymap('n', '<Space>d', '<Plug>(textmanip-duplicate-down)', {})
		vim.api.nvim_set_keymap('x', '<Space>D', '<Plug>(textmanip-duplicate-up)', {})
		vim.api.nvim_set_keymap('n', '<Space>D', '<Plug>(textmanip-duplicate-up)', {})
		vim.api.nvim_set_keymap('x', '<C-j>', '<Plug>(textmanip-move-down)', {})
		vim.api.nvim_set_keymap('x', '<C-k>', '<Plug>(textmanip-move-up)', {})
		vim.api.nvim_set_keymap('x', '<C-h>', '<Plug>(textmanip-move-left)', {})
		vim.api.nvim_set_keymap('x', '<C-l>', '<Plug>(textmanip-move-right)', {})
	end,
}
