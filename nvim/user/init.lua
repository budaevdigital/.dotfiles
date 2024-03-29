--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = false, -- automatically reload and sync packer after a successful update
    auto_quit = false, -- automatically quit the current session after a successful update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme to use
  colorscheme = "default_theme",

  -- Add highlight groups in any theme
  highlights = {
    -- init = { -- this table overrides highlights in all themes
    --   Normal = { bg = "#000000" },
    -- }
    -- duskfox = { -- a table of overrides/changes to the duskfox theme
    --   Normal = { bg = "#000000" },
    -- },
  },

  -- set vim options here (vim.<first_key>.<second_key> = value)
  options = {
    opt = {
      -- set to true or false etc.
      relativenumber = true, -- sets vim.opt.relativenumber
      number = true, -- sets vim.opt.number
      spell = false, -- sets vim.opt.spell
      signcolumn = "auto", -- sets vim.opt.signcolumn to auto
      wrap = false, -- sets vim.opt.wrap
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      autopairs_enabled = true, -- enable autopairs at start
      diagnostics_enabled = true, -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
      ui_notifications_enabled = true, -- disable notifications when toggling UI elements
      heirline_bufferline = true, -- enable new heirline based bufferline (requires :PackerSync after changing)
    },
  },
  -- If you need more control, you can use the function()...end notation
  -- options = function(local_vim)
  --   local_vim.opt.relativenumber = true
  --   local_vim.g.mapleader = " "
  --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
  --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
  --
  --   return local_vim
  -- end,

  -- Set dashboard header
  header = {
    "       d8888 8888888b.  888    d8P         d8888",
    "      d88888 888   Y88b 888   d8P         d88888",
    "     d88P888 888    888 888  d8P         d88P888",
    "    d88P 888 888   d88P 888d88K         d88P 888",
    "   d88P  888 8888888P   8888888b       d88P  888",
    "  d88P   888 888 T88b   888  Y88b     d88P   888",
    " d8888888888 888  T88b  888   Y88b   d8888888888",
    "d88P     888 888   T88b 888    Y88b d88P     888",
  },

  -- Default theme configuration
  default_theme = {
    -- Modify the color palette for the default theme
    colors = {
      fg = "#abb2bf",
      bg = "#1e222a",
    },
    highlights = function(hl) -- or a function that returns a new table of colors to set
      local C = require "default_theme.colors"

      hl.Normal = { fg = C.fg, bg = C.bg }

      -- New approach instead of diagnostic_style
      hl.DiagnosticError.italic = true
      hl.DiagnosticHint.italic = true
      hl.DiagnosticInfo.italic = true
      hl.DiagnosticWarn.italic = true

      return hl
    end,
    -- enable or disable highlighting for extra plugins
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      cmp = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      treesitter = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the global LSP on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the mason server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },
  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    -- first key is the mode
    n = {
      -- Настройки клавиш для управления вкладками задал в файле core/mappings.lua
      ["<Tab>"] = { function() astronvim.nav_buf(vim.v.count > 0 and vim.v.count or 1) end, desc = "Следующая вкладка" },
      ["<S-Tab>"] = { function() astronvim.nav_buf(-(vim.v.count > 0 and vim.v.count or 1)) end, desc = "Предыдуюшая вкладка" },
      ["<Tab>l"] = { function() astronvim.move_buf(vim.v.count > 0 and vim.v.count or 1) end, desc = "Переместить вкладку вправо" },
      ["<Tab>h"] = { function() astronvim.move_buf(-(vim.v.count > 0 and vim.v.count or 1)) end, desc = "Переместить вкладку влево" },
      ["<leader>bb"] = { function() vim.cmd.tabnew() end, desc = "Новый Таб" },
      ["<leader>bl"] = { function() vim.cmd.tabnext() end, desc = "Следующий Таб" },
      ["<leader>bh"] = { function() vim.cmd.tabprevious() end, desc = "Previous tab" },
      -- ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      -- ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      ["<leader>;bf"] = { function()
        require("telescope").extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = vim.fn.expand("%:p:h"),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 25, width = 0.5 }
        }) end, desc = "Файловый Браузер" },

      ["ss"] = { "<cmd>split<Return><C-w>w", desc = "Горизонтальное разделение" },
      ["sv"] = { "<cmd>vsplit<Return><C-w>w", desc = "Вертикальное разделение" },
      ["sC"] = { function() vim.cmd("close") end, desc = "Закрыть окно"},
      ["s<left>"] = { "<C-w>h", desc = "Переключение на окно - слева" },
      ["s<right>"] = { "<C-w>l", desc = "Переключение на окно - вправо" },
      ["s<up>"] = { "<C-w>k", desc = "Переключение на окно - наверх" },
      ["s<down>"] = { "<C-w>j", desc = "Переключение на окно - вниз" },
      ["sh"] = { "<C-w>h", desc = "Переключение на окно - слева" },
      ["sl"] = { "<C-w>l", desc = "Переключение на окно - вправо" },
      ["sj"] = { "<C-w>k", desc = "Переключение на окно - наверх" },
      ["sk"] = { "<C-w>j", desc = "Переключение на окно - вниз" },
      ["<C-w><up>"] = { "<cmd>resize +2<cr>", },
      ["<C-w><down>"] = { "<cmd>resize -2<cr>", },
      ["<C-w><left>"] = { "<cmd>vertical resize -2<cr>", },
      ["<C-w><right>"] = { "<cmd>vertical resize +2<cr>", },

      ["<C-l>"] = { "<cmd>noh<cr>", desc = "Отменить выделения" },
      ["n"] = { "nzzzv", desc = "К следующему выделению" },
      ["N"] = { "Nzzzv", desc = "К предыдущему выделению" },

      ["<leader>w"] = { "<cmd>w<cr>", desc = "Сохранение" },
      ["<leader>q"] = { "<cmd>q<cr>", desc = "Безопасный выход" },
      ["<leader>Q"] = { "<cmd>q!<cr>", desc = "Выход без сохранения" },

      ["<A-up>"] = { "<cmd>move-2<cr>", },
      ["<A-down>"] = { "<cmd>move+<cr>", },
    },
    i = {
      ["<A-up>"] = { "<Esc><cmd>move-2<cr>", },
      ["<A-down>"] = { "<Esc><cmd>move+<cr>", },
    },
    t = {
      -- "setting a mapping to false will disable it"      
      -- ["<esc>"] = false,
    },
  },

  -- Configure plugins
  plugins = {
    init = {
      {"nvim-telescope/telescope-file-browser.nvim",
      config = function()
        require("telescope").setup {
          extensions = {
            file_browser = {
              theme = "dropdown",
              hijack_netrw = true,
              mappings = {
                -- Команды в INSERT режиме
                ["i"] = {
                  ["<C-w>"] = function() vim.cmd("normal vbd") end, },
                -- Команды в NORMAL режиме
                ["n"] = {
                  ["N"] = require("telescope").extensions.file_browser.actions.create,
                  ["h"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
                  ["/"] = function()
                    vim.cmd("startinsert") end, }, }, }, }, } end, },
      { "wakatime/vim-wakatime" },
    },
    -- All other entries override the require("<key>").setup({...}) call for default plugins
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      -- config variable is the default configuration table for the setup function call
      -- local null_ls = require "null-ls"

      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier,

        require("null-ls").builtins.formatting.black.with({ extra_args = { "--line-length", "79" } }),
        require("null-ls").builtins.diagnostics.flake8.with({ extra_args = { "--max-line-length", "79" } }),
      }
      return config -- return final config table
    end,
    treesitter = { -- overrides `require("treesitter").setup(...)`
      -- ensure_installed = { "lua" },
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      -- ensure_installed = { "sumneko_lua" },
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
      -- ensure_installed = { "prettier", "stylua" },
      automatic_setup = true,
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Extend filetypes
    filetype_extend = {
      -- javascript = { "javascriptreact" },
    },
    -- Configure luasnip loaders (vscode, lua, and/or snipmate)
    vscode = {
      -- Add paths for including more VS Code style snippets in luasnip
      paths = {},
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = { name = "Вкладки" },
        },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    vim.cmd([[set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz]])
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

return config
