return {
	{ "hrsh7th/cmp-nvim-lsp" },

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
			require("luasnip.loaders.from_vscode").lazy_load({
				exclude = {  "javascriptreact",  "typescriptreact" },
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-cmdline", -- Added for cmdline completion
		},
		config = function()
			local cmp = require("cmp")
			local ls = require("luasnip") -- Use local variable for luasnip

			cmp.setup({
                preselect = cmp.PreselectMode.None,  -- NEW: No auto-preselect from gopls
                completion = {
                    completeopt = "menu,menuone,noselect",  -- NEW: Reinforces no preselect
                },
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

					-- === ADDED: Tab and Shift-Tab for navigation + snippet jumping ===
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif ls.expand_or_jumpable() then
							ls.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif ls.jumpable(-1) then
							ls.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
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
							local is_not_in_string = not context.in_treesitter_capture("string")
								and not context.in_syntax_group("String")
							-- 2. Define custom filter for low-value generic snippets
							local is_not_generic_di = true
							if
								vim.bo.filetype == "javascriptreact"
								or vim.bo.filetype == "typescriptreact"
								or vim.bo.filetype == "html"
							then
								-- Hide "di" if it's not "div"
								if text == "di" then
									is_not_generic_di = false
								end
								-- Hide generic snippets ending with 'Snippet~'
								if text:match("Snippet~") then
									is_not_generic_di = false
								end
							end
							return is_not_in_string and is_not_generic_di
						end,
					},
				}, {
					{ name = "buffer" },
				}),
			})

			-- === ADDED: cmp-cmdline support ===
			-- Command-line completion (for : commands)
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline", keyword_length = 2 },
				}),
			})

			-- Search completion (for / and ?)
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
		end,
	},
}
