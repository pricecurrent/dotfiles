local separator = { '"💫"', color = 'StatusLineNonText' }

require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    globalstatus = true,
    theme = {
      normal = {
        a = 'StatusLine',
        b = 'StatusLine',
        c = 'StatusLine',
      },
    },
  },
  sections = {
    lualine_a = {
      separator,
      'mode',
    },
    lualine_b = {
      -- 'branch',
      -- 'diff',
      -- function ()
      --   return '🖧  ' .. vim.pesc(tostring(#vim.tbl_keys(vim.lsp.buf_get_clients())) or '')
      -- end,
      -- { 'diagnostics', sources = { 'nvim_diagnostic' } },
      -- separator,
    },
    lualine_c = {
      -- 'filename'
    },
    lualine_x = {
      -- 'filetype',
      -- 'encoding',
      -- 'fileformat',
    },
    lualine_y = {
      -- separator,
      -- '(vim.bo.expandtab and "␠ " or "⇥ ") .. " " .. vim.bo.shiftwidth',
      -- separator,
    },
    lualine_z = {
      'location',
      -- 'progress',
    },
  },
})
