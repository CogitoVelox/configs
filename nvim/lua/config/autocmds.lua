-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Function to setup .ino files as C++
local function setup_arduino_files()
  -- Set filetype to cpp for .ino files
  vim.api.nvim_command("set filetype=cpp")
  -- Set the comment string for C++ files
  vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
end

-- Create an autocommand group for Arduino setup
vim.api.nvim_create_augroup("ArduinoSetup", { clear = true })

-- Autocommand to run setup function for .ino files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ino",
  group = "ArduinoSetup",
  callback = setup_arduino_files,
})
