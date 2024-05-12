local dap = require('dap')
dap.configurations.go = {}
require('dapui').setup()
require('dap-go').setup {
  dap_configurations = {
    {
      type = "go",
      name = "Debug test",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
      env = {
        LYNX_MYSQL_HOST = '127.0.0.1:33066',
        LYNX_APP_HOME = "${workspaceFolder}",
      },
    }
  },
}
