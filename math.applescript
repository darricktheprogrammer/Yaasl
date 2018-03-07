(*!
 * Library for basic math functions
 *
 * Darrick Herwehe http://www.exitcodeone.com
 *)
property version : "1.0"


(*!
 * Type checking. Determine if a value is of the desired type. If not throw an error.
 *
 * This is for internal library use, so that the error checking is not all
 * over the place.
 *
 * @throws TypeError (704)
 * @param Any The value to check
 * @return Void
 *)
on _assert_is_number(n)
	if class of n is not in {real, integer} then
		set errmsg to "TypeError: expected number but received "
		set errmsg to errmsg & class of n & "."
		set errnum to 704
		error errmsg number errnum
	end if
end _assert_is_number

on _assert_is_list(ls)
	if class of ls is not list then
		set errmsg to "TypeError: expected list but received "
		set errmsg to errmsg & class of ls & "."
		set errnum to 704
		error errmsg number errnum
	end if
end _assert_is_list


(*!
 * Sum a list of numbers.
 *
 * Returns 0 if the list is empty.
 *
 * @example sum({1, 2, 3})
 *          --> 6
 *
 * @throws TypeError (704)
 * @param List The list of numbers
 * @return Number
 *)
on sum(ls)
	_assert_is_list(ls)
	set total to 0
	repeat with i from 1 to (count ls)
		try
			set total to total + (item i of ls)
		on error number -1700
			set errmsg to "TypeError: list contains item that is not a number."
			set errnum to 704
			error errmsg number errnum
		end try
	end repeat
	return total
end sum


(*!
 * Compute the average given a list of numbers
 *
 * @example avg({1, 2, 3, 4, 5})
 *          --> 3.0
 *
 * @throws TypeError (704)
 * @param List A list of numbers (can be reals or integers)
 * @return Real
 *)
on avg(ls)
	_assert_is_list(ls)
	if (count ls) = 0 then
		return 0
	end if
	return sum(ls) / (count ls)
end avg


(*!
 * Calculate the absolute value of a number
 *
 * @throws TypeError (704)
 * @param Number
 * @return Number
 *)
on abs(n)
	_assert_is_number(n)
	if n < 0 then
		return -n
	end if
	return n
end abs


(*!
 * Calculate the largest item in a list
 *
 * Can be used for any type that can be compared, not just numbers. For example,
 * text can be compared where `b > a`. However, lists cannot be compared, and
 * numbers cannot be compared to text. `max()` does not try to error check
 * item types and leaves it up to you to follow Applescript's comparison rules.
 *
 * @param List
 * @return Any
 *)
on max(ls)
	_assert_is_list(ls)
	set largest to item 1 of ls
	repeat with i from 2 to (count ls)
		if item i of ls > largest then
			set largest to item i of ls
		end if
	end repeat
	return largest
end max


(*!
 * Calculate the smallest item in a list
 *
 * Can be used for any type that can be compared, not just numbers. For example,
 * text can be compared where `b < a`. However, lists cannot be compared, and
 * numbers cannot be compared to text. `min()` does not try to error check
 * item types and leaves it up to you to follow Applescript's comparison rules.
 *
 * @param List
 * @return Any
 *)
on min(ls)
	_assert_is_list(ls)
	set min to item 1 of ls
	repeat with i from 2 to (count ls)
		if item i of ls < min then
			set min to item i of ls
		end if
	end repeat
	return min
end min


(*!
 * Determine the next integer up from the given number
 *
 * @param Number
 * @return Integer
 *)
on ceil(n)
	_assert_is_number(n)
	return (round n rounding up)
end ceil


(*!
 * Determine the next integer down from the given number
 *
 * @param Number
 * @return Integer
 *)
on floor(n)
	_assert_is_number(n)
	return (round n rounding down)
end floor


(*!
 * Calculate the square root of a number
 *
 * @param Number
 * @return Real
 *)
on sqrt(n)
	_assert_is_number(n)
	set n to abs(n)
	return (n ^ (1 / 2))
end sqrt


(*!
 * Determine if a number is even
 *
 * @param Number
 * @return Boolean
 *)
on is_even(n)
	_assert_is_number(n)
	return (n mod 2 = 0)
end is_even


(*!
 * Determine if a number is odd
 *
 * @param Number
 * @return Boolean
 *)
on is_odd(n)
	_assert_is_number(n)
	return (n mod 2 ≠ 0)
end is_odd
