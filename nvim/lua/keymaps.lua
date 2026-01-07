vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
vim.g.mapleader = " "
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.scrolloff = 8
vim.o.smoothscroll = true  -- New in Neovim 0.10+ – smoother scrolling with scrolloff
vim.o.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.incsearch = true          -- Show matches while typing
vim.opt.ignorecase = true         -- Case-insensitive search...
vim.opt.smartcase = true          -- ...unless uppercase is used
vim.opt.updatetime = 50

vim.opt.termguicolors = true
vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode" }) -- Better escape (jj in insert mode)

-- Move lines up/down (great in normal & visual mode)
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.opt.colorcolumn = "80"
vim.opt.number = true
vim.opt.relativenumber = true
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>y', '"+yy', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>pp', '"+p', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>pp', '"+p', { noremap = true })
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, {})
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, {})
