note
	description: "JSON_DECIMAL"
	purpose: "[
		Fills in a missing creation type of {DECIMAL}, which allows
		better precision than {REAL}, which suffers from a lack of
		precision.
		
		Note that {DECIMAL} needs to be finished by adding the
		capacity for a manifest type, such as:
		

		]"

class
	JSON_DECIMAL

inherit
	JSON_NUMBER

create
	make_integer,
	make_natural,
	make_real,
	make_decimal

feature {NONE} -- Initialization

	make_decimal (an_argument: DECIMAL)
			--
		do
			item := an_argument.out
			numeric_type := double_type
		end

end
