local M = {}

M.config = function()
  local function pick_color()
    local colors = {"String", "Identifier", "Keyword", "Number"}
    return colors[math.random(#colors)]
  end

  local color = pick_color()
  local kind = require "user.lsp_kind"

  local header = {
    type = "text",
    val = require("user.banners").dashboard(),
    opts = {
      position = "center",
      hl = color,
    },
  }

  local plugins = ""
  local datetime = os.date(kind.icons.calendar .. "%d-%m-%Y ".. kind.icons.clock .. "%H:%M:%S")
  if vim.fn.has "linux" == 1 or vim.fn.has "mac" == 1 then
    local handle = io.popen 'fd -d 2 . $HOME"/.local/share/nvim/site/pack/lazy" | grep pack | wc -l | tr -d "\n" '
    plugins = handle:read "*a"
    handle:close()

    plugins = plugins:gsub("^%s*(.-)%s*$", "%1")
  else
    plugins = "N/A"
  end
  local minor_len = string.len(vim.version().minor)
  local empty_space = ""
  for i = 1, minor_len do
    empty_space = empty_space .. " "
  end

  local plugin_count = {
    type = "text",
    val = "└─ "
      .. kind.cmp_kind.Module
      .. " "
      .. string.format("% 4d", plugins)
      .. " plugins 󰚥 "
      .. vim.version().major
      .. "."
      .. vim.version().minor
      .. "."
      .. vim.version().patch
      .. " ─┘",
    opts = {
      position = "center",
      -- hl = "String",
      hl = color,
    },
  }

  local heading = {
    type = "text",
    val = "┌─ " .. kind.icons.calendar .. empty_space .. "Today is " .. datetime .. " ─┐",
    opts = {
      position = "center",
      -- hl = "String",
      hl = color,
    },
  }

  local fortune = require "alpha.fortune"()
  -- fortune = fortune:gsub("^%s+", ""):gsub("%s+$", "")
  local footer = {
    type = "text",
    val = fortune,
    opts = {
      position = "center",
      hl = "Comment",
      hl_shortcut = "Comment",
    },
  }

  local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = 5,
      width = 24,
      align_shortcut = "right",
      hl_shortcut = "Number",
      hl = "Function",
    }
    if keybind then
      opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
    end

    return {
      type = "button",
      val = txt,
      on_press = function()
        local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
        vim.api.nvim_feedkeys(key, "normal", false)
      end,
      opts = opts,
    }
  end

  local buttons = {
    type = "group",
    val = {
      button(
        "f",
        " " .. kind.cmp_kind.Folder .. " Explore",
        "<cmd>lua require('user.telescope').find_project_files()<CR>"
      ),
      button("e", " " .. kind.cmp_kind.File .. " New file", ":ene <BAR> startinsert <CR>"),
      button("s", " " .. kind.icons.magic .. " Restore", ":lua require('persisted').load()<cr>"),
      button("g", " " .. kind.icons.git .. " Git Status", ":lua require 'lvim.core.terminal'.lazygit_toggle()<CR>"),
      button("r", " " .. kind.icons.clock .. " Recents", ":Telescope oldfiles only_cwd=true<CR>"),
      button("c", " " .. kind.icons.settings .. " Config", ":e ~/.config/nvim/config.lua<CR>"),
      button("q", " " .. kind.icons.exit .. " Quit", ":q<CR>"),
    },
    opts = {
      spacing = 1,
    },
  }

  local section = {
    header = header,
    buttons = buttons,
    plugin_count = plugin_count,
    heading = heading,
    footer = footer,
  }

  local opts = {
    layout = {
      { type = "padding", val = 1 },
      section.header,
      { type = "padding", val = 2 },
      -- section.top_bar,
      section.buttons,
      { type = "padding", val = 1 },
      section.heading,
      -- section.plugin_count,
      -- section.bot_bar,
      -- { type = "padding", val = 1 },
      section.footer,
    },
    opts = {
      margin = 5,
    },
  }
  return opts
end

return M
