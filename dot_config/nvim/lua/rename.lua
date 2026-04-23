-- https://miyazi888.hatenablog.com/entry/2019/07/01/235647
vim.api.nvim_create_user_command('Rename',
	function(opts)
		local old_name = vim.fn.expand("%")
		local default_name = old_name
		local fargs = opts.fargs
		if #fargs >= 1 then
			default_name = vim.fn.expand("%:h") .. '/' .. opts.fargs[1]
		end
		local new_name = vim.fn.input('New current file name: ', default_name)
		if vim.fn.filereadable(new_name) == 1 then
			vim.cmd('redraw!')
			vim.cmd('echo "Can\'t rename : Already exists new filename."')
			return
		end
		if new_name ~= '' and new_name ~= old_name then
			vim.cmd('f ' .. new_name .. '|call delete(expand("#"))')
			vim.cmd('saveas ' .. new_name)
			vim.cmd('redraw!')
		end
	end,
	{ bang = true, nargs = '?' })
