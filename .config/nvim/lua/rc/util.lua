local M = {}

---@param module_name string
---@return fun()
function M.safe_config(module_name)
  return function()
    local ok, result = pcall(require, module_name)
    if not ok then
      vim.schedule(function()
        vim.notify(string.format("config load failed: %s\n%s", module_name, result), vim.log.levels.WARN)
      end)
      return
    end

    if type(result) == "function" then
      local fn_ok, err = pcall(result)
      if not fn_ok then
        vim.schedule(function()
          vim.notify(string.format("config %s execution failed: %s", module_name, err), vim.log.levels.WARN)
        end)
      end
    end
  end
end

---@param path string
---@return fun()
function M.safe_source(path)
  return function()
    local expanded = vim.fn.expand(path)
    if vim.fn.filereadable(expanded) == 0 then
      vim.schedule(function()
        vim.notify(string.format("source target missing: %s", expanded), vim.log.levels.WARN)
      end)
      return
    end

    local ok, err = pcall(vim.cmd.source, expanded)
    if not ok then
      vim.schedule(function()
        vim.notify(string.format("source error (%s): %s", expanded, err), vim.log.levels.WARN)
      end)
    end
  end
end

return M
