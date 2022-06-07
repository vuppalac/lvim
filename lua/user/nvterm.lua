local M = {}

M.config = function()
  local status_ok, nvterm = pcall(require, "nvterm")
  if not status_ok then
    return
  end

  nvterm.setup({
    terminals = {
      list = {},
      type_opts = {
        float = {
          relative = 'editor',
          row = 0.3,
          col = 0.25,
          width = 0.5,
          height = 0.4,
          border = "single",
        },
        horizontal = { location = "rightbelow", split_ratio = .3, },
        vertical = { location = "rightbelow", split_ratio = .5 },
      }
    },
    behavior = {
      close_on_exit = true,
      auto_insert = true,
    },
  })
end

return M
