note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	STRING_EXT_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	string_repeat_tests
			-- New test routine
		note
			testing:  "covers/{STRING_EXT}.repeat", "execution/isolated"
		local
			s, t: STRING_EXT
		do
			create s.make_from_string ("Spam!")

			t := s.repeat (8)
			t := s * 8
			assert_strings_equal ("no_delimit", "Spam!Spam!Spam!Spam!Spam!Spam!Spam!Spam!", t.out)

			t := s.repeat_comma_delimited (8)
			t := s ^ 8
			assert_strings_equal ("comma_delimit", "Spam!,Spam!,Spam!,Spam!,Spam!,Spam!,Spam!,Spam!", t.out)

			t := s.repeat_tab_delimited (8)
			t := s & 8
			assert_strings_equal ("tab_delimit", "Spam!%TSpam!%TSpam!%TSpam!%TSpam!%TSpam!%TSpam!%TSpam!", t.out)

			t := s.repeat_space_delimited (8)
			t := s # 8
			assert_strings_equal ("space_delimit", "Spam! Spam! Spam! Spam! Spam! Spam! Spam! Spam!", t.out)

			t := s.repeat_bar_delimited (8)
			t := s | 8
			assert_strings_equal ("bar_delimit", "Spam!|Spam!|Spam!|Spam!|Spam!|Spam!|Spam!|Spam!", t.out)

			t := s.repeat_user_delimited (8, ':')
			t := s / [8, ':']
			assert_strings_equal ("user_delimit", "Spam!:Spam!:Spam!:Spam!:Spam!:Spam!:Spam!:Spam!", t.out)
		end

	string_minus_test
			--
		note
			testing:  "covers/{STRING_EXT}.minus", "execution/isolated"
		local
			s: STRING_EXT
		do
			create s.make_from_string ("abc")
			s := s - "b"
			assert_strings_equal ("abc_to_ac", "ac", s.out)
		end

end


