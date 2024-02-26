--[[
  # 1 - [x] Get node
  # 2 - [x] Identify if is accepted scoped type
  # 3 - [] Identify if is in last position
  # 4 - [] Place afte the scope
--]]
--

local ts_utils = require("nvim-treesitter.ts_utils")
local M = {}

STRING_CONTENT = "string_content"
STRING_FRAGMENT = "string_fragment"
STRING_END = "string_end"
STRING = "string"

ELIGIBLE_SCOPE_TYPES = {}
ELIGIBLE_SCOPE_TYPES[STRING_CONTENT] = true
ELIGIBLE_SCOPE_TYPES[STRING_FRAGMENT] = true
ELIGIBLE_SCOPE_TYPES[STRING] = true
ELIGIBLE_SCOPE_TYPES[STRING_END] = true

local p = function(val)
  print(vim.inspect(val))
end

p(WIN_ID)
local get_master_node = function()
  local node = ts_utils.get_node_at_cursor(WIN_ID, true)

  if node == nil then
    error("No Treesitter parser found!")
  end

  return node
end

---@param node TSNode
local get_mouse_pos_in_node = function(node)
  print("Cursor at >> " .. CURSOR_POSITION[1], CURSOR_POSITION[2])
  local start_line, start_char = node:start()
  local end_line, end_char = node:end_()

  print("Node Start >> " .. start_line .. " < WTF >" .. start_char)
  print("Node End >> " .. end_line .. " < WTF >" .. end_char)

  return { CURSOR_POSITION[2], end_char }
end

local get_cursor_pos = function()
  WIN_ID = vim.api.nvim_get_current_win()
  CURSOR_POSITION = vim.api.nvim_win_get_cursor(WIN_ID)
end

M.identify_scope = function()
  get_cursor_pos()
  local node = get_master_node()
  local actual_node = node:parent()

  print("Parent >> " .. actual_node:type())

  if ELIGIBLE_SCOPE_TYPES[node:type()] then
    print("Is " .. node:type())
    local pos = get_mouse_pos_in_node(node)

    vim.api.nvim_win_set_cursor(WIN_ID, { CURSOR_POSITION[1], pos[2] })
    p("Set pos in line >> ")
  else
    print("Is not string >> " .. node:type())
  end
end

return M
