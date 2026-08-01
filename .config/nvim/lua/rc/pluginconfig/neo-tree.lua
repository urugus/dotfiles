-- See ":help neo-tree-highlights" for a list of available highlight groups
vim.cmd([[
        hi link NeoTreeDirectoryName Directory
        hi link NeoTreeDirectoryIcon NeoTreeDirectoryName
      ]])

require("neo-tree").setup({
  close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "ﰊ",
      default = "*",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
    },
    git_status = {
      highlight = "NeoTreeDimText", -- if you remove this the status will be colorful
    },
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function(_)
        --auto close
        require("neo-tree").close_all()
      end,
    },
    {
      event = "file_added",
      handler = function(file_path)
        require("neo-tree.utils").open_file({}, file_path)
      end,
    },
  },
  filesystem = {
    filtered_items = {
      visible = true, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_by_name = {
        ".DS_Store",
        "thumbs.db",
        --"node_modules"
      },
      never_show = { -- remains hidden even if visible is toggled to true
        ".DS_Store",
        --"thumbs.db"
      },
    },
    -- 開いているファイルを自動で追従する (v3 はテーブル指定)
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = false, -- This will use the OS level file watchers
    -- to detect changes instead of relying on nvim autocmd events.
    hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
    -- in whatever position is specified in window.position
    -- "open_split",  -- netrw disabled, opening a directory opens within the
    -- window like netrw would, regardless of window.position
    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    window = {
      position = "left",
      width = 30,
      mappings = {
        ["I"] = "toggle_gitignore",
        ["<c-x>"] = "clear_filter",
      },
    },
  },
  buffers = {
    show_unloaded = true,
    window = {
      position = "left",
      mappings = {
        -- v3 のデフォルトは buffer_delete だが、他ソースと揃えて d は delete にする
        ["d"] = "delete",
        ["bd"] = "buffer_delete",
      },
    },
  },
  git_status = {
    window = {
      position = "float",
    },
  },
  -- 全ソース共通。ここに書いたものは各ソースのデフォルトにマージされる。
  window = {
    mappings = {
      ["c"] = "copy_to_clipboard", -- デフォルトは copy (パス入力を伴う)
      ["<C-s>"] = "open_split", -- デフォルトは quick_jump
      ["<C-v>"] = "open_vsplit",
    },
  },
})
