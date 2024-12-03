local message = require("nvim-sync-ftp.message")
local directory = vim.fn.getcwd();
local filePath = directory .. "/.sync-ftp-config"
local config = {}

local M = {}

local function file_exists()
  return vim.loop.fs_stat(filePath) ~= nil
end

local function create_file()

  local buf = vim.api.nvim_create_buf(true, true)

  vim.api.nvim_buf_set_name(buf, filePath)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { 
        "host hostName" , 
        "user userName",
        "password password",
        "port 21",
        "remote_path /remote/",
        "upload_to_save  false",
  })

  vim.api.nvim_buf_set_option(buf, "buftype", "")

  vim.api.nvim_buf_call(buf, function()
    vim.cmd("write")
  end)

  vim.api.nvim_win_set_buf(0, buf)

  message.success("File created successfully!!!")

end

function M.MapToRemote ()

  if file_exists() then
    message.warn("File already exists!!!");
  else
    create_file()
  end

end

local function read_file(path)
  local file = io.open(path, "r")

  if not file then
    return nil, "Config file not found!"
  end

  local lines = {}
  for line in file:lines() do
    table.insert(lines, line)
  end
  file:close()
  return lines
end

local function getConfig()
  if file_exists() then
    local content, err = read_file(filePath)

    if content then
      for i, line in ipairs(content) do
        local first_word, second_word = line:match("^(%S+)%s+(%S+)$")
        config[first_word] = second_word
     end
    else
      message(err);
    end
  else
    message.error("Config file not found!")
  end
end

function M.Upload()
  getConfig()
  local current_buffer_path = vim.api.nvim_buf_get_name(0)
  local directoryTemp = directory
  
  -- message.warn("Send file ... Wait")

  if not directoryTemp:match("/$") then
    directoryTemp = directoryTemp .. "/"
  end

  local relative_path = current_buffer_path:sub(#directoryTemp + 1)
 
  if not config.remote_path:match("/$") then
    config.remote_path = config.remote_path .. "/"
  end

  local remotePath = config.remote_path .. relative_path
  
  local ftp_script = string.format([[
  open %s
  user %s %s
  put %s %s
  bye
  ]], config.host, config.user, config.password, current_buffer_path, remotePath)
  

  local script_file = "ftp_commands.txt"
  local file = io.open(script_file, "w")
  file:write(ftp_script)
  file:close()

  local log_file = "/tmp/ftp_log.txt"
  
  local exit_code = os.execute(string.format("ftp -n < %s > %s 2>&1", script_file, log_file))
 

  local log = io.open(log_file, "r")
  local log_content = log:read("*a")
  log:close()

  if log_content:match("Error") or log_content:match("fail") then
    message.error("Fail to upload file!" .. log_content)
  else
    message.success("File send successfully!")
  end

  os.remove(script_file)
  os.remove(log_file)

end

return M
