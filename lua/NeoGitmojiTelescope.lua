local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local GITMOJI_LIST = require("lua.gitmoji_list")

local results_title = "| List |"
local prompt_title = "| Chose a gitmoji |"
local finder = finders.new_table({
	results = GITMOJI_LIST,
})

local default_opts = {
	layout_strategy = "vertical",
	layout_config = {
		height = 10,
		width = 0.4,
		prompt_position = "top",
	},
}

function M.open(opts)
	opts = opts or default_opts

	pickers
		.new(opts, {
			prompt_title = prompt_title,
			results_title = results_title,
			finder = finder,
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					print(selection[1])
				end)
				return true
			end,
		})
		:find()
end

vim.api.nvim_create_user_command("Test", function()
	package.loaded.NeoGitmojiTelescope = nil
	require("lua.NeoGitmojiTelescope").open()
end, {})

return M