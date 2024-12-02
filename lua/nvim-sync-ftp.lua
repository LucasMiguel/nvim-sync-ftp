local cli = require("nvim-sync-ftp.cli")

local M = {}

function M.setup(opts)
  vim.api.nvim_create_user_command("SyncFtpMapToRemote", function (params)
    cli.MapToRemote(params)
  end,{
    force = true,
    nargs = '*',
    range = true,
  })

  vim.api.nvim_create_user_command("SyncFtpUpload", function(params)
    cli.Upload()
  end,{
    force = true,
    nargs = '*',
    range = true,
  })
end

return M
