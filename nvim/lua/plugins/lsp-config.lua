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
                    "gopls", -- Go (essential now that you're using Go)
                    "ts_ls", -- TypeScript/JavaScript (modern name)
                    "pyright", -- Python (fast & type-aware, better than pylsp for most)
                    "lua_ls", -- Lua (Neovim config)
                    "rust_analyzer", -- Rust

                    -- Web/Frontend
                    "html",
                    "cssls",
                    "tailwindcss",
                    "emmet_ls",
                    "eslint", -- ESLint as LSP (code actions, fixes)
                    "jsonls",
                    "graphql",

                    -- Framework/Backend
                    "prismals", -- Prisma
                    "nextls", -- Next.js specific (Elixir-based)

                    -- Optional but useful (you had them manually)
                    "pylsp",
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
                capabilities = capabilities,
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
