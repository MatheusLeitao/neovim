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
  local start_line, start_char = node:start()
  local end_line, end_char = node:end_()

  return { CURSOR_POSITION[2], end_char }
end

local get_cursor_pos = function()
  WIN_ID = vim.api.nvim_get_current_win()
  CURSOR_POSITION = vim.api.nvim_win_get_cursor(WIN_ID)
end

---@return boolean
local is_last_pos = function(cursor_pos, node_last_pos)
  if cursor_pos ~= node_last_pos - 1 then
    return false
  end

  return true
end

M.identify_scope = function()
  print("It went trought")
  get_cursor_pos()
  local node = get_master_node()
  local actual_node = node:parent()

  if ELIGIBLE_SCOPE_TYPES[node:type()] then
    local pos = get_mouse_pos_in_node(node)
    local is_last = is_last_pos(CURSOR_POSITION[2], pos[2])
    -- p(is_last)

    if is_last then
      vim.api.nvim_win_set_cursor(WIN_ID, { CURSOR_POSITION[1], pos[2] })
      -- else
      --   local bufnr = vim.api.nvim_get_current_buf()
      --   local cursor_pos = vim.api.nvim_win_get_cursor(WIN_ID)
      --   vim.api.nvim_buf_set_text(bufnr, CURSOR_POSITION[1], CURSOR_POSITION[2], CURSOR_POSITION[1], CURSOR_POSITION[2] { "\t" })
    end
  else
    print("Is not string >> " .. node:type())
  end
end

return M
