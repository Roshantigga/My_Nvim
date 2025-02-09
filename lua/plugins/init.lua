return {
    -- Treesitter for syntax highlighting and parsing
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("configs.treesitter")
        end,
    },

    -- LSP configuration
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- Load NvChad defaults if needed
            require("nvchad.configs.lspconfig").defaults()
            -- Load custom LSP configurations
            require("configs.lspconfig")
        end,
    },

    -- Formatting with Conform
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- Format on save
        config = function()
            require("configs.conform")
        end,
    },
}
