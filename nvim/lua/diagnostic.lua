vim.diagnostic.config({
    virtual_text = {
        prefix = '●',        -- You can change to '■', '▎', '', etc. if you prefer
        source = "if_many",  -- NEW: Show source only if multiple diagnostics on same line
        spacing = 4,         -- NEW: Add some space for readability
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✖',
            [vim.diagnostic.severity.WARN]  = '⚠',
            [vim.diagnostic.severity.INFO]  = 'ℹ',
            [vim.diagnostic.severity.HINT]  = '➤',
        },
    },  -- NEW: Custom, clearer signs (optional but popular)
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",     -- NEW: Nicer floating window for :vim.diagnostic.open_float
        source = "always",      -- NEW: Always show source in hover
        header = "",
        prefix = "",
    },
})
