local dap = require("dap")
local dapui = require("dapui")

require("dapui").setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  vim.opt["mouse"] = "a"
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  vim.opt["mouse"] = ""
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  vim.opt["mouse"] = ""
  dapui.close()
end
