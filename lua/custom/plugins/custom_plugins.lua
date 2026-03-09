return {
  -- THIS ONE IS MY OWN CUSTOM ADDITION
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'Markdownpreviewtoggle', 'Markdownpreview', 'Markdownpreviewstop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
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
}
