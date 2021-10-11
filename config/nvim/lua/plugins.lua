-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    use 'tpope/vim-fugitive'
    use 'toniz4/vim-stt'
    use 'peterhoeg/vim-qml'
    use 'airblade/vim-gitgutter'
    use 'neovim/nvim-lspconfig'
    use 'tpope/vim-vinegar'
    use 'tpope/vim-commentary'
    use 'sainnhe/edge'
    use 'nvim-treesitter/nvim-treesitter'
    use 'junegunn/seoul256.vim'
    use 'ziglang/zig.vim'
    use "hoob3rt/lualine.nvim"
		use 'elixir-editors/vim-elixir'
end)
