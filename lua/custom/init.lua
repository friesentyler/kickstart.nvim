-- Add my custom keymaps to open Neotree and shift between tabs quickly
-- toggle neo tree (command + n)
vim.keymap.set('n', '<C-n>', ':Neotree toggle reveal_force_cwd<cr>')
-- tab navigation
vim.keymap.set('n', '<tab>', ':tabn<cr>')
-- tab backwards navigation
vim.keymap.set('n', '<S-tab>', ':tabN<cr>')
-- new tab
vim.keymap.set('n', '<leader>T', ':tabnew<cr>', { noremap = true, silent = true })

-- AI Chat Toggle
vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'AI Chat Toggle' })

-- Quick Reference Cheatsheet
vim.keymap.set('n', '<leader>rc', ':tabedit ~/.config/nvim/personal-cheatsheet.md<cr>', { desc = 'Open [R]eference [C]ard', silent = true })