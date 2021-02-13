note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	testing: "type/manual"

class
	ARRAY_COMPARABLE_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	hashable_tests
			-- New test routine
		note
			testing:  "covers/{ARRAY_COMPARABLE}", "execution/isolated"
		local
			l_hash_string,
			l_hash_real_1,
			l_hash_real_2,
			l_hash_integer,
			l_hash_char,
			l_hash_date,
			l_hash_date_time,
			l_hash_time,
			l_hash_boolean,
			l_hash: HASHABLE
		do
			l_hash_string := "abc"; print (l_hash_string.hash_code.out + "%N")
			l_hash_real_1 := 2.99; print (l_hash_real_1.out.hash_code.out + "%N")
			assert_32 ("abc_greater_than_299", l_hash_string.hash_code > l_hash_real_1.hash_code)

			l_hash_real_2 := 2.89; print (l_hash_real_2.out.hash_code.out + "%N")
			assert_32 ("real_vs_real", l_hash_real_1.out.hash_code > l_hash_real_2.out.hash_code)
		end

	array_comparable_tests
			--
		local
			l_array: ARRAY_COMPARABLE [HASHABLE]
			l_decimal: DECIMAL
		do
			create l_decimal.make_from_string ("199.48")		--> 199.48
			create l_array.make_from_array_any (<<l_decimal, "xyz", "abc", 100, "x", [3,"abc","x"], <<1, 2, 4>> >>)
			l_array.sort_asc
			assert_strings_equal ("sorted_asc", sorted_asc, l_array.json_out)
			l_array.sort_desc
			assert_strings_equal ("sorted_desc", sorted_desc, l_array.json_out)

		end

feature {NONE}

	sorted_asc: STRING = "[
[[1,2,4],100,"x","abc","xyz",[3,"abc","x"],199.48]
]"

	sorted_desc: STRING = "[
[199.48,[3,"abc","x"],"xyz","abc","x",100,[1,2,4]]
]"

end


