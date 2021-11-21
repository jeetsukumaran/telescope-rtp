local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  error("This plugin requires nvim-telescope/telescope.nvim")
end

local telescope = require("telescope")
local pickers = require "telescope.pickers"
local conf = require('telescope.config').values
local make_entry = require('telescope.make_entry')
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local rtp = require("telescope-rtp.rtplib")
local cmd_generator = rtp.cmd_generator
local path_display = rtp.path_display
local grep_highlighter_only = rtp.grep_highlighter_only
local vim_docs = function(opts)
    opts = opts or {}
    opts.vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments
    opts.path_display = path_display
    opts.disable_coordinates = true
    opts.entry_maker = opts.entry_maker or make_entry.gen_from_vimgrep(opts)
    opts.cwd = opts.cwd and vim.fn.expand(opts.cwd)
    pickers.new(opts, {
        prompt_title = 'Vimdocs',
        finder = finders.new_job(function(prompt)
                return cmd_generator(opts, prompt, "doc")
            end,
            opts.entry_maker,
            opts.max_results,
            opts.cwd),
        previewer = conf.grep_previewer(opts),
        sorter = grep_highlighter_only(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                -- for k,v in pairs(selection) do print(k,v) end
                -- 1: <display>
                -- text: line
                -- col
                -- lnum
                -- filename
                vim.cmd("e " .. selection.filename  .. "| :" .. selection.lnum ..  "| set ft=help")
            end)
            return true
        end
    }):find()
end

-- to execute the function
-- vimdocs()
return telescope.register_extension({ exports = { vim_docs = vim_docs } })


