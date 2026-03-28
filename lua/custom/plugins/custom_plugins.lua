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
                  default = 'qwen3.5:9b',
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

  -- API DOCUMENTATION (Internal Neovim Browser)
  -- Focused devdocs search inside nvim buffers.
  -- REQUIRES: brew install elinks
  {
    'emmanueltouzery/apidocs.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
    },
    cmd = { 'ApidocsSearch', 'ApidocsInstall', 'ApidocsOpen', 'ApidocsSelect', 'ApidocsUninstall' },
    build = function()
      local data = vim.fn.stdpath('data') .. '/lazy/apidocs.nvim/lua/apidocs/'
      local function patch_literal(filename, find_str, replace_str)
        local f = io.open(filename, 'r')
        if not f then return end
        local content = f:read('*a')
        f:close()
        local start_idx, end_idx = string.find(content, find_str, 1, true)
        if start_idx then
          local new_content = content:sub(1, start_idx - 1) .. replace_str .. content:sub(end_idx + 1)
          local wf = io.open(filename, 'w')
          wf:write(new_content)
          wf:close()
          return true
        end
        return false
      end

      -- Install.lua patches (crashes)
      patch_literal(data .. 'install.lua', 'if node:next_named_sibling():named_child_count() > 0 then', '    if node:next_named_sibling() and node:next_named_sibling():named_child_count() > 0 then')
      patch_literal(data .. 'install.lua', 'local mtime = slugs_to_mtimes[choice]', '      local mtime = slugs_to_mtimes[choice]\n      if not mtime then vim.notify("Apidocs: doc not found", 2); return end')

      -- Common.lua patch (The big one: Flexible Link Detection)
      patch_literal(data .. 'common.lua', 'local m = string.match(line, "^%s+%d+%. local://")', '    local m = string.match(line, "^%s+%%d+%%.%%s+local://") or string.match(line, "^%%s+local://")')

      -- Disable winfixbuf
      patch_literal(data .. 'common.lua', 'vim.wo.winfixbuf = true', '  -- vim.wo.winfixbuf = true')
      patch_literal(data .. 'common.lua', 'vim.wo.winfixbuf = false', '  -- vim.wo.winfixbuf = false')

      -- Patch 5: Multi-page navigation (Re-arm the <C-]> key on every new page)
      -- This matches the original keymap and duplicates it into the switch function
      local find_o = 'vim.keymap.set("n", "<C-o>", function()'
      local replace_o = [[
  vim.keymap.set("n", "<C-]>", function()
    local line = vim.api.nvim_buf_get_lines(0, vim.fn.line(".")-1, vim.fn.line("."), false)[1]
    local m = string.match(line, "^%s+%%d+%%.%%s+local://") or string.match(line, "^%%s+local://")
    if m == nil and vim.startswith(line, "\tlocal://") then m = string.match(line, "^\tlocal://") end
    if m then
      local target = line:sub(#m+1):gsub("\t%%+.+$", "")
      local components = vim.split(target, "#")
      if #components == 2 then
        local new_buf = vim.api.nvim_create_buf(true, false)
        load_doc_in_buffer(new_buf, data_folder() .. target .. ".html.md")
        buf_view_switch_to_new(new_buf)
      elseif #components == 3 then
        local new_buf = vim.api.nvim_create_buf(true, false)
        load_doc_in_buffer(new_buf, data_folder() .. components[1] .. "#" .. components[2] .. ".html.md")
        buf_view_switch_to_new(new_buf)
        vim.cmd("/" .. components[3])
        vim.cmd("norm! zt |  ")
      elseif #components == 4 then
        local new_buf = vim.api.nvim_create_buf(true, false)
        load_doc_in_buffer(new_buf, data_folder() .. components[1] .. "#" .. components[2] .. "#" .. components[3] .. ".html.md")
        buf_view_switch_to_new(new_buf)
        vim.cmd("/" .. components[4])
        vim.cmd("norm! zt |  ")
      end
    end
  end, {buffer = new_buf})

  vim.keymap.set("n", "<C-o>", function()]]
      
      patch_literal(data .. 'common.lua', find_o, replace_o)
      
      vim.notify('apidocs.nvim: Applied local bugfix patches', 2)
    end,
    config = function()
      require('apidocs').setup()
      -- Automatically install documentation on startup
      require('apidocs').ensure_install({
        'python~3.14',
        'django~6.0',
        'django_rest_framework',
        'angular~20',
        'numpy~2.4',
        'pandas~2',
        'node', -- nodejs
        'nginx',
        'git',
        'bash',
        'http',
        'pytorch~2.9',
        'requests',
        'scikit_learn',
        'lua~5.1',
        'javascript',
        'typescript',
        'html',
        'css',
      })
    end,
    keys = {
      { '<leader>as', '<cmd>ApidocsSearch<cr>', desc = '[A]pi Doc [S]earch (Grep)' },
      { '<leader>ao', '<cmd>ApidocsOpen<cr>', desc = '[A]pi Doc [O]pen picker' },
      { '<leader>ai', '<cmd>ApidocsInstall<cr>', desc = '[A]pi Doc [I]nstall' },
    },
  },
}
