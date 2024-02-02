--local ls = require("luasnip")
--local s = ls.snippet
--
---- local i = ls.insert_node
--local t = ls.text_node
----
---- -- local d = ls.dynamic_node
---- -- local c = ls.choice_node
---- -- local f = ls.function_node
---- -- local sn = ls.snippet_node
---- --
---- -- local fmt = require("luasnip.extras.fmt").fmt
---- -- local r = require("luasnip.extras").rep
----
---- local p = require("luasnip.extras").partial
---- -- /*
---- --  * Copyright (C) 2020 Transcom Worldwide
---- --  *
---- --  *
---- --  * This file cannot be copied and/or distributed without the express permission of Transcom Worldwide.
---- --  *
---- --  * Author: vicente.espejo
---- --  * Date:
---- --  * Last Modified by: vicente.espejo
---- --  * Last Modified time: 2021-11-11 15:23:53
---- --  *
---- --  */
----
return {
	s({ trig = "tc", name = "Transcom Copyright", dscr = "Insertar Transcom Copyright" }, {
		t("/*"),
		t({ "", " * Copyright (c) " }),
		p(os.date, "%Y"),
		t(" Transcom Worldwide"),
		t({ "", " *" }),
		t({ "", " *" }),
		t({
			"",
			" * This file cannot be copied and/or distributed without the express permission of Transcom Worldwide",
		}),
		t({ "", " *" }),
		t({ "", " * Author: vicente.espejo" }),
		t({ "", " * Date: " }),
		p(os.date, "%Y-%m-%d"),
		t({ "", " *" }),
		t({ "", " */" }),
	}),
}, {}
