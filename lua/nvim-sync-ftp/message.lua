local levels = vim.log.levels

local M = {}

--- @type fun(fmt: string, ...: string)
M.warn = vim.schedule_wrap(function(fmt, ...)
  vim.notify(fmt:format(...), levels.WARN, { title = 'Sync FTP' })
end)

--- @type fun(fmt: string, ...: string)
M.info = vim.schedule_wrap(function(fmt, ...)
  vim.notify(fmt:format(...), vim.log.INFO, { title = 'Sync FTP' })
end)

--- @type fun(fmt: string, ...: string)
M.error = vim.schedule_wrap(function(fmt, ...)
  vim.notify(fmt:format(...), vim.log.levels.ERROR, { title = 'Sync FTP' })
end)

--- @type fun(fmt: string, ...: string)
M.error_once = vim.schedule_wrap(function(fmt, ...)
  vim.notify_once(fmt:format(...), vim.log.levels.ERROR, { title = 'Sync FTP' })
end)

M.success = vim.schedule_wrap(function(fmt, ...)
  vim.notify(fmt:format(...), vim.log.INFO, { title = 'Sync FTP'})
end)

return M
