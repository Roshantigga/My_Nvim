-- Load default settings from NvChad
local nvlsp = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")

-- List of servers to configure
local servers = {
    "html",
    "cssls",
    "pyright",
    "lua_ls",
    "clangd",
}

-- Configure all servers with default settings
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = nvlsp.on_attach, -- Attach default on_attach
        on_init = nvlsp.on_init,     -- Attach default on_init
        capabilities = nvlsp.capabilities, -- Use default capabilities
    })
end

-- Function to format code on save
local function format_on_save(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
end

-- Configure clangd with additional settings
lspconfig.clangd.setup({
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
    capabilities = nvlsp.capabilities,
    on_attach = function(client, bufnr)
        nvlsp.on_attach(client, bufnr)
        format_on_save(client, bufnr)
    end,
})

-- Configure pyright for Python
lspconfig.pyright.setup({
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "strict",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
})

-- Configure Lua language server with custom settings
lspconfig.lua_ls.setup({
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = {
        Lua = {
            diagnostics = {
                enable = false, -- Disable all diagnostics from lua_ls
            },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})

-- Keybinding for manual formatting
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { noremap = true, silent = true, desc = "Format Code" })

