-- -- Set the colorscheme to tokyonight using a protected call
-- -- in case it isn't installed
-- local status, _ = pcall(vim.cmd, "colorscheme elflord")
-- if not status then
--     print("Colorscheme not found!") -- Print an error message if the colorscheme is not installed
-- return
-- end

vim.cmd("colorscheme elflord")
