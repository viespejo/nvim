local ok, filetype = pcall(require, "filetype")
if not ok then
  return
end
-- In init.lua or filetype.nvim's config file
filetype.setup({
  overrides = {
    extensions = {
      pjs = "javascript",
      scm = "query",
      html = "html",
    },
  },
})
