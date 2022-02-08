-- Neovim
-- =========================================
lvim.format_on_save = false
lvim.leader = " "
lvim.colorscheme = "pablo"
lvim.debug = false
vim.lsp.set_log_level "warn"
lvim.log.level = "warn"
require("user.neovim").config()

-- Customization
-- =========================================
lvim.builtin.sell_your_soul_to_devil = false -- if you want microsoft to abuse your soul
lvim.builtin.lastplace = { active = true } -- change to false if you are jumping to future
lvim.builtin.tabnine = { active = false } -- change to false if you don't like tabnine
lvim.builtin.persistence = { active = true } -- change to false if you don't want persistence
lvim.builtin.presence = { active = false } -- change to true if you want discord presence
lvim.builtin.orgmode = { active = false } -- change to true if you want orgmode.nvim
lvim.builtin.dap.active = false -- change this to enable/disable debugging
lvim.builtin.fancy_statusline = { active = true } -- enable/disable fancy statusline
lvim.builtin.fancy_dashboard = { active = true } -- enable/disable fancy dashboard
lvim.builtin.fancy_wild_menu = { active = true } -- enable/disable use wilder.nvim
lvim.builtin.fancy_rename = { active = true } -- enable/disable custom rename
lvim.builtin.fancy_diff = { active = true } -- enable/disable fancier git diff
lvim.builtin.lua_dev = { active = true } -- change this to enable/disable folke/lua_dev
lvim.builtin.test_runner = { active = false } -- change this to enable/disable vim-test, ultest
lvim.builtin.cheat = { active = false } -- enable cheat.sh integration
lvim.builtin.sql_integration = { active = false } -- use sql integration
lvim.builtin.neoscroll = { active = true } -- smooth scrolling
lvim.builtin.neoclip = { active = false, enable_persistant_history = false }
lvim.builtin.nonumber_unfocus = false -- diffrentiate between focused and non focused windows
lvim.builtin.harpoon = { active = false } -- use the harpoon plugin
lvim.builtin.remote_dev = { active = false } -- enable/disable remote development
lvim.builtin.global_status_line = { active = false } -- WARN: doesn't work with nvim head
lvim.builtin.cursorline = { active = true } -- use a bit fancier cursorline
lvim.builtin.motion_provider = "hop" -- change this to use different motion providers ( hop or lightspeed )
lvim.builtin.hlslens = { active = false } -- enable/disable hlslens
lvim.builtin.csv_support = false -- enable/disable csv support
lvim.builtin.sidebar = { active = false } -- enable/disable sidebar
lvim.builtin.async_tasks = { active = true } -- enable/disable async tasks
lvim.builtin.metals = {
  active = false, -- enable/disable nvim-metals for scala development
  fallbackScalaVersion = "2.13.7",
  serverVersion = "0.10.9+271-a8bb69f6-SNAPSHOT",
}
lvim.builtin.collaborative_editing = { active = false } -- enable/disable collaborative editing
lvim.builtin.file_browser = { active = false } -- enable/disable telescope file browser
lvim.builtin.sniprun = { active = false } -- enable/disable sniprun
lvim.builtin.tag_provider = "symbols-outline" -- change this to use different tag providers ( symbols-outline or vista )

lvim.builtin.gitsigns.opts.git_path = "git" -- use a custom gitsigns, which has support for non-default git command location

local user = os.getenv "USER"
if user and user == "abz" then
  lvim.builtin.nvim_web_devicons = { active = false }
  lvim.builtin.sell_your_soul_to_devil = true
  lvim.lsp.document_highlight = false
  lvim.builtin.csv_support = true
  lvim.builtin.async_tasks.active = true
  lvim.builtin.dap.active = true
  lvim.builtin.sql_integration.active = true
  vim.g.instant_username = user
  lvim.builtin.collaborative_editing.active = true
  lvim.builtin.file_browser.active = true
  require("user.prose").config() -- setup prosemd-lsp for my local use
end
lvim.lsp.diagnostics.virtual_text = false -- remove this line if you want to see inline errors
lvim.builtin.notify.active = true
lvim.lsp.automatic_servers_installation = false
if lvim.builtin.cursorline.active then
  lvim.lsp.document_highlight = false
end
lvim.lsp.code_lens_refresh = true
require("user.builtin").config()

-- StatusLine
-- =========================================
if lvim.builtin.fancy_statusline.active then
  require("user.lualine").config()
end

-- Debugging
-- =========================================
if lvim.builtin.dap.active then
  require("user.dap").config()
end

-- Language Specific
-- =========================================
vim.list_extend(lvim.lsp.override, {
  "rust_analyzer",
  "tsserver",
  "dockerls",
  "texlab",
  "sumneko_lua",
  "gopls",
  "yamlls",
  "r_language_server",
  "pyright",
  "clangd",
})
require("user.null_ls").config()

-- Additional Plugins
-- =========================================
require("user.plugins").config()

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Additional keybindings
-- =========================================
require("user.keybindings").config()
