local ok, surround = pcall(require, "nvim-surround")
if not ok then
  return
end

surround.setup({
  -- Configuration here, or leave empty to use defaults
})
