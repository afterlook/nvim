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
    t({ '#[test]', '#[should_panic]', 'fn ' }),
    i(1, 'name'),
    t({ '() {', '\t' }),
    i(2, { 'unimplemented!();' }),
    t({ '', '}' }),
  }),
}
