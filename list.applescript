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
 * @throws TypeError (704)
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


(**
 * Insert an item into a given position in a list.
 *
 * The item will be placed in the position before the given index,
 * so `insert(x, 1, ls)` will be placed in the first position and
 * `insert(x, (count ls) + 1, ls)` is the same as `set end of ls to x`.
 *
 * @example insert("d", 4, {"a", "b", "c"})
 *          --> {"a", "b", "c", "d"}
 *
 * @param Anything The item to insert into the list
 * @param Integer The index where the item should be inserted into the list
 * @param List The list in which to insert the item
 * @return List
 *)
on insert(theItem, ix, ls)
	set errmsg to missing value
	if ix = 0 then
		set errmsg to "IndexError: Cannot insert item at index 0 of list."
	else if ix < 0 then
		set errmsg to "IndexError: insert does not support reverse indexing."
	else if (ix > (count ls) + 1) then
		if (count ls) = 1 then
			set items_ to "item"
		else
			set items_ to "items"
		end if
		set errmsg to "IndexError: Cannot insert item at index " & ix
		set errmsg to errmsg & " when list has " & (count ls) & " " & items_ & "."
	end if
	if errmsg is not missing value then
		error errmsg number 705
	end if

	if ix is 1 then
		set newList to (theItem as list) & ls
	else if ix is ((count ls) + 1) then
		set newList to ls & theItem
	else
		tell ls
			set front_ to items 1 thru (ix - 1)
			set back_ to items ix thru -1
		end tell
		set newList to front_ & theItem & back_
	end if
	return newList
end insert
