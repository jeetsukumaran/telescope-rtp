local sorters = require('telescope.sorters')

local M = {}

M.tbl_clone = function(original)
  local copy = {}
  for key, value in pairs(original) do
    copy[key] = value
  end
  return copy
end

M.path_display = function(opts, transformed_path)
    local dir, file, ext = string.match(transformed_path, "(.-)([^\\/]-%.?([^%.\\/]*))$")
    return file
end

M.grep_highlighter_only = function(opts)
  return sorters.Sorter:new {
    scoring_function = function() return 0 end,
    highlighter = function(_, prompt, display)
      return {}
    end,
  }
end

M.cmd_generator = function(opts, prompt, subdir)
    if not prompt or prompt == "" then
        return nil
    end
    local args = M.tbl_clone(opts.vimgrep_arguments)
    local prompt_parts = vim.split(prompt, " ")
    local rtp_path_str = vim.o.runtimepath
    local rtp_paths = vim.split(rtp_path_str, ",")
    local doc_paths
    if subdir == nil then
        doc_paths = rtp_paths
    else
        doc_paths = {}
        for key, path in pairs(rtp_paths) do
            doc_paths[key] = path .. "/doc"
        end
    end
    local cmd = vim.tbl_flatten { args, prompt_parts, doc_paths}
    return cmd
end

return M

