local plugins = {
    {
    "williamboman/mason.nvim",
    opts = {
        ensure_installed = {
            "pyright",
        },
    },
  },  
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lsconfig"
            require "custom.configs.lspconfig"
        end,
    },
}
return plugins
