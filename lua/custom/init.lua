-- Add my custom keymaps to open Neotree and shift between tabs quickly
vim.keymap.set('n', '<C-n>', ':Neotree toggle reveal_force_cwd<cr>')
vim.keymap.set('n', '<tab>', ':tabn<cr>')
vim.keymap.set('n', '<S-tab>', ':tabN<cr>')
vim.keymap.set('n', '<leader>T', ':tabnew<cr>', { noremap = true, silent = true })
