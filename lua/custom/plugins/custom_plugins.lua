return {
  -- THIS ONE IS MY OWN CUSTOM ADDITION
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'Markdownpreviewtoggle', 'Markdownpreview', 'Markdownpreviewstop' },
    build = 'cd app && yarn install',
    init = function() vim.g.mkdp_filetypes = { 'markdown' } end,
    ft = { 'markdown' },
  },

  -- Custom setup for autopairs and neo-tree if they were being used
  { 'windwp/nvim-autopairs', opts = {} },
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
    },
  },

  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'hrsh7th/nvim-cmp',
      'stevearc/dressing.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('codecompanion').setup {
        strategies = {
          chat = { adapter = 'ollama' },
          inline = { adapter = 'ollama' },
          agent = { adapter = 'ollama' },
        },
        opts = {
          language = 'en',
          send_code = true, -- Always send current file context
          use_diagnostic_errors = true, -- Let AI see LSP diagnostics
        },
        display = {
          chat = {
            window = {
              layout = 'vertical', -- Open as a sidebar on the right
              width = 45, -- Set a clean sidebar width
            },
          },
          diff = {
            provider = 'default',
          },
        },
        adapters = {
          ollama = function()
            return require('codecompanion.adapters').extend('ollama', {
              schema = {
                model = {
                  default = 'qwen3.5:27b',
                },
                num_ctx = {
                  default = 16384,
                },
              },
            })
          end,
        },
      }
    end,
  },

  -- this is for the markdown preview in the AI agent window
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" }
  },

  -- this allows us to paste images into the chat
  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        codecompanion = {
        prompt_for_file_name = false,
        template = "[Image]($FILE_PATH)",
        use_absolute_path = true,
        },
      },
    },
  },

  -- OFFLINE DOCUMENTATION (DevDocs)
  -- requires you to run 'brew install pandoc'
  {
     "maskudo/devdocs.nvim",
    lazy = false,
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = { "DevDocs" },
    keys = {
      {
        "<leader>ho",
        mode = "n",
        "<cmd>DevDocs get<cr>",
        desc = "Get Devdocs",
      },
      {
        "<leader>hi",
        mode = "n",
        "<cmd>DevDocs install<cr>",
        desc = "Install Devdocs",
      },
      {
        "<leader>hv",
        mode = "n",
        function()
          local devdocs = require("devdocs")
          local installedDocs = devdocs.GetInstalledDocs()
          vim.ui.select(installedDocs, {}, function(selected)
            if not selected then
              return
            end
            local docDir = devdocs.GetDocDir(selected)
            -- prettify the filename as you wish
            Snacks.picker.files({ cwd = docDir })
          end)
        end,
        desc = "Get Devdocs",
      },
      {
        "<leader>hd",
        mode = "n",
        "<cmd>DevDocs delete<cr>",
        desc = "Delete Devdoc",
      }
    },
    opts = {
      ensure_installed = {
        "angular",
        "bash",
        "css",
        "django~5.2",
        "django_rest_framework", -- drf
        "git",
        "html",
        "http",
        "jasmine",
        "javascript", -- js
        "nginx",
        "node", -- nodejs
        "npm",
        "numpy~2.4",
        "python~3.14",
        "pytorch~2.6",
        "requests",
        "scikit_learn", -- scikit-learn
        "typescript",
        "lua~5.1", -- keeping your neovim docs !
      },
    },
  },
}
