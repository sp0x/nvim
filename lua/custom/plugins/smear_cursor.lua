return {
  'sphamba/smear-cursor.nvim',
  opts = {},
  config = function()
    require('smear_cursor').setup {
      stiffness = 0.5,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
      cursor_color = '#ff8800',
      trailing_exponent = 5,
      hide_target_hack = true,
      gamma = 1,
    }
  end,
}
