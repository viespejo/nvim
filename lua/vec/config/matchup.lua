local g = vim.g
g.matchup_matchparen_deferred = 1
g.matchup_matchparen_deferred_show_delay = 100
g.matchup_matchparen_hi_surround_always = 1
g.matchup_override_vimtex = 1
g.matchup_delim_start_plaintext = 0
g.matchup_transmute_enabled = 0

-- TODO when install treesitter plugin copy in treesitter config
-- require'nvim-treesitter.configs'.setup {
--   matchup = {
--     enable = true,              -- mandatory, false will disable the whole extension
--     disable = { "c", "ruby" },  -- optional, list of language that will be disabled
--     -- [options]
--   },
-- }
