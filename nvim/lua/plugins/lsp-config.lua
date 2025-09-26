return {

    {

        "princejoogie/tailwind-highlight.nvim",
    },

    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "tailwindcss",
                    "prismals",
                    "rust_analyzer",
                    "cssls",
                    "emmet_ls",
                    "eslint",
                    "graphql",
                    "html",
                    "jsonls",
                    "nextls",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set({ "n", "v" }, "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "gD", vim.lsp.buf.declaration, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })

            lspconfig.ts_ls.setup({
                capabilities = capabilities
            })

            lspconfig.rust_analyzer.setup({
                    capabilities = capabilities,
                 settings = {
                    ["rust-analyzer"] = {
                        inlayHints = {
                            enable = true,
                            typeHints = true,
                            parameterHints = true,
                            chainingHints = true,
                        },
                        diagnostics = {
                            enable = true,
                        },
                        hover = {
                            actions = {
                                enable = true,
                            },
                            memoryLayout = {
                                enable = true,
                            },
                        },
                    },
                },
            })
            lspconfig.tailwindcss.setup({
                    capabilities = capabilities,
                 on_attach = function(client, bufnr)
                    require("tailwind-highlight").setup(client, bufnr, {
                        single_column = false,
                        mode = "background",
                        debounce = 200,
                    })
                end,
            })
        end,
    },
}
