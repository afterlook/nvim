local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local r = require('luasnip.extras').rep

return {
  s({ trig = 'ie' }, {
    t({ 'if ' }),
    i(1, { 'err' }),
    t({ ' != nil {', '\treturn ' }),
    i(2, { 'err' }),
    t({ '', '}', '' }),
  }),
}
