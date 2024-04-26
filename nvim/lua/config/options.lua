-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "80"

vim.opt.tags = "./tags;,"

vim.opt.clipboard = "unnamedplus"

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
vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
  pattern = "*.ino",
  group = "ArduinoSetup",
  callback = setup_arduino_files,
})
