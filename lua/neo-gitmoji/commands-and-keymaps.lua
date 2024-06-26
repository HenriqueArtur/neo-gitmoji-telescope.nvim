local start_neo_gitmoji = require("neo-gitmoji").open_floating

local M = {}

function M.set_commands()
  vim.api.nvim_create_user_command("NeoGitmoji", function() start_neo_gitmoji() end, {})
end

function M.set_keymaps()
  vim.keymap.set("n", "<leader>gm", function() start_neo_gitmoji() end, {
    desc = "Gitmoji",
  })
end

return M
