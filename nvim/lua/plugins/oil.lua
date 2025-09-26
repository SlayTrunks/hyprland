return {
  "stevearc/oil.nvim",
  opts = {},
  config = function()
    require("oil").setup({
      default_file_explorer = true,
    })
    -- Optional: keymap to open Oil in the current directory
    vim.keymap.set("n", "<leader>pv", require("oil").open, { desc = "Open parent directory (Oil)" })
  end,
}

