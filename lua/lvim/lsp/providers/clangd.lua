local clangd_bin = vim.fn.stdpath "data" .. "/lsp_servers/clangd/clangd"
-- local clangd_bin = "clangd"
local clangd_flags = {
  -- "--all-scopes-completion",
  -- "--suggest-missing-includes",
  "--background-index",
  -- "--pch-storage=disk",
  -- "--cross-file-rename",
  -- "--log=info",
  -- "--completion-style=detailed",
  -- "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
  "--header-insertion=never",
  -- "--cross-file-rename",
  "--clang-tidy",
  -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
  "--compile-commands-dir=build_el7_2020_05"
  -- "--fallback-style=Google",
  -- "--header-insertion=never",
  -- "--query-driver=<list-of-white-listed-complers>"
}

local opts = {
  cmd = { clangd_bin, unpack(clangd_flags)}
}
return opts
