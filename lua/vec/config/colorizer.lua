local ok, colorizer = pcall(require, "colorizer")
if not ok then
 return
end

colorizer.setup({
  'css';
  'javascript';
  html = { mode = 'background' };
}, { mode = 'foreground' })
