return {

    {

        "hrsh7th/cmp-nvim-lsp",
    },

    {

        "L3MON4D3/LuaSnip",

        dependencies = {

            "saadparwaiz1/cmp_luasnip",

            "rafamadriz/friendly-snippets",
        },
        config = function()
            local luasnip = require("luasnip")

            -- This line tells LuaSnip to also load HTML snippets
            -- when the filetype is 'javascriptreact' (used for JSX/TSX).
            luasnip.filetype_extend("javascriptreact", { "html" })
            luasnip.filetype_extend("typescriptreact", { "html" })

            -- OPTIONAL: You might also want to load the snippets here
            -- to avoid the race condition discussed in previous interactions.
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    {

        "hrsh7th/nvim-cmp",

        config = function()
            local cmp = require("cmp")
            local ls = require("luasnip") -- Use local variable for luasnip

            -- REMOVED: Redundant call to require("luasnip.loaders.from_vscode").lazy_load()
            -- It is now only in the LuaSnip config block above.

            cmp.setup({

                snippet = {

                    expand = function(args)
                        ls.lsp_expand(args.body)
                    end,
                },

                window = {

                    completion = cmp.config.window.bordered(),

                    documentation = cmp.config.window.bordered(),
                },

                mapping = cmp.mapping.preset.insert({

                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),

                    ["<C-f>"] = cmp.mapping.scroll_docs(4),

                    ["<C-Space>"] = cmp.mapping.complete(),

                    ["<C-e>"] = cmp.mapping.abort(),

                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),

                sources = cmp.config.sources({

                    {

                        name = "nvim_lsp",

                        entry_filter = function(entry, ctx)
                            return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
                        end,
                    },

                    {

                        name = "luasnip",

                        -- The key/value pairs must be in the source table itself.
                        group_index = 1,
                        option = { use_show_condition = true },

                        -- 🎯 The filtering logic MUST be inside the entry_filter function 🎯
                        entry_filter = function(entry, ctx)
                            local context = require("cmp.config.context")
                            local text = entry:get_insert_text() or entry:get_text()

                            -- 1. Inherit the existing filter (prevents expansion inside strings)
                            local is_not_in_string = not context.in_treesitter_capture("string") and not context.in_syntax_group("String")

                            -- 2. Define custom filter for low-value generic snippets
                            -- This attempts to hide extremely generic HTML/CSS triggers when more specific ones exist.
                            local is_not_generic_di = true
                            if vim.bo.filetype == 'javascriptreact' or vim.bo.filetype == 'typescriptreact' or vim.bo.filetype == 'html' then
                                -- Hide "di" if it's not "div" (assuming "di" is just a prefix)
                                if text == 'di' then
                                    is_not_generic_di = false
                                end

                                -- Hide the 'useState' generic snippet if the full 'useState' function is also available
                                -- (This is trickier without full knowledge of all sources, but if the trigger is 
                                -- a generic name like 'useStateSnippet~', you can hide it)
                                if text:match('Snippet~') then 
                                    -- OPTIONAL: You might want to remove all snippets that end in 'Snippet~'
                                    -- or manually list the ones you want to hide, like 'useStateSnippet~'
                                    -- is_not_generic_di = false
                                end
                            end

                            return is_not_in_string and is_not_generic_di
                        end, -- End of entry_filter function

                    }, -- For luasnip users.
                }, {

                    { name = "buffer" },
                }),
            })
        end,
    },
}
