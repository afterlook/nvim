local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local r = require('luasnip.extras').rep

return {
  ls.snippet({ trig = 'testmod' }, {
    t({ '#[cfg(test)]', 'mod tests {', '\tuse super::*;', '', '\t' }),
    i(1, { '// add tests here' }),
    t({ '', '}' }),
  }),

  ls.snippet({ trig = 'testpanic' }, {
    t({ '#[test]', '#[should_panic(expected = "' }),
    i(1, 'expected panic partial string'),
    t({ '")]', 'fn ' }),
    i(2, 'name'),
    t({ '() {', '\t' }),
    i(3, { 'unimplemented!();' }),
    t({ '', '}' }),
  }),
}
