note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	testing: "type/manual"

class
	ARRAY_EXT_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	array_json_out_test
			-- New test routine
		note
			testing:  "execution/isolated",
				"covers/{ARRAY_EXT}.json_out",
				"covers/{ARRAY_EXT}.to_json_array"
		local
			l_ext: ARRAY_EXT [HASHABLE]
			l_decimal: DECIMAL
		do
			create l_decimal.make_from_string ("199.48")		--> 199.48
			print (l_decimal.out + "%N")						--> 199.48
			print (l_decimal.to_engineering_string + "%N")		--> 199.48
			print (l_decimal.to_scientific_string + "%N")		--> 199.48
			print (l_decimal.out_tuple + "%N")					--> [0,19948,-2]
			create l_ext.make_from_array_any (<<1, {REAL} 2.99, {REAL_32} 2.99, {REAL_64} 2.99, 3, "a", 'b', "c", [3, "abc", 'x'], <<1, 2, 4>>, l_decimal >>)
			assert_strings_equal ("array_ext_json_out", array_ext_json_out, l_ext.json_out)
		end

feature {NONE} -- Test Constants

	array_ext_json_out: STRING = "[
[1,2.9900000095367432,2.9900000095367432,2.9900000000000002,3,"a","b","c",[3,"abc","x"],[1,2,4],199.48]
]"

end


