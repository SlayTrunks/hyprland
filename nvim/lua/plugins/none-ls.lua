return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim", -- Optional: provides extra sources like eslint_d
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- JavaScript/TypeScript
        require("none-ls.diagnostics.eslint_d"), -- Fast ESLint diagnostics

        -- Lua
        null_ls.builtins.formatting.stylua,

        -- JavaScript/TypeScript/HTML/CSS/etc.
        null_ls.builtins.formatting.prettier,

        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,

        -- === GO SOURCES (Add these for Go support) ===
        -- Recommended modern Go formatting & linting
        null_ls.builtins.formatting.gofumpt,     -- Stricter than gofmt
        null_ls.builtins.formatting.goimports_reviser, -- Better import organization
        null_ls.builtins.formatting.golines,     -- Long line wrapping (optional)

        -- Linting (highly recommended)
        null_ls.builtins.diagnostics.golangci_lint,
      },
    })

    -- Better keymap: format on <leader>gf (common convention)
    vim.keymap.set("n", "<leader>gh", vim.lsp.buf.format, { desc = "Format file" })
  end,
}
