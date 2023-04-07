local wezterm = require "wezterm"

---------------------------------------------------------------
--- wezterm on
---------------------------------------------------------------

-- set tab-title to git root name
wezterm.on("format-tab-title", function(tab)
  local git_root = wezterm.run_child_process({"git", "rev-parse", "--show-toplevel"})
  if git_root and #git_root > 0 then
    local dirname = git_root[1]:gsub("\n", ""):match("([^/]+)$")
    return {
      {Text=dirname},
    }
  end

  -- if git root not found, set default tab-title
  return {
    {Text=tab.active_pane.title},
  }
end)
