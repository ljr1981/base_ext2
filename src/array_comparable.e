note
	description: "Arrays that have comparable items that can be sorted."
	design: "[
		The items are sorted by {HASHABLE}.hash_code. Array items are
		converted to {TUPLE} because it is hashable and array is not.
		Once all items are hashable, then they can be sorted by their
		hash codes in ascending or descending order. This is not a perfect
		or even good or best solution. However, it works for the most part.
		]"

class
	ARRAY_COMPARABLE [G -> HASHABLE]

inherit
	ARRAY_EXT [G]

create
	make,
	make_empty,
	make_filled,
	make_from_array,
	make_from_array_any,
	make_from_cil,
	make_from_special

feature -- Transformation

	sort_asc
			-- Sort Current ascending.
		local
			i: INTEGER
		do
			⟳ ic:sorted_asc ¦
				put (ic, i + 1)
				i := i + 1
			⟲
		end

	sort_desc
			-- Sort Current descending.
		local
			i: INTEGER
		do
			⟳ ic:sorted_asc.new_cursor.reversed ¦
				put (ic, i + 1)
				i := i + 1
			⟲
		end

	sorted_asc: ARRAY [HASHABLE]
			-- An ascending version of Current.
		local
			l_sorted: SORTED_TWO_WAY_LIST [INTEGER]
			l_hash: HASH_TABLE [HASHABLE, INTEGER]
			l_result: ARRAYED_LIST [HASHABLE]
		do
			create l_hash.make (count)
			⟳ ic:Current ¦ l_hash.force (ic, ic.hash_code) ⟲
			create l_sorted.make
			⟳ ic:Current ¦ l_sorted.force (ic.hash_code) ⟲
			create l_result.make (count)
			l_sorted.sort
			check is_sorted: l_sorted.sorted end
			⟳ ic:l_sorted ¦
				if attached l_hash [ic] as al_item then
					l_result.force (al_item)
				end
			⟲
			check has_all_by_hash: ∀ ic:l_result ¦ l_hash.has (ic.hash_code) end
			Result := l_result.to_array
		end

end
