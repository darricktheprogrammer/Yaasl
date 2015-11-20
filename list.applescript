(**
 * Library for working with and manipulating lists
 *
 * Darrick Herwehe http://www.exitcodeone.com
 *)

property version : 1.0


(**
 * Remove duplicate items from a list.
 *
 * Because of Applescript comparison limitations, records and lists are not
 * supported by this routine. Any lists containing a record or list will throw
 * a TypeError.
 *
 * @example unique({"a", "b", "c", "a", "b"})
 *          --> {"a", "b", c}
 *
 * @param List The list containing duplicates to delete
 * @return List
 *)
on unique(ls)
	set uniquels to {}
	repeat with i from 1 to (count ls)
		set theItem to item i of ls
		if class of theItem is in {record, list} then
			set errmsg to "TypeError: cannot make unique list containing "
			set errmsg to errmsg & class of theItem & " items."
			error errmsg number 704
		end if
		if item i of ls is not in uniquels then
			set end of uniquels to item i of ls
		end if
	end repeat
	return uniquels
end unique
