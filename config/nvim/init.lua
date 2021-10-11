require('plugins')  -- lua/plugins.lua

vim.cmd("colorscheme edge")
vim.cmd("set undofile")

local opts = {noremap = true, silent = true}
local mappings = {
	-- Disable arrow keys
	{"n", "<down>", "<nop>", opts},
	{"n", "<left>", "<nop>", opts},
	{"n", "<right>", "<nop>", opts},
	{"i", "<up>", "<nop>", opts},
	{"i", "<down>", "<nop>", opts},
	{"i", "<left>", "<nop>", opts},
	{"i", "<right>", "<nop>", opts},
	{"v", "<up>", "<nop>", opts},
	{"v", "<down>", "<nop>", opts},
	{"v", "<left>", "<nop>", opts},
	{"v", "<right>", "<nop>", opts},
    -- Move within splits with alt+{h,j,k,l}
	{"n", "<C-h>", "<C-w>h", opts},
	{"n", "<C-j>", "<C-w>j", opts},
	{"n", "<C-k>", "<C-w>k", opts},
	{"n", "<C-l>", "<C-w>l", opts},
	{"n", "<c-right>", [[<Cmd>tabnext<CR>]], opts},
	{"n", "<c-left>", [[<Cmd>tabprevious<CR>]], opts},
    -- Normal
    {"n", "j", "gj", opts},
    {"n", "k", "gk", opts},
    -- Term
	{"t", "<C-d>", "<C-\\><C-n>", opts},
    -- Visual
    {"v", "<", "<gv", opts},
    {"v", ">", ">gv", opts}
}

for i = 1, 8 do
    local v = {"n","<A-"..i..">", i.."gt", opts}
    table.insert(mappings,v)
end

for _, map in pairs(mappings) do
	vim.api.nvim_set_keymap(unpack(map))
end

require 'nvim-treesitter.configs'.setup {
  highlight = { enable = true }
}

local utils = require("modules.utils")

local autocmds = {
	general = {
        --{'InsertLeave *.qml exec "!qmlformat -i % <cr>l"'}
        --{"BufWinEnter * match ExtraWhitespace /\s\+$/"},
        --{'InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/'},
        --{'InsertLeave * match ExtraWhitespace /\s\+$/'},
        --{'BufWinLeave * call clearmatches()'}
		-- Exit netrw with esc
--		{'Filetype netrw nnoremap <buffer> <esc> <C-^>'},
		-- Spell check
--		{'FileType nroff,mail set spell spelllang=pt_br | set tw=80'},
--		{'FileType markdown set spell spelllang=en | set tw=80'},
--		{'FileType haskell set expandtab'},
		-- Make when saving .ms groff files
--		{'BufWritePost *.ms :silent exec "!make"'},
	}
}

utils.nvim_create_augroups(autocmds)

require'lspconfig'.clangd.setup{}
require'lspconfig'.zls.setup{}

local path_to_elixirls = vim.fn.expand("/home/build/hub/elixir-ls/release/language_server.sh")
require'lspconfig'.elixirls.setup({
  cmd = {path_to_elixils},
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    elixirLS = {
      -- I choose to disable dialyzer for personal reasons, but
      -- I would suggest you also disable it unless you are well
      -- aquainted with dialzyer and know how to use it.
      dialyzerEnabled = false,
      -- I also choose to turn off the auto dep fetching feature.
      -- It often get's into a weird state that requires deleting
      -- the .elixir_ls directory and restarting your editor.
      fetchDeps = false
    }
  }
})

require('settings')  -- lua/settings.lua

require('lualine').setup {
  options = {
    theme = 'molokai',
    icons_enabled = true
  };
}
