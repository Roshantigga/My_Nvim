---@type ChadrcConfig
local M = {}

local overrides = require("configs.overrides")

M.ui = {
    theme = "onedark",
}

-- Merge overrides without replacing the theme
M.ui = vim.tbl_deep_extend("force", M.ui, overrides.ui or {})

-- Key mappings for tab management
vim.api.nvim_set_keymap("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tl", "gt", { noremap = true, silent = true }) -- Next tab
vim.api.nvim_set_keymap("n", "<leader>th", "gT", { noremap = true, silent = true }) -- Previous tab

return M

