note
	description: "Extension on {STRING_32}"
	design: "[
		Most of the new functions are about repeating elements
		with various delimiters. There is also the notion of
		minus.
		]"

class
	STRING_EXT

inherit
	STRING_32

create
	make,
	make_empty,
	make_filled,
	make_from_c,
	make_from_c_byte_array,
	make_from_c_pointer,
	make_from_cil,
	make_from_separate,
	make_from_string,
	make_from_string_general

feature

	repeat alias "*" (n: INTEGER): like Current
			-- Repeat Current `n' times.
		do
			Result := repeat_delimited (Current, n, null_char)
		end

	repeat_comma_delimited alias "^" (n: INTEGER): like Current
			-- Repeat Current `n' times, comma delimited.
		do
			Result := repeat_delimited (Current, n, ',')
		end

	repeat_tab_delimited alias "&" (n: INTEGER): like Current
			-- Repeat Current `n' times, tab delimited.
		do
			Result := repeat_delimited (Current, n, '%T')
		end

	repeat_space_delimited alias "#" (n: INTEGER): like Current
			-- Repeat Current `n' times, space delimited.
		do
			Result := repeat_delimited (Current, n, ' ')
		end

	repeat_bar_delimited alias "|" (n: INTEGER): like Current
			-- Repeat Current `n' times, bar delimited.
		do
			Result := repeat_delimited (Current, n, '|')
		end

	repeat_user_delimited alias "/" (t: TUPLE [n: INTEGER; c: CHARACTER]): like Current
			-- Repeat Current `n' times, user-supplied character delimited.
		do
			Result := repeat_delimited (Current, t.n, t.c)
		end

	repeat_delimited (s: READABLE_STRING_GENERAL; n: INTEGER; c: detachable CHARACTER): like Current
			-- Repeat Current `n' times, possibly delimited by `c'.
		do
			create Result.make_empty
			⟳ ic: 1 |..| n ¦
				Result.append_string_general (s)
				if attached c and then c /= '%U' then
					Result.append_character (c)
				end
			⟲
			if attached c and then c /= '%U' then
				Result.remove_tail (1)
			end
		end

	minus alias "-" (s: READABLE_STRING_GENERAL): like Current
			-- Remove all occurances of `s' from Current.
		do
			Result := Current
			Result.replace_substring_all (s, "")
		end

feature {NONE} -- Implementation: Constants

	null_char: detachable CHARACTER
			-- Default `null_character' (Void).

end
