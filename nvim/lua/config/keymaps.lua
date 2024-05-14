-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Setup key mappings in normal and visual modes to delete text without saving it to any register
local function setup_mappings()
    -- Normal mode mappings
    vim.api.nvim_set_keymap('n', 'd', '"_d', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', 'dd', '"_dd', {noremap = true, silent = true})

    -- Visual mode mappings
    vim.api.nvim_set_keymap('v', 'd', '"_d', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('v', 'dd', '"_dd', {noremap = true, silent = true})
end

-- Call the function to apply the mappings
setup_mappings()
