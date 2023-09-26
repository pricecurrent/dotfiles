vim.keymap.set('n', '<Leader>.', ':TestLast<CR>')
vim.keymap.set('n', '<Leader>k.', ':TestNearest<CR>')
vim.keymap.set('n', '<Leader>kv', ':TestVisit<CR>')

vim.cmd([[
  function! FloatermStrategy(cmd)
    execute 'silent FloatermKill'
    execute 'FloatermNew! '.a:cmd.' |less -X'
  endfunction
  let g:test#custom_strategies = {'floaterm': function('FloatermStrategy')}
  let g:test#strategy = 'floaterm'
]])
