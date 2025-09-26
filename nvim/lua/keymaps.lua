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
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.opt.number = true
vim.opt.relativenumber = true
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>y', '"+yy', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>pp', '"+p', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>pp', '"+p', { noremap = true })
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, {})
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, {})
