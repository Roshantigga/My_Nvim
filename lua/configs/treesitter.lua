local options = {
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "fish",
        "lua",
        "luadoc",
        "make",
        "printf",
        "python",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
        "go",
    },

    highlight = {
        transperent = true,
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
