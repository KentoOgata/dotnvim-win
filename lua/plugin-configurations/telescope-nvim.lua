local telescope = require('telescope')
local actions = require('telescope.builtin')

vim.keymap.set('n', '<space>x', actions.commands)
vim.keymap.set('n', '<space>k', actions.keymaps)
vim.keymap.set('n', '<space>h', actions.help_tags)
vim.keymap.set('n', '<space>b', actions.buffers)
vim.keymap.set('n', '<space>f', actions.find_files)
vim.keymap.set('n', '<space>s', actions.current_buffer_fuzzy_find)
