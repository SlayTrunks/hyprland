return {
	"nvimtools/none-ls.nvim",

	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {

				require("none-ls.diagnostics.eslint_d"), -- for eslint_d diagnostic
				null_ls.builtins.formatting.stylua, --for lua
				null_ls.builtins.formatting.prettier, --for js/ts
				null_ls.builtins.formatting.black, --for python
				null_ls.builtins.formatting.isort, --for python
				-- install stylua,prettier,black,isort from :Mason
			},
		})
		vim.keymap.set("n", "<leader>gh", vim.lsp.buf.format, {})
	end,
}
