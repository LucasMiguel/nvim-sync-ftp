
# Plugins for syncronization in FTP servers

Plugins for syncronization in FTP servers

## Installation

Install with your plugin manager.

Lazy.nvim
```bash
    {
        "LucasMiguel/nvim-sync-ftp",    
        config = function ()
            require('nvim-sync-ftp').setup()
        end
    }
```


## Settings

Create a file named `.sync-ftp-config` in the project root, or run the command `:SyncFtpMapToRemote` which will automatically create the file in root path. After change it to the server credentials.

`.sync-ftp-config`
```bash
    host host.com
    user user_name
    password  password
    port 22
    remote_path /root_remote/
    upload_to_save false 
```

**host**: IP server

**user**: User name

**password**: Password 

**port**: Port server

**remote_path**: Root path remote

**upload_to_save**: (true|false) - Setting to send file when saving


## Commands

`:SyncFtpMapToRemote`: Create configuration file in root directory

`:SyncFtpUpload`: Upload file from current open Buffer
