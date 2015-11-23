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


(**
 * Remove an item from a list at the given index and return it.
 *
 * Because an item cannot be deleted in place from a list, the return value
 * will be a list containing both the popped value and the original list
 * minus the popped item (`rest of list` if index is 1).
 *
 * The first item will be the popped value.
 * The second value will be the updated list.
 *
 * If you just want to delete at an item at an index and do not care about
 * the return value, you can run `pop_index()` and simply ignore the first
 * return value.
 *
 * !!! warning: `pop_index()` does not support reverse indexing. You will
 * receive an error for `pop_index(-1, ls)`. To reverse index you will need to
 * pass the actual index number to be popped: `pop_index((count ls), ls)`
 *
 * @example -- Pop an item and get its value
 *          listlib's pop_index(2, {"a", "b", "c"})
 *          --> {"b", {"a", "c"}}
 *
 * @example -- Delete an item from a list, ignoring its return value
 *          set {_, ls} to listlib's pop_index(2, {"a", "b", "c"})
 *
 * @throws IndexError (705)
 * @param Integer The index to pop from the list
 * @param List The list from which to pop the last value
 * @return List
 *)
on pop_index(ix, ls)
	if ix > (count ls) + 1 or ix = 0 then
		if (count ls) = 1 then
			set items_ to "item"
		else
			set items_ to "items"
		end if
		set errmsg to "IndexError: Cannot get item " & ix & " of list with "
		set errmsg to errmsg & (count ls) & " " & items_ & "."
		error errmsg number 705
	else if ix < 1 then
		set errmsg to "IndexError: pop_index does not support reverse indexing."
		error errmsg number 705
	else if ls is {} then
		set errmsg to "IndexError: Cannot pop from empty list."
		error errmsg number 705
	else if class of ls is not list then
		set errmsg to "TypeError: Cannot pop item from item whose class is "
		set errmsg to errmsg & class of ls & "."
		error errmsg number 704
	end if

	if ix is 1 then
		return {item 1 of ls, rest of ls}
	else if ix is (count ls) then
		return {item -1 of ls, items 1 thru -2 of ls}
	else
		set front_ to items 1 thru (ix - 1) of ls
		set back_ to items (ix + 1) thru -1 of ls
		return {item ix of ls, front_ & back_}
	end if
end pop_index


(**
 * Remove the last item from a list and return it.
 *
 * Acts as a shortcut for `pop_index((count ls), ls)`
 *
 * Because an item cannot be deleted in place from a list, the return value
 * will be a list containing both the popped value and the original list
 * minus the last item (items 1 thru -2 of the list).
 *
 * The first item will be the popped value.
 * The second value will be the updated list.
 *
 * @example listlib's pop({"a", "b", "c"})
 *          --> {"c", {"a", "b"}}
 *
 * @throws IndexError (705)
 * @param List The list from which to pop the last value
 * @return List
 *)
on pop(ls)
	return pop_index(count ls, ls)
end pop


(**
 * Get the index of the first occurrence of an item in a list.
 *
 * Applescript provides the `offset` command for strings, but does not provide
 * a way to get the index of an item in a list. This provides that missing
 * functionality.
 *
 * Returns 0 if the item is not found.
 *
 * @param [String, Number] The item to find in the list
 * @param List The list in which to find the item
 * @return Integer
 *)
on index_of(theItem, ls)
	if class of theItem is in {record, list} then
		set errmsg to "TypeError: cannot get index of "
		set errmsg to errmsg & class of theItem & " items."
		error errmsg number 704
	else if theItem is not in ls then
		return 0
	end if

	-- Looping through the list is a valid approach, but gets slow on larger
	-- lists. By converting the list to a string, then splitting it on
	-- the item, there is no degradation in speed no matter how big
	-- the list gets.

	--theBreaker is used as a placeholder between list items so the list can
	--be broken up again later. The character combination should
	--prove unique enough to never be run into when running a script.
	set itemCount to (count ls)
	set theBreaker to ")-+^+-("
	set oldDelims to AppleScript's text item delimiters
	set AppleScript's text item delimiters to theBreaker
	set theText to ls as text
	set AppleScript's text item delimiters to (theBreaker & theItem & theBreaker)
	set splitList to text item 1 of theText
	set AppleScript's text item delimiters to theBreaker
	set splitList to text items of splitList
	set AppleScript's text item delimiters to oldDelims
	set theIndex to ((count splitList) + 1)

	if theItem is item 1 of ls then
		return 1
	else if itemCount < theIndex then
		return itemCount
	else
		return theIndex
	end if
end index_of


(**
 * Remove the first occurrence of an item from a list.
 *
 * If the item is not present in the list, the list will remain unchanged.
 *
 * @param [String, Number] The item to remove
 * @param List The list from which to remove the item.
 * @return List
 *)
on remove(theItem, ls)
	set ix to index_of(theItem, ls)
	if ix = 0 then
		return ls
	end if
	return item 2 of pop_index(ix, ls)
end remove


(**
 * Return the values of the first list that are not present in the second list.
 *
 * Because of Applescript comparison limitations, records and lists are not
 * supported by this routine. Any lists containing a record or list will throw
 * a TypeError.
 *
 * @example diff({"a", "b", "c", "d"}, {"a", "b", "e", "f"})
 *          --> {"c", "d"}
 *
 * @throws TypeError (704)
 * @param List The first list to compare.
 *        This is where the result set will come from.
 * @param List The list that is being compared to
 * @return List
 *)
on diff(l1, l2)
	repeat with i from 1 to (count l2)
		if class of item i of l2 is in {record, list} then
			set errmsg to "TypeError: cannot diff lists containing "
			set errmsg to errmsg & class of item i of l2 & " items."
			error errmsg number 704
		end if
	end repeat

	set l3 to {}
	repeat with i from 1 to (count l1)
		set theItem to item i of l1

		if class of theItem is in {record, list} then
			set errmsg to "TypeError: cannot diff lists containing "
			set errmsg to errmsg & class of theItem & " items."
			error errmsg number 704
		else if theItem is not in l2 then
			set end of l3 to theItem
		end if
	end repeat
	return l3
end diff
