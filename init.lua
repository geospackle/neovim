local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
require('lazy').setup({
    --{
        --"jackMort/ChatGPT.nvim",
        --config = function()
            --require("chatgpt").setup()
        --end,
        --dependencies = {
            --"MunifTanjim/nui.nvim",
            --"nvim-lua/plenary.nvim",
            --"folke/trouble.nvim",
            --"nvim-telescope/telescope.nvim"
        --}
    --},
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    'm4xshen/autoclose.nvim',
    'theHamsta/nvim-dap-virtual-text',
    {
        'williamboman/mason.nvim',
        opts = {
            ensure_installed = {
                "pyright",
                "mypy",
                "black",
                "debugpy",
                "ruff-lsp",
                "ruff"
            }
        }
    },
    { 'williamboman/mason-lspconfig.nvim' },

    'mfussenegger/nvim-dap',
    'mfussenegger/nvim-dap-python',
    'mfussenegger/nvim-lint',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" }
    },
    --use { 'neovim/nvim-lspconfig' }
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support
        }
    },
    --use { 'nvim-lua/completion-nvim' },
    -- Snippets,
    --use { 'norcalli/snippets.nvim' },
    --use { 'honza/vim-snippets' },
    --use { 'SirVer/ultisnips' },
    {
        'nvimdev/guard.nvim',
        -- Builtin configuration, optional
        dependencies = {
            "nvimdev/guard-collection",
        },
    },
    'morhetz/gruvbox',
    'tmhedberg/SimpylFold',
    'metakirby5/codi.vim',
    'preservim/nerdcommenter',
    { 'nvim-treesitter/nvim-treesitter',  run = ':TSUpdate' },
    'vim-airline/vim-airline',
    'vim-airline/vim-airline-themes',
    'ray-x/go.nvim',
    'ray-x/guihua.lua', -- floating window support
    'julienr/vim-cellmode',
    'christoomey/vim-tmux-runner',
    'christoomey/vim-tmux-navigator',
    'tpope/vim-surround',
    'tpope/vim-fugitive',
    'LucHermitte/lh-vim-lib',
    --use 'LucHermitte/lh-brackets',
    'hashivim/vim-terraform',
    'github/copilot.vim',
})

require('lint').linters_by_ft = {
    yaml = { 'yamllint', 'actionlint' }
}

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright" }
})
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "vim", "vimdoc", "query", "python", "go" },
}


require("mason").setup()
require("mason-nvim-dap").setup()
require("dapui").setup()

vim.g.copilot_no_tab_map = true

-- Go
require('go').setup()

require("nvim-dap-virtual-text").setup()
require("autoclose").setup()
--require("chatgpt").setup()

require('keybindings')
require('plugins')
require('functions')
require('configs')
vim.cmd('colorscheme gruvbox')
