local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- globals options
o.swapfile = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.autoread = true

-- window-local options
wo.number = true
wo.relativenumber = true
wo.breakindent = true
wo.colorcolumn = '120'

-- buffer-local options
bo.undofile = true

bo.expandtab = true      -- use spaces instead of tabs
bo.shiftwidth = 4        -- shift 4 spaces when tab
-- bo.softtabstop = 4
bo.tabstop = 4           -- 1 tab == 4 spaces
bo.smartindent = true    -- autoindent new lines

bo.expandtab = true
bo.swapfile = false

local cmd = vim.cmd

cmd(':command! WQ wq')
cmd(':command! WQ wq')
cmd(':command! Wq wq')
cmd(':command! Wqa wqa')
cmd(':command! W w')
cmd(':command! Q q')

-- remove whitespace on save
cmd([[au BufWritePre * :%s/\s\+$//e]])

-- 2 spaces for selected filetypes
cmd([[
autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]])

-- Mappings.
local opts = { noremap=true, silent=true }
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
