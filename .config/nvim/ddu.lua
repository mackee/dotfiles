vim.fn["ddu#custom#patch_global"]({
  ui = 'ff',
  sources = {
    {
      name = 'file_rec',
      params = {
        ignoredDirectories = {'.git', 'node_modules', 'vendor', '.next'}
      }
    }
  },
  sourceOptions = {
    _ = {
      matchers = {'matcher_substring'},
    },
  },
  filterParams = {
    matcher_substring = {
      highlightMatched = 'Title',
    },
  },
  kindOptions = {
    file = {
      defaultAction = 'open',
    },
  },
  uiParams = {
    ff = {
      ignoreEmpty = true,
      split = 'floating',
      startAutoAction = true,
      prompt = '> ',
      startFilter = true,
      filterSplitDirection = 'floating',
      filterFloatingPosition = 'bottom',
      floatingBorder = 'rounded',
      winHeight = '&lines / 3 - 3',
      winWidth = '&columns - 3',
      winRow = 0,
      winCol = 1,
      previewFloating = true,
      previewFloatingBorder = 'rounded',
      previewHeight = '&lines / 3 - 3',
      previewWidth = '&columns - 3',
      previewRow = 3,
      previewCol = '&columns / 2'
    },
    filter = {
      split = 'floating',
      floatingBorder = 'rounded',
      winHeight = '&lines / 3 - 3',
      winWidth = '&columns - 3',
      winRow = 0,
      winCol = 1,
      previewFloating = true,
      previewFloatingBorder = 'rounded',
      previewHeight = '&lines / 3 - 3',
      previewWidth = '&columns - 3',
      previewRow = 3,
      previewCol = '&columns / 2'
    },
  },
})

vim.fn["ddu#custom#patch_local"]('grep', {
  sourceParams = {
    rg = {
      args = {'--column', '--no-heading', '--color', 'never'},
    },
  },
  uiParams = {
    ff = {
      startFilter = false,
    }
  },
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "ddu-ff",
  callback = function()
    local opts = { buffer = true, silent = true }
    vim.opt_local.cursorline = true
    vim.keymap.set(
      'n',
      '<CR>',
      function() vim.fn["ddu#ui#do_action"]('itemAction', {name = 'open', params = {command = 'vsplit'}}) end,
      opts
    )
    vim.keymap.set(
      'n',
      '<Space>',
      function()
        vim.fn["ddu#ui#do_action"]('itemAction', {name = 'open', params = {command = 'split'}})
      end,
      opts
    )
    vim.keymap.set(
      'n',
      'i',
      function()
        vim.fn["ddu#ui#do_action"]('openFilterWindow')
      end,
      opts
    )
    vim.keymap.set(
      'n',
      'p',
      function()
        vim.fn["ddu#ui#do_action"]('preview')
      end,
      opts
    )
    vim.keymap.set(
      'n',
      'q',
      function()
        vim.fn["ddu#ui#do_action"]('quit')
      end,
      opts
    )
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ddu-ff-filter",
  callback = function()
    local opts = { buffer = true, silent = true }
    vim.keymap.set(
      'i',
      '<CR>',
      '<Esc><Cmd>close<CR>',
      opts
    )
    vim.keymap.set(
      'i',
      '<Esc>',
      '<Esc><Cmd>close<CR>',
      opts
    )
    vim.keymap.set(
      'n',
      '<CR>',
      '<Cmd>close<CR>',
      opts
    )
    vim.keymap.set(
      'n',
      '<Esc>',
      '<Cmd>close<CR>',
      opts
    )
    vim.keymap.set(
      'i',
      '<Up>',
      function ()
        vim.fn["ddu#ui#do_action"]('cursorPrevious')
      end,
      opts
    )
    vim.keymap.set(
      'i',
      '<Down>',
      function ()
        vim.fn["ddu#ui#do_action"]('cursorNext')
      end,
      opts
    )
  end
})

vim.keymap.set(
  'n',
  ';ff',
  function()
    vim.fn["ddu#start"]({ name = "file_recursive" })
  end,
  { silent = false }
)

vim.keymap.set(
  'n',
  ';fg',
  function()
    vim.fn["ddu#start"]({
      name = 'grep',
      sources = {
        {
          name = 'rg',
          params = {
            input = vim.fn["input"]('Pattern: ')
          }
        }
      }
    })
  end,
  { silent = false }
)
