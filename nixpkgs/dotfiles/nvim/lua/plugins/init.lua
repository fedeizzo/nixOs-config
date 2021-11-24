local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute(
    '!git clone https://github.com/wbthomason/packer.nvim ' .. install_path
  )
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
  function()
    use {'wbthomason/packer.nvim', opt = true}
    -- UTILITY
    use 'ryanoasis/vim-devicons' -- icon support
    use 'kyazdani42/nvim-web-devicons' -- icon support
    use {
      'hoob3rt/lualine.nvim', -- status line
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
    }
    use 'itchyny/vim-cursorword' -- underline same work over cursor
    use 'rhysd/accelerated-jk' -- acccelerate up and down movment
    -- use 'kshenoy/vim-signature' -- print mark on the left
    use 'ggandor/lightspeed.nvim' -- easy motion between buffer
    use 'lukas-reineke/indent-blankline.nvim' -- indentation
    use 'windwp/nvim-autopairs' -- auto pairings
    use 'glepnir/dashboard-nvim' -- start page
    use 'lewis6991/gitsigns.nvim' -- git
    -- use {
    --   'lewis6991/spellsitter.nvim', -- humant lang spell
    --   config = function() require'spellsitter'.setup {
    --       hl = 'SpellBad',
    --       captures = {'comment'},  -- set to {} to spellcheck everything
    --     } end,
    -- }
    use 'folke/twilight.nvim' -- highlight portion of code

    -- LANGUAGE SUPPORT
    use {'elzr/vim-json', ft = 'json'}
    use {'SidOfc/mkdx', ft = 'markdown'}
    use {'alaviss/nim.nvim', ft = 'nim'}
    use {'pangloss/vim-javascript', ft = 'javascript'}
    use {'mxw/vim-jsx', ft = 'javascript'}
    use {'HerringtonDarkholme/yats.vim', ft = 'typescript'}
    use {'cespare/vim-toml', ft = 'toml'}
    use {'LnL7/vim-nix', ft = 'nix'}
    use {'tbastos/vim-lua', ft = 'lua'} -- 'tjdevries/nlua.nvim' TODO try this one
    use {'neovimhaskell/haskell-vim', ft = {'haskell', 'cabal'}}

    -- COMMENT
    use 'terrortylor/nvim-comment'

    -- CODE BLOCKS
    use 'hkupty/iron.nvim'

    -- TERMINAL
    use {"akinsho/toggleterm.nvim"}

    -- COLORSCHEME
    use 'NarutoXY/nvim-highlite'

    -- LSP / COMLETION / DAP
    use 'neovim/nvim-lspconfig'
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        {'hrsh7th/vim-vsnip'},
        {'hrsh7th/vim-vsnip-integ'},
        {'rafamadriz/friendly-snippets'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-latex-symbols'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-nvim-lua'},
        {'hrsh7th/cmp-vsnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'onsails/lspkind-nvim'},
      },
    }
    use 'nvim-lua/lsp-status.nvim'
    use 'mhartington/formatter.nvim'
    use {
      'mfussenegger/nvim-dap',
      requires = {
          {'theHamsta/nvim-dap-virtual-text'},
          {'rcarriga/nvim-dap-ui'}
      },
    }

    -- TREESITTER
    use {
      'nvim-treesitter/nvim-treesitter',
      commit = 'ecd9efd48611c42d7e51b50028788bf2b74b5c91',
      requires = {
        {'nvim-treesitter/nvim-treesitter-refactor'},
        {'romgrk/nvim-treesitter-context'},
        {'p00f/nvim-ts-rainbow'},
      },
    }

    -- TELESCOPE
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    }
  end
)
