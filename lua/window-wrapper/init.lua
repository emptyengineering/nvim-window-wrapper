-- lua/window-wrapper/init.lua

---Window Wrapper
--
-- Dirt-simple plugin that allows window navigation to
-- wrap around upper and lower bounds.

local M = {}

---Gets all windows and returns the first and last positionally.
-- @return The first window, the last window.
function M.get_first_and_last_window()
  local all_wins = vim.api.nvim_list_wins()
  local first_win = all_wins[1]
  local last_win = all_wins[#all_wins]
  return first_win, last_win
end

---When on the first window, pressing the control key and navigating left,
---reroute to the last window. If not, continue as usual.
local function wrap_first_window_to_last()
  local first_win, last_win = get_first_and_last_window()
  local should_reroute = vim.api.nvim_get_current_win() == first_win

  if should_reroute then
    vim.api.nvim_set_current_win(last_win)
  else
    vim.cmd('wincmd h')
  end
end

---When on the last window, pressing the control key and navigating right,
---reroute to the first window. If not, continue as usual.
local function wrap_last_window_to_first()
  local first_win, last_win = get_first_and_last_window()
  local should_reroute = vim.api.nvim_get_current_win() == last_win

  if should_reroute then
    vim.api.nvim_set_current_win(first_win)
  else
    vim.cmd('wincmd l')
  end
end

vim.keymap.set('n', '<C-w>h', wrap_first_window_to_last, { desc = 'Conditional <C-w>h to Last Window' })
vim.keymap.set('n', '<C-w>l', wrap_last_window_to_first, { desc = 'Conditional <C-w>l to First Window' })

return M
