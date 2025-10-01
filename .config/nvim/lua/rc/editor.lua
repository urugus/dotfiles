-- ===============================
-- Editor Configuration
-- ===============================
-- neovide
if vim.fn.exists("g:neovide") then
  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_opacity = 0.7
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 20
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_light_angle_degree = 45
  vim.g.neovide_light_radius = 5
  vim.g.neovide_font = "UDEV Gothic LG,Hack Nerd Font,Fira Code"
  vim.g.neovide_default_font_size = 12
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_particle_speed = 10.0
end
