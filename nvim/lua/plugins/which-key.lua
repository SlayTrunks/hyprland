return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",           -- Clean, modern look
    delay = 60,                -- Slightly longer than default for comfort
    win = {
      border = "rounded",
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")

    wk.setup(opts)

    -- Register your <leader> groups and keymaps
    wk.add({
      { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", desc = "Harpoon: Add file" },
      { "<leader>gh", vim.lsp.buf.format, desc = "Format current buffer" },
      { "<leader>y",  group = "Yank to System Clipboard" },
      { "<leader>yy", "<cmd>yank to clipboard in normal mode<CR>", hidden = true }, -- hidden because it's covered by group
      { "<leader>p",  group = "Paste from System Clipboard" },
      { "<leader>pp", hidden = true }, -- hidden, will show as part of group
      { "<leader>d",  group = "Diagnostics" },
      { "<leader>dn", vim.diagnostic.goto_next, desc = "Next diagnostic" },
      { "<leader>dp", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
      -- Add more groups as you create keymaps!
    })
  end,
}
