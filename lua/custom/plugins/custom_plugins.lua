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
            provider = 'mini_diff',
          },
        },
        adapters = {
          ollama = function()
            return require('codecompanion.adapters').extend('ollama', {
              schema = {
                model = {
                  default = 'qwen2.5-coder:32b',
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
}
