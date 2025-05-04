-- Space is my leader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')

-- Disable annoying command line typo.
vim.keymap.set('n', 'q:', ':q')

-- Paste replace visual selection without copying it.
vim.keymap.set('v', 'p', '"_dP')

-- Delete a word backwards without copying it.
vim.keymap.set('n', 'dw', '"_dw')
vim.keymap.set('n', 'diw', '"_diw')
vim.keymap.set('n', 'dd', '"_dd')
vim.keymap.set('v', 'd', '"_d')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 'D', '"_D')
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'ciw', '"_ciw')
vim.keymap.set('n', 'cc', '"_cc')
vim.keymap.set('v', 'c', '"_c')
vim.keymap.set('n', 'C', '"_C')
vim.keymap.set('n', 's', '"_s')
vim.keymap.set('n', 'S', '"_S')
vim.keymap.set('n', 'X', '"_X')



-- Easy insertion of a trailing ; or ,
vim.keymap.set('i', ';;', '<Esc>A;')
vim.keymap.set('i', ',,', '<Esc>A,')

-- Quickly clear search highlighting.
vim.keymap.set('n', '<Leader>kk', ':nohlsearch<CR>')

-- Open the current file in the default program (on Mac this should just be just `open`).
vim.keymap.set('n', '<Leader>x', ':!open %<CR><CR>')

-- Close all buffers
vim.keymap.set('n', '<leader>W', ':bufdo bd<CR>')

-- Redo with U
vim.keymap.set('n', 'U', '<C-r>')

-- Move lines up and down.
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('n', '<A-j>', ':move .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':move .-2<CR>==')
vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":move '<-2<CR>gv=gv")
-- Move between buffers
vim.keymap.set('n', '<leader>l', ":bn<CR>")
vim.keymap.set('n', '<leader>h', ":bp<CR>")

-- New File
vim.keymap.set('n', '<leader>nf', function()
  vim.ui.input({ prompt = "New file path: " }, function(input)
    if input and #input > 0 then
      vim.cmd('tabnew')
      vim.fn.mkdir(vim.fn.fnamemodify(input, ':h'), 'p')
      vim.cmd('edit ' .. input)
    end
  end)
end, { desc = 'Create new file (with dirs)', noremap = true, silent = true })

-- New Relative File
vim.api.nvim_create_user_command('NewRelativeFile', function(args)
  local input = args.args
  if input == "" then return end

  -- Get the current buffer's directory
  local current_dir = vim.fn.expand('%:p:h')
  local full_path = vim.fn.fnamemodify(current_dir .. '/' .. input, ':p')

  -- Create parent dirs if needed
  vim.fn.mkdir(vim.fn.fnamemodify(full_path, ':h'), 'p')

  -- Open in a new tab (optional — change to :edit for current window)
  vim.cmd('tabnew ' .. full_path)
end, {
  nargs = 1,
  complete = 'file',
})

vim.keymap.set('n', '<leader>nr', function()
  vim.ui.input({ prompt = "Relative path from current file: " }, function(input)
    if input and #input > 0 then
      vim.cmd('NewRelativeFile ' .. input)
    end
  end)
end, { desc = 'New file relative to current file' })

