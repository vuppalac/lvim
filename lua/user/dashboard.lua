local M = {}

M.config = function()
  local present, alpha = pcall(require, "alpha")
  if not present then
    return
  end

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

  local handle = io.popen 'fd -d 2 . $HOME"/.local/share/lunarvim/site/pack/packer" | grep pack | wc -l | tr -d "\n" '
  local plugins = handle:read "*a"
  handle:close()

  -- local thingy = io.popen 'echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"'
  -- local date = thingy:read "*a"
  -- thingy:close()
  local datetime = os.date(kind.icons.calendar .. "%d-%m-%Y ".. kind.icons.clock .. "%H:%M:%S")
  plugins = plugins:gsub("^%s*(.-)%s*$", "%1")

  local plugin_count = {
    type = "text",
    -- val = "└─   " .. plugins .. " plugins in total ─┘",
    --val = "└─   " .. plugins .. " plugins in total ─┘",
    val = "└─ " .. kind.cmp_kind.Module .. " " .. plugins .. " plugins in total ─┘",
    opts = {
      position = "center",
      -- hl = "String",
      hl = color,
    },
  }

  local heading = {
    type = "text",
    -- val = "┌─   Today is " .. date .. " ─┐",
    -- val = "   " .. plugins .. " plugins loaded ➖ " .. datetime,
    val = "  " .. plugins .. " plugins loaded ➖ " .. datetime,
    -- val = "┌─ " .. kind.icons.calendar .. " Today is " .. date .. " ─┐",
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
      button("f", " " .. kind.cmp_kind.Folder .. " Explore", ":Telescope find_files<CR>"),
      button("e", " " .. kind.cmp_kind.File .. " New file", ":ene <BAR> startinsert <CR>"),
      button("s", " " .. kind.icons.magic .. " Restore", ":lua require('persistence').load()<cr>"),
      button(
        "g",
        " " .. kind.icons.git .. " Git Status",
        ":lua require('lvim.core.terminal')._exec_toggle({cmd = 'lazygit', count = 1, direction = 'float'})<CR>"
      ),
      button("r", " " .. kind.icons.clock .. " Recents", ":Telescope oldfiles<CR>"),
      button("o", " " .. kind.icons.settings .. " Options", ":e ~/.config/lvim/config.lua<CR>"),
      button("m", " " .. kind.icons.Marks ..  " Marks", ":Telescope marks<CR>"),
      button("c", " " .. kind.icons.settings .. " Config", ":e ~/.config/lvim/config.lua<CR>"),
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
  alpha.setup(opts)
end

return M
