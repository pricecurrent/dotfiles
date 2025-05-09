require('mason').setup()
require('mason-lspconfig').setup({ automatic_installation = true })

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- PHP server
require'lspconfig'.intelephense.setup{
  commands = {
    IntelephenseIndex = {
      function()
        vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
      end,
    },
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    -- if client.server_capabilities.inlayHintProvider then
    --   vim.lsp.buf.inlay_hint(bufnr, true)
    -- end
  end,
  capabilities = capabilities
}

-- JS server
require'lspconfig'.volar.setup{
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    -- if client.server_capabilities.inlayHintProvider then
    --   vim.lsp.buf.inlay_hint(bufnr, true)
    -- end
  end,
  capabilities = capabilities,
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue'}
}

-- Tailwind
require'lspconfig'.tailwindcss.setup{ capabilities = capabilities }

-- JSON
require('lspconfig').jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
})

-- none-ls
local null_ls = require('none-ls')
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
  temp_dir = '/tmp',
  sources = {
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.js' })
      end,
    }),
    -- null_ls.builtins.diagnostics.phpstan, -- TODO: Only if config file
    null_ls.builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
    null_ls.builtins.formatting.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.js', '.eslintrc.json' })
      end,
    }),
    null_ls.builtins.formatting.pint.with({
      condition = function(utils)
        return utils.root_has_file({ 'vendor/bin/pint' })
      end,
    }),
    null_ls.builtins.formatting.prettier.with({
      condition = function(utils)
        return utils.root_has_file({ '.prettierrc', '.prettierrc.json', '.prettierrc.yml', '.prettierrc.js', 'prettier.config.js' })
      end,
    }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
        end,
      })
    end
  end,
})

require('mason-null-ls').setup({ automatic_installation = true })

-- Keymaps
vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
-- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

-- Commands
vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ timeout_ms = 5000 }) end, {})

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = false,
  float = {
    source = true,
  }
})

-- Sign configuration
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
