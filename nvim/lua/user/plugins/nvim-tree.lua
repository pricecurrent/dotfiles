require('nvim-tree').setup({
    git = {
      ignore = false,
    },
    renderer = {
      group_empty = false,
      icons = {
        show = {
          folder_arrow = false
        },
      },
      indent_markers = {
        enable = true
      },
    },
  })

vim.keymap.set('n', '<Leader>kb', ':NvimTreeFindFileToggle<CR>')
