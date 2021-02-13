note
	description: "[
		Sequences of values, all of the same type or of a conforming one,
		accessible through integer indices in a contiguous interval.
	]"
	design: "[
		Additional features include a JSON-based representation of the
		array, such that JSON-based systems can easily interact with
		Eiffel ARRAYs.
		]"

class
	ARRAY_EXT [G -> HASHABLE]

inherit
	ARRAY [HASHABLE]
		redefine
			out
		end

create
	make,
	make_empty,
	make_filled,
	make_from_array,
	make_from_array_any,
	make_from_cil,
	make_from_special

feature {NONE} -- Initialization

	make_from_array_any (a_array: ARRAY [ANY])
			--
		local
			i: INTEGER
			t: TUPLE
		do
			make_filled (0, 1, a_array.count)
			⟳ ic:a_array ¦
				i := i + 1
				if attached {HASHABLE} ic as al_item then
					put (al_item, i)
				elseif attached {ARRAY [ANY]} ic as al_array then
					t := []
					⟳ ic_item: al_array ¦
						check has_t: attached t as al_t then
							t := al_t + [ic_item]
						end
					⟲
					check has_t_complete: attached {HASHABLE} t as al_t then
						put (al_t, i)
						check has_t_put: has (al_t) end
					end
				else
					check unknown: False end
				end
			⟲
		end

feature -- Conversion

	to_json_array (a_array: READABLE_INDEXABLE [HASHABLE]): JSON_ARRAY
			-- Convert `a_array' to {JSON_ARRY}.
		local
			l_array: ARRAY [HASHABLE]
			i: INTEGER
		do
			create Result.make (0)
			⟳ ic:a_array ¦
				if attached {STRING} ic as al_string then
					Result.extend (create {JSON_STRING}.make_from_string (al_string))
				elseif attached {CHARACTER} ic as al_char then
					Result.extend (create {JSON_STRING}.make_from_string (al_char.out))
				elseif attached {NUMERIC} ic as al_numeric then
					if attached {INTEGER} al_numeric as al_integer then
						Result.extend (create {JSON_NUMBER}.make_integer (al_integer))
					elseif attached {NATURAL} al_numeric as al_natural then
						Result.extend (create {JSON_NUMBER}.make_natural (al_natural))
					elseif attached {REAL} al_numeric as al_real then
						Result.extend (create {JSON_NUMBER}.make_real (al_real))
					elseif attached {REAL_32} al_numeric as al_real then
						Result.extend (create {JSON_NUMBER}.make_real (al_real))
					elseif attached {REAL_64} al_numeric as al_real then
						Result.extend (create {JSON_NUMBER}.make_real (al_real))
					elseif attached {DECIMAL} al_numeric as al_decimal then
						Result.extend (create {JSON_DECIMAL}.make_decimal (al_decimal))
					end
				elseif attached {BOOLEAN} ic as al_boolean then
					Result.extend (create {JSON_BOOLEAN}.make (al_boolean))
				elseif attached {DATE} ic as al_date then
					Result.extend (create {JSON_STRING}.make_from_string_32 (al_date.out))
				elseif attached {TIME} ic as al_time then
					Result.extend (create {JSON_STRING}.make_from_string_32 (al_time.out))
				elseif attached {DATE_TIME} ic as al_date_time then
					Result.extend (create {JSON_STRING}.make_from_string_32 (al_date_time.out))
				elseif attached {ARRAY [HASHABLE]} ic as al_array then
					Result.extend (to_json_array (al_array))
				elseif attached {TUPLE [HASHABLE]} ic as al_tuple then
					check tuple_to_array: attached {ARRAY [detachable separate ANY]} al_tuple.arrayed as al_array then
						create l_array.make_filled (0, 1, al_array.count)
						i := 1
						⟳ ic_item:al_array ¦
							separate ic_item as sep_item do
								if attached {HASHABLE} sep_item as al_item then
									l_array.force (al_item, i)
									i := i + 1
								end
							end
						⟲
						Result.extend (to_json_array (l_array))
					end
				elseif attached {TUPLE} ic as al_tuple then
					check tuple_to_array: attached {ARRAY [detachable separate ANY]} al_tuple.arrayed as al_array then
						create l_array.make_filled (0, 1, al_array.count)
						i := 1
						⟳ ic_item:al_array ¦
							separate ic_item as sep_item do
								if attached {HASHABLE} sep_item as al_item then
									l_array.force (al_item, i)
									i := i + 1
								end
							end
						⟲
						Result.extend (to_json_array (l_array))
					end
				else
					Result.extend (create {JSON_NULL})
				end
			⟲
		end

feature -- Output

	json_out: STRING_32
			-- Output Current as JSON
		do
			Result := to_json_array (Current).representation
		end

	out: STRING
			--
		do
			Result := json_out.out
		end

end
