local M = {}

M.config = function()
  local neoclip_req = { "tami5/sqlite.lua", module = "sqlite" }
  if lvim.builtin.neoclip.enable_persistent_history == false then
    neoclip_req = {}
  end
  lvim.plugins = {
    {
      "rose-pine/neovim",
      as = "rose-pine",
      config = function()
        require("user.theme").rose_pine()
        vim.cmd [[colorscheme rose-pine]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 1 and _time.hour < 9)
      end,
    },
    {
      "abzcoding/tokyonight.nvim",
      branch = "feat/local",
      config = function()
        require("user.theme").tokyonight()
        vim.cmd [[colorscheme tokyonight]]
      end,
      cond = function()
        local _time = os.date "*t"
        return _time.hour >= 9 and _time.hour < 17
      end,
    },
    {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        require("user.theme").catppuccin()
        vim.cmd [[colorscheme catppuccin]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 17 and _time.hour < 21)
      end,
    },
    {
      "rebelot/kanagawa.nvim",
      config = function()
        require("user.theme").kanagawa()
        vim.cmd [[colorscheme kanagawa]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 21 and _time.hour < 24) or (_time.hour >= 0 and _time.hour < 1)
      end,
    },
    {
      "ray-x/lsp_signature.nvim",
      config = function()
        require("user/lsp_signature").config()
      end,
      event = { "BufRead", "BufNew" },
    },
    {
      "vladdoster/remember.nvim",
      config = function()
        require("remember").setup {}
      end,
      event = "BufWinEnter",
      disable = not lvim.builtin.lastplace.active,
    },
    {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("user.todo_comments").config()
      end,
      event = "BufRead",
    },
    {
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup {
          auto_open = true,
          auto_close = true,
          padding = false,
          height = 10,
          use_diagnostic_signs = true,
        }
      end,
      cmd = "Trouble",
    },
    {
      "ggandor/lightspeed.nvim",
      config = function()
        require("user.lightspeed").config()
      end,
      disable = lvim.builtin.motion_provider ~= "lightspeed",
    },
    {
      "phaazon/hop.nvim",
      event = "BufRead",
      config = function()
        require("user.hop").config()
      end,
      disable = lvim.builtin.motion_provider ~= "hop",
    },
    {
      "simrat39/symbols-outline.nvim",
      setup = function()
        require("user.symbols_outline").config()
      end,
      event = "BufReadPost",
      disable = lvim.builtin.tag_provider ~= "symbols-outline",
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      setup = function()
        vim.g.indent_blankline_char = "▏"
      end,
      config = function()
        require("user.indent_blankline").config()
      end,
      event = "BufRead",
    },
    {
      "tzachar/cmp-tabnine",
      run = "./install.sh",
      requires = "hrsh7th/nvim-cmp",
      config = function()
        local tabnine = require "cmp_tabnine.config"
        tabnine:setup {
          max_lines = 1000,
          max_num_results = 10,
          sort = true,
        }
      end,
      opt = true,
      event = "InsertEnter",
      disable = not lvim.builtin.tabnine.active,
    },
    {
      "folke/twilight.nvim",
      config = function()
        require("user.twilight").config()
      end,
      event = "BufRead",
    },
    {
      "kevinhwang91/nvim-bqf",
      config = function()
        require("user.bqf").config()
      end,
      event = "BufRead",
    },
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
      ft = { "python", "rust", "go" },
      event = "BufReadPost",
      requires = { "mfussenegger/nvim-dap" },
      disable = not lvim.builtin.dap.active,
    },
    {
      "andymass/vim-matchup",
      event = "BufReadPost",
      config = function()
        vim.g.matchup_enabled = 1
        vim.g.matchup_surround_enabled = 1
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
    },
    {
      "folke/zen-mode.nvim",
      config = function()
        require("user.zen").config()
      end,
      event = "BufRead",
    },
    {
      "windwp/nvim-spectre",
      event = "BufRead",
      config = function()
        require("user.spectre").config()
      end,
    },
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("user.colorizer").config()
      end,
      event = "BufRead",
    },
    {
      "folke/persistence.nvim",
      event = "BufReadPre",
      module = "persistence",
      config = function()
        require("persistence").setup {
          dir = vim.fn.expand(get_cache_dir() .. "/sessions/"), -- directory where session files are saved
          options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
        }
      end,
      disable = not lvim.builtin.persistence.active,
    },
    {
      "andweeb/presence.nvim",
      config = function()
        require("user.presence").config()
      end,
      disable = not lvim.builtin.presence.active,
    },
    {
      "kristijanhusak/orgmode.nvim",
      keys = { "go", "gC" },
      ft = { "org" },
      config = function()
        require("user.orgmode").setup()
      end,
      disable = not lvim.builtin.orgmode.active,
    },
    {
      "danymat/neogen",
      config = function()
        require("neogen").setup {
          enabled = true,
        }
      end,
      event = "InsertEnter",
      requires = "nvim-treesitter/nvim-treesitter",
    },
    {
      "vim-test/vim-test",
      cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
      config = function()
        require("user.vim_test").config()
      end,
      disable = not lvim.builtin.test_runner.active,
    },
    {
      "jose-elias-alvarez/typescript.nvim",
      ft = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      opt = true,
      event = { "BufReadPre", "BufNew" },
      config = function()
        require("user.tss").config()
      end,
      before = "williamboman/nvim-lsp-installer",
    },
    {
      "lervag/vimtex",
      ft = "tex",
    },
    {
      "rcarriga/vim-ultest",
      cmd = { "Ultest", "UltestSummary", "UltestNearest" },
      wants = "vim-test",
      requires = { "vim-test/vim-test" },
      run = ":UpdateRemotePlugins",
      opt = true,
      event = { "BufEnter *_test.*,*_spec.*" },
      disable = not lvim.builtin.test_runner.active,
    },
    {
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("user.neoclip").config()
      end,
      opt = true,
      keys = "<leader>y",
      requires = neoclip_req,
      disable = not lvim.builtin.neoclip.active,
    },
    {
      "kristijanhusak/vim-dadbod-completion",
      disable = not lvim.builtin.sql_integration.active,
    },
    {
      "kristijanhusak/vim-dadbod-ui",
      cmd = {
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUI",
        "DBUIFindBuffer",
        "DBUIRenameBuffer",
      },
      requires = {
        {
          "tpope/vim-dadbod",
          opt = true,
        },
      },
      opt = true,
      disable = not lvim.builtin.sql_integration.active,
    },
    {
      "karb94/neoscroll.nvim",
      config = function()
        require("neoscroll").setup {
          easing_function = "quadratic",
        }
      end,
      event = "BufRead",
      disable = lvim.builtin.smooth_scroll ~= "neoscroll",
    },
    {
      "declancm/cinnamon.nvim",
      config = function()
        require("cinnamon").setup {
          default_keymaps = true,
          extra_keymaps = true,
          extended_keymaps = false,
          centered = true,
          scroll_limit = 100,
        }
      end,
      event = "BufRead",
      disable = lvim.builtin.smooth_scroll ~= "cinnamon",
    },
    {
      "github/copilot.vim",
      config = function()
        require("user.copilot").config()
      end,
      disable = not lvim.builtin.sell_your_soul_to_devil.active or lvim.builtin.sell_your_soul_to_devil.prada,
    },
    {
      "zbirenbaum/copilot.lua",
      after = "nvim-cmp",
      requires = { "zbirenbaum/copilot-cmp" },
      config = function()
        local cmp_source = { name = "copilot", group_index = 2 }
        table.insert(lvim.builtin.cmp.sources, cmp_source)
        vim.defer_fn(function()
          require("copilot").setup()
        end, 100)
      end,
      disable = not lvim.builtin.sell_your_soul_to_devil.prada,
    },
    {
      "ThePrimeagen/harpoon",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-lua/popup.nvim" },
      },
      disable = not lvim.builtin.harpoon.active,
    },
    {
      "sindrets/diffview.nvim",
      opt = true,
      cmd = { "DiffviewOpen", "DiffviewFileHistory" },
      module = "diffview",
      keys = "<leader>gd",
      setup = function()
        require("which-key").register { ["<leader>gd"] = "diffview: diff HEAD" }
      end,
      config = function()
        require("diffview").setup {
          enhanced_diff_hl = true,
          key_bindings = {
            file_panel = { q = "<Cmd>DiffviewClose<CR>" },
            view = { q = "<Cmd>DiffviewClose<CR>" },
          },
        }
      end,
      disable = not lvim.builtin.fancy_diff.active,
    },
    {
      "chipsenkbeil/distant.nvim",
      opt = true,
      run = { "DistantInstall" },
      cmd = { "DistantLaunch", "DistantRun" },
      config = function()
        require("distant").setup {
          ["*"] = vim.tbl_extend(
            "force",
            require("distant.settings").chip_default(),
            { mode = "ssh" } -- use SSH mode by default
          ),
        }
      end,
      disable = not lvim.builtin.remote_dev.active,
    },
    {
      "nathom/filetype.nvim",
      config = function()
        require("user.filetype").config()
      end,
    },
    {
      "Nguyen-Hoang-Nam/nvim-mini-file-icons",
      config = function()
        require("user.dev_icons").set_icon()
      end,
      disable = lvim.use_icons or not lvim.builtin.custom_web_devicons,
    },
    {
      "nvim-telescope/telescope-live-grep-raw.nvim",
    },
    { "mtdl9/vim-log-highlighting", ft = { "text", "log" } },
    {
      "yamatsum/nvim-cursorline",
      opt = true,
      event = "BufWinEnter",
      disable = not lvim.builtin.cursorline.active,
    },
    {
      "abecodes/tabout.nvim",
      wants = { "nvim-treesitter" },
      after = { "nvim-cmp" },
      config = function()
        require("user.tabout").config()
      end,
      disable = not lvim.builtin.sell_your_soul_to_devil,
    },
    {
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("user.hlslens").config()
      end,
      event = "BufReadPost",
      disable = not lvim.builtin.hlslens.active,
    },
    {
      "kosayoda/nvim-lightbulb",
      config = function()
        vim.fn.sign_define(
          "LightBulbSign",
          { text = require("user.lsp_kind").icons.code_action, texthl = "DiagnosticInfo" }
        )
      end,
      event = "BufRead",
      ft = { "rust", "go", "typescript", "typescriptreact" },
    },
    {
      "chrisbra/csv.vim",
      ft = { "csv" },
      disable = not lvim.builtin.csv_support,
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
    },
    {
      "sidebar-nvim/sidebar.nvim",
      config = function()
        require("user.sidebar").config()
      end,
      -- event = "BufRead",
      disable = not lvim.builtin.sidebar.active,
    },
    {
      "skywind3000/asynctasks.vim",
      requires = {
        { "skywind3000/asyncrun.vim" },
      },
      setup = function()
        vim.cmd [[
          let g:asyncrun_open = 8
          let g:asynctask_template = '~/.config/lvim/task_template.ini'
          let g:asynctasks_extra_config = ['~/.config/lvim/tasks.ini']
        ]]
      end,
      event = "BufRead",
      disable = not lvim.builtin.async_tasks.active,
    },
    {
      "scalameta/nvim-metals",
      requires = { "nvim-lua/plenary.nvim" },
      disable = not lvim.builtin.metals.active,
    },
    {
      "jbyuki/instant.nvim",
      event = "BufRead",
      disable = not lvim.builtin.collaborative_editing.active,
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      disable = not lvim.builtin.file_browser.active,
    },
    {
      "j-hui/fidget.nvim",
      config = function()
        require("user.fidget_spinner").config()
      end,
    },
    {
      "michaelb/sniprun",
      run = "bash ./install.sh",
      disable = not lvim.builtin.sniprun.active,
    },
    {
      "liuchengxu/vista.vim",
      setup = function()
        require("user.vista").config()
      end,
      event = "BufReadPost",
      disable = lvim.builtin.tag_provider ~= "vista",
    },
    {
      "p00f/clangd_extensions.nvim",
      config = function()
        require("user.cle").config()
      end,
      ft = { "c", "cpp", "objc", "objcpp" },
    },
    {
      "editorconfig/editorconfig-vim",
      event = "BufRead",
      disable = not lvim.builtin.editorconfig.active,
    },
    {
      "saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        require("user.crates").config()
      end,
    },
    {
      "hrsh7th/cmp-cmdline",
      disable = not lvim.builtin.fancy_wild_menu.active,
    },
    {
      "gfeiyou/command-center.nvim",
      config = function()
        require("user.cc").config()
      end,
      requires = "nvim-telescope/telescope.nvim",
    },
    {
      "stevearc/dressing.nvim",
      config = function()
        require("user.dress").config()
      end,
      disable = not lvim.builtin.dressing.active,
      event = "BufWinEnter",
    },
    {
      "kdheepak/cmp-latex-symbols",
      requires = "hrsh7th/nvim-cmp",
      ft = "tex",
    },
    {
      "ThePrimeagen/refactoring.nvim",
      ft = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "php" },
      event = "BufRead",
      config = function()
        require("refactoring").setup {}
      end,
      disable = not lvim.builtin.refactoring.active,
    },

    -- end of abz config
    {
      'vim-scripts/DoxygenToolkit.vim',
      cmd = "Dox",
      setup = function ()
        vim.g.DoxygenToolkit_commentType = "C++"
      end
    },
    {
      "f-person/git-blame.nvim",
      event = "BufRead",
      config = function()
        vim.cmd "highlight default link gitblame SpecialComment"
        vim.g.gitblame_enabled = 0
      end,
    },
    {
      "p00f/nvim-ts-rainbow",
      event = "BufWinEnter",
    },
    {
      "tpope/vim-fugitive",
      cmd = {
        "G",
        "Git",
        "Gdiffsplit",
        "Gread",
        "Gwrite",
        "Ggrep",
        "GMove",
        "GDelete",
        "GBrowse",
        "GRemove",
        "GRename",
        "Glgrep",
        "Gedit",
        "Gvdiff",
      },
      ft = {"fugitive"}
    }
  }
end

return M
