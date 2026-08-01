-- LSP "go to X" helper: sends a location request, jumps to the best result, and
-- surfaces progress/outcome via the snacks notifier. (The bundled fidget is the
-- legacy build and has no progress API, so we use snacks here.)

local M = {}

local NOTIFY_ID = "rc_lsp_locate"

local function snake_case(value)
  return value:gsub("::", "/"):gsub("([A-Z]+)([A-Z][a-z])", "%1_%2"):gsub("([a-z%d])([A-Z])", "%1_%2"):lower()
end

local function method_label(method)
  return (method:gsub("^textDocument/", ""))
end

local function lsp_location_uri(location)
  return location.uri or location.targetUri
end

local function lsp_location_path(location)
  local uri = lsp_location_uri(location)
  return uri and vim.uri_to_fname(uri) or nil
end

local function best_lsp_location(result)
  if not result then
    return nil
  end
  if result.uri or result.targetUri then
    return result
  end

  local symbol_path = snake_case(vim.fn.expand("<cword>")) .. ".rb"
  for _, location in ipairs(result) do
    local path = lsp_location_path(location)
    if path and path:sub(-#symbol_path) == symbol_path then
      return location
    end
  end

  return result[1]
end

local function jump_to_lsp_location(location, client_id)
  local client = vim.lsp.get_client_by_id(client_id)
  local offset_encoding = client and client.offset_encoding or "utf-16"

  if location.targetUri then
    location = {
      uri = location.targetUri,
      range = location.targetSelectionRange or location.targetRange,
    }
  end

  vim.lsp.util.show_document(location, offset_encoding, { reuse_win = true, focus = true })
end

local function notify(message, level, opts)
  opts = vim.tbl_extend("keep", opts or {}, { id = NOTIFY_ID, title = "LSP" })
  vim.notify(message, level, opts)
end

local function hide_notify()
  local ok, snacks = pcall(require, "snacks")
  if ok and snacks.notifier then
    snacks.notifier.hide(NOTIFY_ID)
  end
end

function M.location(method, extend_params)
  return function()
    local clients = vim.tbl_filter(function(client)
      return client:supports_method(method, 0)
    end, vim.lsp.get_clients({ bufnr = 0 }))
    local client = clients[1]
    local label = method_label(method)
    if not client then
      notify("no client for " .. label, vim.log.levels.WARN)
      return
    end

    local params = vim.lsp.util.make_position_params(0, client.offset_encoding or "utf-16")
    if extend_params then
      extend_params(params)
    end

    local jumped = false
    local finished = false
    local pending = #clients

    -- Show a "searching" hint only if the request is slow, so fast jumps do not flash.
    vim.defer_fn(function()
      if not finished then
        notify(label .. ": searching…", vim.log.levels.INFO, { timeout = false })
      end
    end, 150)

    local function finish(message, level)
      if finished then
        return
      end
      finished = true
      if message then
        notify(label .. ": " .. message, level or vim.log.levels.INFO)
      else
        hide_notify()
      end
    end

    -- Safety net: replace the spinner if the server is very slow, but keep
    -- accepting a late response — the jump is gated only by `jumped`.
    vim.defer_fn(function()
      if not jumped then
        finish("still searching… (LSP slow)", vim.log.levels.WARN)
      end
    end, 20000)

    for _, lsp_client in ipairs(clients) do
      lsp_client:request(method, params, function(err, result, ctx)
        pending = pending - 1
        if jumped then
          return
        end
        if err then
          if pending == 0 then
            finish("error", vim.log.levels.ERROR)
          end
          return
        end

        local location = best_lsp_location(result)
        if not location then
          if pending == 0 then
            finish("not found", vim.log.levels.WARN)
          end
          return
        end

        jumped = true
        finish()
        jump_to_lsp_location(location, ctx.client_id)
      end, 0)
    end
  end
end

return M
