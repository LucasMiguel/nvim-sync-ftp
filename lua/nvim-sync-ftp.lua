local cli = require("nvim-sync-ftp.cli")

local M = {}

function M.setup(opts)

  local config = cli.getConfig()

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

  if next(config) ~= nil then
    -- Config for on save
    if config.upload_to_save == 'true' then
      vim.api.nvim_create_augroup("SyncFtpUploadGroup", { clear = true })

      vim.api.nvim_create_autocmd("BufWritePost", {
          group = "SyncFtpUploadGroup",
          pattern = "*.*",
          callback = function(args)
              cli.Upload()
          end
      })
    end


  end

end

return M
