-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = true
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/esequielalbornoz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/esequielalbornoz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/esequielalbornoz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/esequielalbornoz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/esequielalbornoz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    config = { "\27LJ\2\n∞\1\0\0\4\0\a\0\r6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0015\3\4\0B\1\2\0016\1\0\0'\3\5\0B\1\2\0029\1\6\1B\1\1\1K\0\1\0\tload luasnip/loaders/from_vscode\1\0\2\17updateevents\29TextChanged,TextChangedI\fhistory\1\15set_config\vconfig\fluasnip\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip",
    wants = { "friendly-snippets" }
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\2\nƒ\2\0\0\r\0\20\0,6\0\0\0009\0\1\0006\2\2\0B\0\2\2\21\0\0\0006\1\3\0009\1\4\1'\3\5\0B\1\2\2'\2\6\0\18\3\0\0'\4\a\0'\5\b\0006\6\0\0009\6\t\6B\6\1\0029\6\n\6'\a\v\0006\b\0\0009\b\t\bB\b\1\0029\b\f\b'\t\v\0006\n\0\0009\n\t\nB\n\1\0029\n\r\n'\v\14\0\18\f\1\0&\2\f\0026\3\15\0'\5\16\0B\3\2\0026\4\17\0009\4\18\4\18\6\3\0B\6\1\2'\a\19\0B\4\3\2\18\5\2\0'\6\19\0\18\a\4\0&\5\a\5L\5\2\0\6\n\vconcat\ntable\18alpha.fortune\frequire\t  | \npatch\nminor\6.\nmajor\fversion\n  | v\r plugins\6 \22%d-%m-%Y %H:%M:%S\tdate\aos\19packer_plugins\rtbl_keys\bvimÈ\n\1\0\n\0%\1T6\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1Ä2\0LÄ6\2\1\0'\4\3\0B\2\2\0029\3\4\0029\3\5\0035\4\a\0=\4\6\0039\3\4\0029\3\b\0034\4\a\0009\5\t\2'\a\n\0'\b\v\0'\t\f\0B\5\4\2>\5\1\0049\5\t\2'\a\r\0'\b\14\0'\t\15\0B\5\4\2>\5\2\0049\5\t\2'\a\16\0'\b\17\0'\t\18\0B\5\4\2>\5\3\0049\5\t\2'\a\19\0'\b\20\0'\t\21\0B\5\4\2>\5\4\0049\5\t\2'\a\22\0'\b\23\0'\t\24\0B\5\4\2>\5\5\0049\5\t\2'\a\25\0'\b\26\0'\t\27\0B\5\4\0?\5\0\0=\4\6\0033\3\28\0009\4\4\0029\4\29\4\18\5\3\0B\5\1\2=\5\6\0049\4\4\0029\4\29\0049\4\30\4'\5 \0=\5\31\0049\4\4\0029\4\5\0049\4\30\4'\5!\0=\5\31\0049\4\4\0029\4\b\0049\4\30\4'\5\"\0=\5\31\0049\4\30\0029\4\30\4+\5\2\0=\5#\0049\4$\0019\6\30\2B\4\2\1K\0\1\0K\0\1\0\nsetup\14noautocmd\fKeyword\fInclude\tType\ahl\topts\vfooter\0\f:qa<CR>\16Quit Neovim\6q\20:e $MYVIMRC<CR>\18Configuration\6c\30:Telescope live_grep <CR>\14Find text\aps\29:Telescope oldfiles <CR>\24Recently used files\6o :ene <BAR> startinsert <CR>\rNew file\6e+:Telescope find_files hidden=true <CR>\14Find file\6t\vbutton\fbuttons\1\17\0\0.        /\\          /\\          /\\       .     /\\//\\\\/\\    /\\//\\\\/\\    /\\//\\\\/\\    .  /\\//\\\\\\///\\\\/\\//\\\\\\///\\\\/\\//\\\\\\///\\\\/\\ . //\\\\\\//\\/\\\\///\\\\\\//\\/\\\\///\\\\\\//\\/\\\\///\\\\. \\\\//\\/                            \\/\\\\//.  \\/                                  \\/ .  /\\                                  /\\ . //\\\\  Neovim IDE with LSP and DAP   //\\\\. \\\\//                                \\\\//.  \\/                                  \\/ .  /\\                                  /\\ . //\\\\/\\                            /\\//\\\\. \\\\///\\\\/\\//\\\\\\///\\\\/\\//\\\\\\///\\\\/\\//\\\\\\//.  \\/\\\\///\\\\\\//\\/\\\\///\\\\\\//\\/\\\\///\\\\\\//\\/ .      \\/\\\\//\\/    \\/\\\\//\\/    \\/\\\\//\\/   .         \\/          \\/          \\/      \bval\vheader\fsection\27alpha.themes.dashboard\nalpha\frequire\npcall\rÄÄ¿ô\4\0" },
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    after_files = { "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-emoji"] = {
    after_files = { "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp-emoji/after/plugin/cmp_emoji.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp-emoji",
    url = "https://github.com/hrsh7th/cmp-emoji"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    after_files = { "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    after_files = { "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["copilot.vim"] = {
    config = { "\27LJ\2\nê\2\0\0\a\0\15\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0\18\1\0\0'\3\3\0'\4\4\0'\5\5\0005\6\6\0B\1\5\1\18\1\0\0'\3\3\0'\4\a\0'\5\b\0B\1\4\1\18\1\0\0'\3\3\0'\4\t\0'\5\n\0B\1\4\0016\1\v\0009\1\f\0015\2\14\0=\2\r\1K\0\1\0\1\0\1\besl\1\22copilot_filetypes\6g\bvim\29<Plug>(copilot-previous)\n<C-p>\25<Plug>(copilot-next)\n<C-n>\1\0\3\vsilent\2\vscript\2\texpr\2\23copilot#Accept(\"\")\n<C-y>\6i\bmap\15core.utils\frequire\0" },
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["editorconfig-vim"] = {
    config = { '\27LJ\2\nZ\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\3\0\0\18fugitive://.*\rscp://.*"EditorConfig_exclude_patterns\6g\bvim\0' },
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/editorconfig-vim",
    url = "https://github.com/editorconfig/editorconfig-vim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vfidget\frequire\0" },
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["filetype.nvim"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["friendly-snippets"] = {
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n˘\t\0\0\5\0\20\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\2B\0\2\1K\0\1\0\fkeymaps\1\0\n\17n <leader>hS2<cmd>lua require\"gitsigns\".stage_buffer()<CR>\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\17n <leader>hU8<cmd>lua require\"gitsigns\".reset_buffer_index()<CR>\17n <leader>hb9<cmd>lua require\"gitsigns\".blame_line{full=true}<CR>\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\17n <leader>hR2<cmd>lua require\"gitsigns\".reset_buffer()<CR>\17v <leader>hrT<cmd>lua require\"gitsigns\".reset_hunk({vim.fn.line(\".\"), vim.fn.line(\"v\")})<CR>\17n <leader>hr0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\17n <leader>hu5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\17v <leader>hsT<cmd>lua require\"gitsigns\".stage_hunk({vim.fn.line(\".\"), vim.fn.line(\"v\")})<CR>\17watch_gitdir\1\0\1\rinterval\3Ë\a\nsigns\17changedelete\1\0\4\vlinehl\21GitSignsChangeLn\nnumhl\21GitSignsChangeNr\ttext\6|\ahl\19GitSignsChange\14topdelete\1\0\4\vlinehl\21GitSignsDeleteLn\nnumhl\21GitSignsDeleteNr\ttext\6|\ahl\19GitSignsDelete\vdelete\1\0\4\vlinehl\21GitSignsDeleteLn\nnumhl\21GitSignsDeleteNr\ttext\6|\ahl\19GitSignsDelete\vchange\1\0\4\vlinehl\21GitSignsChangeLn\nnumhl\21GitSignsChangeNr\ttext\6|\ahl\19GitSignsChange\badd\1\0\0\1\0\4\vlinehl\18GitSignsAddLn\nnumhl\18GitSignsAddNr\ttext\6|\ahl\16GitSignsAdd\1\0\2\18sign_priority\3\5\nnumhl\1\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["go.nvim"] = {
    config = { "\27LJ\2\nD\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\26plugins.config.golang\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/go.nvim",
    url = "https://github.com/ray-x/go.nvim"
  },
  ["guihua.lua"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/guihua.lua",
    url = "https://github.com/ray-x/guihua.lua"
  },
  ["impatient.nvim"] = {
    config = { "\27LJ\2\n)\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\14impatient\frequire\0" },
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\30plugins.config.statusline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["nginx.vim"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/nginx.vim",
    url = "https://github.com/chr4/nginx.vim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-cmp"] = {
    after = { "cmp-buffer", "cmp-emoji", "cmp-nvim-lsp", "cmp-nvim-lua", "LuaSnip", "cmp-path", "cmp-cmdline", "friendly-snippets", "cmp_luasnip" },
    config = { "\27LJ\2\n-\0\1\4\1\2\0\5-\1\0\0009\1\0\0019\3\1\0B\1\2\1K\0\1\0\1¿\tbody\15lsp_expandâ\1\0\1\5\1\6\0\17-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\tÄ-\1\0\0009\1\1\0015\3\4\0-\4\0\0009\4\2\0049\4\3\4=\4\5\3B\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\2¿\rbehavior\1\0\1\vselect\1\fReplace\20ConfirmBehavior\fconfirm\fvisibleñ\1\0\2\b\0\4\0\0289\2\0\0009\2\1\2\18\4\2\0009\2\2\2'\5\3\0B\2\3\0039\4\0\0019\4\1\4\18\6\4\0009\4\2\4'\a\3\0B\4\3\3\14\0\3\0X\6\1Ä)\3\0\0\14\0\5\0X\6\1Ä)\5\0\0\1\5\3\0X\6\3Ä+\6\1\0L\6\2\0X\6\4Ä\1\3\5\0X\6\2Ä+\6\2\0L\6\2\0K\0\1\0\b^_+\tfind\nlabel\20completion_item‹\v\1\0\14\0R\0Æ\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0025\5\6\0005\6\5\0=\6\a\0055\6\b\0=\6\t\0055\6\v\0003\a\n\0=\a\f\6=\6\r\0055\6\17\0009\a\14\0029\t\14\0029\t\15\tB\t\1\0025\n\16\0B\a\3\2=\a\18\0069\a\14\0029\t\14\0029\t\19\tB\t\1\0025\n\20\0B\a\3\2=\a\21\0069\a\14\0029\t\14\0029\t\22\t)\v¸ˇB\t\2\0025\n\23\0B\a\3\2=\a\24\0069\a\14\0029\t\14\0029\t\22\t)\v\4\0B\t\2\0025\n\25\0B\a\3\2=\a\26\0069\a\14\0029\t\14\0029\t\27\tB\t\1\0025\n\28\0B\a\3\2=\a\29\0069\a\14\0025\t\31\0009\n\14\0029\n\30\nB\n\1\2=\n \t9\n\14\0029\n\30\nB\n\1\2=\n!\tB\a\2\2=\a\"\0069\a\14\0025\t(\0009\n\14\0029\n#\n5\f&\0009\r$\0029\r%\r=\r'\fB\n\2\2=\n \t3\n)\0=\n!\tB\a\2\2=\a*\6=\6\14\0055\0065\0004\a\t\0009\b+\0029\b,\b9\b-\b>\b\1\a9\b+\0029\b,\b9\b.\b>\b\2\a9\b+\0029\b,\b9\b/\b>\b\3\a3\b0\0>\b\4\a9\b+\0029\b,\b9\b1\b>\b\5\a9\b+\0029\b,\b9\b2\b>\b\6\a9\b+\0029\b,\b9\b3\b>\b\a\a9\b+\0029\b,\b9\b4\b>\b\b\a=\a6\6=\0067\0055\6<\0009\a8\0005\t9\0005\n:\0=\n;\tB\a\2\2=\a=\6=\6>\0054\6\a\0005\a?\0>\a\1\0065\a@\0>\a\2\0065\aA\0>\a\3\0065\aB\0>\a\4\0065\aC\0>\a\5\0065\aD\0>\a\6\6=\6E\0055\6H\0009\a+\0029\aF\a9\aG\aB\a\1\2=\aI\6=\6F\5B\3\2\0019\3\4\0029\3J\3'\5K\0005\6M\0004\a\3\0005\bL\0>\b\1\a=\aE\6B\3\3\0019\3\4\0029\3J\3'\5N\0005\6Q\0009\a+\0029\aE\a4\t\3\0005\nO\0>\n\1\t4\n\3\0005\vP\0>\v\1\nB\a\3\2=\aE\6B\3\3\0012\0\0ÄK\0\1\0\1\0\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\6:\1\0\0\1\0\1\tname\vbuffer\6/\fcmdline\18documentation\1\0\0\rbordered\vwindow\fsources\1\0\1\tname\nemoji\1\0\1\tname\tpath\1\0\1\tname\rnvim_lua\1\0\1\tname\fluasnip\1\0\1\tname\vbuffer\1\0\1\tname\rnvim_lsp\15formatting\vformat\1\0\0\tmenu\1\0\6\vbuffer\n[buf]\fluasnip\v[Snip]\rnvim_lsp\n[LSP]\tpath\v[path]\nemoji\f[Emoji]\rnvim_lua\n[api]\1\0\2\rmaxwidth\0032\14with_text\2\15cmp_format\fsorting\16comparators\1\0\0\norder\vlength\14sort_text\tkind\0\nscore\nexact\voffset\fcompare\vconfig\n<C-y>\0\1\0\0\rbehavior\1\0\1\vselect\1\fReplace\20ConfirmBehavior\fconfirm\n<C-e>\6c\6i\1\0\0\nclose\14<C-Space>\1\3\0\0\6i\6c\rcomplete\n<C-f>\1\3\0\0\6i\6c\n<C-b>\1\3\0\0\6i\6c\16scroll_docs\n<C-p>\1\3\0\0\6i\6c\21select_prev_item\n<C-n>\1\0\0\1\3\0\0\6i\6c\21select_next_item\fmapping\fsnippet\vexpand\1\0\0\0\17experimental\1\0\2\15ghost_text\1\16native_menu\1\15completion\1\0\0\1\0\1\16completeopt\26menu,menuone,noinsert\nsetup\bcmp\fluasnip\flspkind\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp",
    wants = { "LuaSnip" }
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\23plugins.config.lsp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig",
    wants = { "nvim-lsp-installer", "lua-dev.nvim", "vim-illuminate", "null-ls.nvim", "schemastore.nvim" }
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\nm\0\0\4\0\5\0\f6\0\0\0006\1\2\0'\3\1\0B\1\2\2=\1\1\0006\0\2\0'\2\1\0B\0\2\0029\0\3\0005\2\4\0B\0\2\1K\0\1\0\1\0\1\22background_colour\f#000000\nsetup\frequire\vnotify\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n±\2\0\0\4\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\2B\0\2\1K\0\1\0\fendwise\1\0\1\venable\2\26context_commentstring\1\0\1\venable\2\14highlight\1\0\3\21use_languagetree\2\venable\2&additional_vim_regex_highlighting\1\14autopairs\1\0\1\venable\2\21ensure_installed\1\0\1\17sync_install\1\1\3\0\0\blua\ago\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-endwise"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-endwise",
    url = "https://github.com/RRethy/nvim-treesitter-endwise",
    wants = { "nvim-treesitter" }
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\venable\2\nsetup\20nvim-ts-autotag\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag",
    wants = { "nvim-treesitter" }
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["refactoring.nvim"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/refactoring.nvim",
    url = "https://github.com/ThePrimeagen/refactoring.nvim"
  },
  rnvimr = {
    commands = { "RnvimrToggle" },
    config = { "\27LJ\2\n◊\1\0\0\6\0\v\0\0226\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\5\0'\2\6\0B\0\2\0029\0\a\0\18\1\0\0'\3\b\0'\4\t\0'\5\n\0B\1\4\1K\0\1\0\22:RnvimrToggle<CR>\15<leader>rr\6n\bmap\15core.utils\frequire\26rnvimr_hide_gitignore\25rnvimr_enable_picker\21rnvimr_enable_ex\6g\bvim\0" },
    keys = { { "", "<leader>rr" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/rnvimr",
    url = "https://github.com/kevinhwang91/rnvimr"
  },
  ["schemastore.nvim"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/schemastore.nvim",
    url = "https://github.com/b0o/schemastore.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\nn\0\2\a\4\2\1\16\14\0\1\0X\2\1ÄK\0\1\0009\2\0\1*\3\0\0\1\3\2\0X\2\2ÄK\0\1\0X\2\6Ä-\2\0\0009\2\1\2-\4\1\0-\5\2\0-\6\3\0B\2\4\1K\0\1\0\1\0\0\0\2\0\3\0\27buffer_previewer_maker\tsize¿Ñ=\\\0\0\a\1\4\0\n6\0\0\0009\0\1\0009\0\2\0-\2\0\0)\3\0\0)\4ˇˇ+\5\1\0005\6\3\0B\0\6\1K\0\1\0\2\0\1\2\0\0\16BINARY FILE\23nvim_buf_set_lines\bapi\bvimõ\1\1\1\6\4\n\0\0236\1\0\0009\1\1\1\18\5\0\0009\3\2\0B\3\2\2:\3\1\3'\4\3\0B\1\3\2:\1\1\1\a\1\4\0X\2\aÄ6\2\0\0009\2\5\0029\2\6\2-\4\0\0003\5\a\0B\2\3\1X\2\4Ä6\2\0\0009\2\b\0023\4\t\0B\2\2\1K\0\1\0\0Ä\1\0\1¿\2¿\0\rschedule\0\ffs_stat\tloop\ttext\6/\vresult\nsplit\bvimß\1\1\3\b\2\n\0\0216\3\0\0009\3\1\0039\3\2\3\18\5\0\0B\3\2\2\18\0\3\0-\3\0\0\18\5\3\0009\3\3\0035\6\4\0005\a\5\0>\0\3\a=\a\6\0063\a\a\0=\a\b\6B\3\3\2\18\5\3\0009\3\t\3B\3\2\0012\0\0ÄK\0\1\0\4¿\3¿\tsync\fon_exit\0\targs\1\3\0\0\16--mime-type\a-b\1\0\1\fcommand\tfile\bnew\vexpand\afn\bvim¢\n\1\0\r\0001\0J6\0\0\0'\2\1\0B\0\2\0029\0\2\0\18\1\0\0'\3\3\0'\4\4\0'\5\5\0B\1\4\1\18\1\0\0'\3\3\0'\4\6\0'\5\a\0B\1\4\1\18\1\0\0'\3\3\0'\4\b\0'\5\t\0B\1\4\1\18\1\0\0'\3\3\0'\4\n\0'\5\v\0B\1\4\0016\1\0\0'\3\f\0B\1\2\0026\2\0\0'\4\r\0B\2\2\0026\3\0\0'\5\14\0B\3\2\0026\4\0\0'\6\15\0B\4\2\0023\5\16\0009\6\17\0025\b-\0005\t\18\0=\5\19\t5\n\20\0=\n\21\t5\n\22\0=\n\23\t4\n\0\0=\n\24\t5\n\25\0=\n\26\t5\n\27\0=\n\28\t5\n\30\0005\v\29\0=\v\31\n5\v \0=\v!\n=\n\"\t5\n(\0005\v$\0009\f#\1=\f%\v9\f&\1=\f'\v=\v)\n=\n*\t5\n+\0=\n,\t=\t.\bB\6\2\0019\6/\2'\b0\0B\6\2\0012\0\0ÄK\0\1\0\bfzf\19load_extension\rdefaults\1\0\0\22vimgrep_arguments\1\b\0\0\arg\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\17--smart-case\rmappings\6i\1\0\0\n<C-k>\23cycle_history_prev\n<C-j>\1\0\0\23cycle_history_next\18layout_config\rvertical\1\0\1\vmirror\1\15horizontal\1\0\3\19preview_cutoff\3x\vheight\4ö≥ÊÃ\tô≥¶ˇ\3\nwidth\4◊«¬Î\3äÆØˇ\3\1\0\3\18preview_width\4ö≥ÊÃ\tô≥Üˇ\3\20prompt_position\btop\18results_width\4ö≥ÊÃ\tô≥¶ˇ\3\fset_env\1\0\1\14COLORTERM\14truecolor\16borderchars\1\t\0\0\b‚îÄ\b‚îÇ\b‚îÄ\b‚îÇ\b‚ï≠\b‚ïÆ\b‚ïØ\b‚ï∞\vborder\17path_display\1\2\0\0\rabsolute\25file_ignore_patterns\1\4\0\0\17node_modules\v%.git/\f%.local\27buffer_previewer_maker\1\0\n\23selection_strategy\nreset\ruse_less\2\19color_devicons\2\rwinblend\3\0\20layout_strategy\15horizontal\21sorting_strategy\14ascending\17initial_mode\vinsert\17entry_prefix\a  \20selection_caret\a  \18prompt_prefix\v ÔÄÇ  \nsetup\0\16plenary.job\25telescope.previewers\14telescope\22telescope.actions\28:Telescope buffers <CR>\15<leader>fb :Telescope grep_string <CR>\15<leader>fw\30:Telescope live_grep <CR>\15<leader>ps+:Telescope find_files hidden=true <CR>\14<leader>t\6n\bmap\15core.utils\frequire\0" },
    keys = { { "", "<leader>t" }, { "", "<leader>ps" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim",
    wants = { "plenary.nvim", "popup.nvim", "telescope-fzf-native.nvim" }
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nã\1\0\0\6\0\b\0\0166\0\0\0'\2\1\0B\0\2\0029\0\2\0\18\1\0\0'\3\3\0'\4\4\0'\5\5\0B\1\4\0016\1\0\0'\3\6\0B\1\2\0029\1\a\0014\3\0\0B\1\2\1K\0\1\0\nsetup\ftrouble\23:TroubleToggle<CR>\14<leader>q\6n\bmap\15core.utils\frequire\0" },
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-closer"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/vim-closer",
    url = "https://github.com/rstacruz/vim-closer"
  },
  ["vim-commentary"] = {
    keys = { { "", "gc" }, { "", "gcc" }, { "", "gbc" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-fugitive"] = {
    config = { "\27LJ\2\n∫\1\0\0\6\0\n\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0\18\1\0\0'\3\3\0'\4\4\0'\5\5\0B\1\4\1\18\1\0\0'\3\3\0'\4\6\0'\5\a\0B\1\4\1\18\1\0\0'\3\3\0'\4\b\0'\5\t\0B\1\4\1K\0\1\0\21:diffget //2<CR>\15<leader>gh\21:diffget //3<CR>\15<leader>gl\v:G<CR>\15<leader>gs\6n\bmap\15core.utils\frequire\0" },
    keys = { { "", "<leader>gs" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-moonfly-colors"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\24colorscheme moonfly\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/vim-moonfly-colors",
    url = "https://github.com/bluz71/vim-moonfly-colors"
  },
  ["vim-sql-syntax"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/vim-sql-syntax",
    url = "https://github.com/shmup/vim-sql-syntax"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-transparent"] = {
    loaded = true,
    path = "/Users/esequielalbornoz/.local/share/nvim/site/pack/packer/start/vim-transparent",
    url = "https://github.com/tribela/vim-transparent"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^cmp_nvim_lsp"] = "cmp-nvim-lsp",
  ["^lspkind"] = "lspkind-nvim",
  ["^nvim%-web%-devicons"] = "nvim-web-devicons",
  ["^plenary"] = "plenary.nvim",
  ["^telescope"] = "telescope.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: markdown-preview.nvim
time([[Setup for markdown-preview.nvim]], true)
try_loadstring("\27LJ\2\n=\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\2\0\0\rmarkdown\19mkdp_filetypes\6g\bvim\0", "setup", "markdown-preview.nvim")
time([[Setup for markdown-preview.nvim]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
try_loadstring("\27LJ\2\nƒ\2\0\0\r\0\20\0,6\0\0\0009\0\1\0006\2\2\0B\0\2\2\21\0\0\0006\1\3\0009\1\4\1'\3\5\0B\1\2\2'\2\6\0\18\3\0\0'\4\a\0'\5\b\0006\6\0\0009\6\t\6B\6\1\0029\6\n\6'\a\v\0006\b\0\0009\b\t\bB\b\1\0029\b\f\b'\t\v\0006\n\0\0009\n\t\nB\n\1\0029\n\r\n'\v\14\0\18\f\1\0&\2\f\0026\3\15\0'\5\16\0B\3\2\0026\4\17\0009\4\18\4\18\6\3\0B\6\1\2'\a\19\0B\4\3\2\18\5\2\0'\6\19\0\18\a\4\0&\5\a\5L\5\2\0\6\n\vconcat\ntable\18alpha.fortune\frequire\t  | \npatch\nminor\6.\nmajor\fversion\n  | v\r plugins\6 \22%d-%m-%Y %H:%M:%S\tdate\aos\19packer_plugins\rtbl_keys\bvimÈ\n\1\0\n\0%\1T6\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1Ä2\0LÄ6\2\1\0'\4\3\0B\2\2\0029\3\4\0029\3\5\0035\4\a\0=\4\6\0039\3\4\0029\3\b\0034\4\a\0009\5\t\2'\a\n\0'\b\v\0'\t\f\0B\5\4\2>\5\1\0049\5\t\2'\a\r\0'\b\14\0'\t\15\0B\5\4\2>\5\2\0049\5\t\2'\a\16\0'\b\17\0'\t\18\0B\5\4\2>\5\3\0049\5\t\2'\a\19\0'\b\20\0'\t\21\0B\5\4\2>\5\4\0049\5\t\2'\a\22\0'\b\23\0'\t\24\0B\5\4\2>\5\5\0049\5\t\2'\a\25\0'\b\26\0'\t\27\0B\5\4\0?\5\0\0=\4\6\0033\3\28\0009\4\4\0029\4\29\4\18\5\3\0B\5\1\2=\5\6\0049\4\4\0029\4\29\0049\4\30\4'\5 \0=\5\31\0049\4\4\0029\4\5\0049\4\30\4'\5!\0=\5\31\0049\4\4\0029\4\b\0049\4\30\4'\5\"\0=\5\31\0049\4\30\0029\4\30\4+\5\2\0=\5#\0049\4$\0019\6\30\2B\4\2\1K\0\1\0K\0\1\0\nsetup\14noautocmd\fKeyword\fInclude\tType\ahl\topts\vfooter\0\f:qa<CR>\16Quit Neovim\6q\20:e $MYVIMRC<CR>\18Configuration\6c\30:Telescope live_grep <CR>\14Find text\aps\29:Telescope oldfiles <CR>\24Recently used files\6o :ene <BAR> startinsert <CR>\rNew file\6e+:Telescope find_files hidden=true <CR>\14Find file\6t\vbutton\fbuttons\1\17\0\0.        /\\          /\\          /\\       .     /\\//\\\\/\\    /\\//\\\\/\\    /\\//\\\\/\\    .  /\\//\\\\\\///\\\\/\\//\\\\\\///\\\\/\\//\\\\\\///\\\\/\\ . //\\\\\\//\\/\\\\///\\\\\\//\\/\\\\///\\\\\\//\\/\\\\///\\\\. \\\\//\\/                            \\/\\\\//.  \\/                                  \\/ .  /\\                                  /\\ . //\\\\  Neovim IDE with LSP and DAP   //\\\\. \\\\//                                \\\\//.  \\/                                  \\/ .  /\\                                  /\\ . //\\\\/\\                            /\\//\\\\. \\\\///\\\\/\\//\\\\\\///\\\\/\\//\\\\\\///\\\\/\\//\\\\\\//.  \\/\\\\///\\\\\\//\\/\\\\///\\\\\\//\\/\\\\///\\\\\\//\\/ .      \\/\\\\//\\/    \\/\\\\//\\/    \\/\\\\//\\/   .         \\/          \\/          \\/      \bval\vheader\fsection\27alpha.themes.dashboard\nalpha\frequire\npcall\rÄÄ¿ô\4\0", "config", "alpha-nvim")
time([[Config for alpha-nvim]], false)
-- Config for: copilot.vim
time([[Config for copilot.vim]], true)
try_loadstring("\27LJ\2\nê\2\0\0\a\0\15\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0\18\1\0\0'\3\3\0'\4\4\0'\5\5\0005\6\6\0B\1\5\1\18\1\0\0'\3\3\0'\4\a\0'\5\b\0B\1\4\1\18\1\0\0'\3\3\0'\4\t\0'\5\n\0B\1\4\0016\1\v\0009\1\f\0015\2\14\0=\2\r\1K\0\1\0\1\0\1\besl\1\22copilot_filetypes\6g\bvim\29<Plug>(copilot-previous)\n<C-p>\25<Plug>(copilot-next)\n<C-n>\1\0\3\vsilent\2\vscript\2\texpr\2\23copilot#Accept(\"\")\n<C-y>\6i\bmap\15core.utils\frequire\0", "config", "copilot.vim")
time([[Config for copilot.vim]], false)
-- Config for: vim-moonfly-colors
time([[Config for vim-moonfly-colors]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\24colorscheme moonfly\bcmd\bvim\0", "config", "vim-moonfly-colors")
time([[Config for vim-moonfly-colors]], false)
-- Config for: editorconfig-vim
time([[Config for editorconfig-vim]], true)
try_loadstring('\27LJ\2\nZ\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\3\0\0\18fugitive://.*\rscp://.*"EditorConfig_exclude_patterns\6g\bvim\0', "config", "editorconfig-vim")
time([[Config for editorconfig-vim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n±\2\0\0\4\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\2B\0\2\1K\0\1\0\fendwise\1\0\1\venable\2\26context_commentstring\1\0\1\venable\2\14highlight\1\0\3\21use_languagetree\2\venable\2&additional_vim_regex_highlighting\1\14autopairs\1\0\1\venable\2\21ensure_installed\1\0\1\17sync_install\1\1\3\0\0\blua\ago\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n˘\t\0\0\5\0\20\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\2B\0\2\1K\0\1\0\fkeymaps\1\0\n\17n <leader>hS2<cmd>lua require\"gitsigns\".stage_buffer()<CR>\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\17n <leader>hU8<cmd>lua require\"gitsigns\".reset_buffer_index()<CR>\17n <leader>hb9<cmd>lua require\"gitsigns\".blame_line{full=true}<CR>\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\17n <leader>hR2<cmd>lua require\"gitsigns\".reset_buffer()<CR>\17v <leader>hrT<cmd>lua require\"gitsigns\".reset_hunk({vim.fn.line(\".\"), vim.fn.line(\"v\")})<CR>\17n <leader>hr0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\17n <leader>hu5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\17v <leader>hsT<cmd>lua require\"gitsigns\".stage_hunk({vim.fn.line(\".\"), vim.fn.line(\"v\")})<CR>\17watch_gitdir\1\0\1\rinterval\3Ë\a\nsigns\17changedelete\1\0\4\vlinehl\21GitSignsChangeLn\nnumhl\21GitSignsChangeNr\ttext\6|\ahl\19GitSignsChange\14topdelete\1\0\4\vlinehl\21GitSignsDeleteLn\nnumhl\21GitSignsDeleteNr\ttext\6|\ahl\19GitSignsDelete\vdelete\1\0\4\vlinehl\21GitSignsDeleteLn\nnumhl\21GitSignsDeleteNr\ttext\6|\ahl\19GitSignsDelete\vchange\1\0\4\vlinehl\21GitSignsChangeLn\nnumhl\21GitSignsChangeNr\ttext\6|\ahl\19GitSignsChange\badd\1\0\0\1\0\4\vlinehl\18GitSignsAddLn\nnumhl\18GitSignsAddNr\ttext\6|\ahl\16GitSignsAdd\1\0\2\18sign_priority\3\5\nnumhl\1\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nã\1\0\0\6\0\b\0\0166\0\0\0'\2\1\0B\0\2\0029\0\2\0\18\1\0\0'\3\3\0'\4\4\0'\5\5\0B\1\4\0016\1\0\0'\3\6\0B\1\2\0029\1\a\0014\3\0\0B\1\2\1K\0\1\0\nsetup\ftrouble\23:TroubleToggle<CR>\14<leader>q\6n\bmap\15core.utils\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: impatient.nvim
time([[Config for impatient.nvim]], true)
try_loadstring("\27LJ\2\n)\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\14impatient\frequire\0", "config", "impatient.nvim")
time([[Config for impatient.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file RnvimrToggle lua require("packer.load")({'rnvimr'}, { cmd = "RnvimrToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <leader>gs <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>leader>gs", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gc <cmd>lua require("packer.load")({'vim-commentary'}, { keys = "gc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gbc <cmd>lua require("packer.load")({'vim-commentary'}, { keys = "gbc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>ps <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>leader>ps", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gcc <cmd>lua require("packer.load")({'vim-commentary'}, { keys = "gcc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>t <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>leader>t", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>rr <cmd>lua require("packer.load")({'rnvimr'}, { keys = "<lt>leader>rr", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType go ++once lua require("packer.load")({'go.nvim'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'lualine.nvim', 'nvim-notify'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'nvim-lspconfig'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-ts-autotag', 'nvim-treesitter-endwise', 'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-colorizer.lua'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/go.nvim/ftdetect/go.vim]], true)
vim.cmd [[source /Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/go.nvim/ftdetect/go.vim]]
time([[Sourcing ftdetect script at: /Users/esequielalbornoz/.local/share/nvim/site/pack/packer/opt/go.nvim/ftdetect/go.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles(0) end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
