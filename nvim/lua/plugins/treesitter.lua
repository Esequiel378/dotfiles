return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'master', -- archived; main branch is a rewrite with a different API
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash',
          'c',
          'diff',
          'html',
          'lua',
          'luadoc',
          'markdown',
          'markdown_inline',
          'query',
          'vim',
          'vimdoc',
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = { enable = true },
      })

      -- Patch nvim-treesitter directives broken on Neovim 0.12: match[capture_id]
      -- now returns a list of nodes, not a single node. The legacy `master` branch
      -- is archived, so re-register the affected directives ourselves.
      local query = vim.treesitter.query
      local function first_node(match, capture_id)
        local v = match[capture_id]
        if type(v) == 'table' then return v[1] end
        return v
      end

      local injection_aliases = {
        ex = 'elixir', pl = 'perl', sh = 'bash', uxn = 'uxntal', ts = 'typescript',
      }
      query.add_directive('set-lang-from-info-string!', function(match, _, bufnr, pred, metadata)
        local node = first_node(match, pred[2])
        if not node then return end
        local alias = vim.treesitter.get_node_text(node, bufnr):lower()
        local ft = vim.filetype.match({ filename = 'a.' .. alias })
        metadata['injection.language'] = ft or injection_aliases[alias] or alias
      end, { force = true, all = true })

      query.add_directive('set-lang-from-mimetype!', function(match, _, bufnr, pred, metadata)
        local node = first_node(match, pred[2])
        if not node then return end
        local value = vim.treesitter.get_node_text(node, bufnr)
        local parts = vim.split(value, '/', {})
        metadata['injection.language'] = parts[#parts]
      end, { force = true, all = true })
    end,
  },
}
