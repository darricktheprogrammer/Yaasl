(*!
 * @header
 * 		Library for working with and manipulating lists
 *
 * 		Darrick Herwehe http://www.exitcodeone.com
 *)
property version : "1.0"


(*!
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
 * @param ls (List): The list containing duplicates to delete
 * @return (List)
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


(*!
 * Insert an item into a given position in a list.
 *
 * The item will be placed in the position before the given index,
 * so `insert(x, 1, ls)` will be placed in the first position and
 * `insert(x, (count ls) + 1, ls)` is the same as `set end of ls to x`.
 *
 * @example insert("d", 4, {"a", "b", "c"})
 *          --> {"a", "b", "c", "d"}
 *
 * @param theItem (Any): The item to insert into the list
 * @param ix (Integer): The index where the item should be inserted into the list
 * @param ls (List): The list in which to insert the item
 * @return (List)
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

	-- Records get coerced to a list when being added, which just extracts
	-- their values. So only their values are inserted, not the record.
	if class of theItem is record then
		set theItem to {theItem}
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


(*!
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
 * @param ix (Integer): The index to pop from the list
 * @param ls (List): The list from which to pop the last value
 * @return (List)
 *)
on pop_index(ix, ls)
	if ix > (count ls) or ix = 0 then
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


(*!
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
 * @param ls (List): The list from which to pop the last value
 * @return (List)
 *)
on pop(ls)
	return pop_index(count ls, ls)
end pop


(*!
 * Get the index of the first occurrence of an item in a list.
 *
 * Applescript provides the `offset` command for strings, but does not provide
 * a way to get the index of an item in a list. This provides that missing
 * functionality.
 *
 * Returns 0 if the item is not found.
 *
 * @param theItem (String, Number): The item to find in the list
 * @param ls (List): The list in which to find the item
 * @return (Integer)
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


(*!
 * Remove the first occurrence of an item from a list.
 *
 * If the item is not present in the list, the list will remain unchanged.
 *
 * @param theItem (String, Number) The item to remove
 * @param ls (List): The list from which to remove the item.
 * @return (List)
 *)
on remove(theItem, ls)
	set ix to index_of(theItem, ls)
	if ix = 0 then
		return ls
	end if
	return item 2 of pop_index(ix, ls)
end remove


(*!
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
 * @param l1 (List): The first list to compare. This is where the result set
 *                   will come from.
 * @param l2 (List): The list that is being compared to
 * @return (List)
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


(*!
 * Return only the values of the first list also contained in the second list.
 *
 * Basically the opposite of `diff()`
 *
 * @example diff({"a", "b", "c", "d"}, {"a", "b", "e", "f"})
 *          --> {"a", "b"}
 *
 * @param l1 (List): The first list to compare. This is where the result set
 *                   will come from.
 * @param l2 (List): The list that is being compared to
 * @return (List)
 *)
on intersect(l1, l2)
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
		else if theItem is in l2 then
			set end of l3 to theItem
		end if
	end repeat
	return l3
end intersect


(*!
 * Move an item from one spot in the list to another.
 *
 * Note that `move_item` removes the item from the list _first_, then readds it
 * in the desired location. So, if you want to move an item to the end of a
 * 3 item list, you would specify `3` as the `targetIndex`, not `4`.
 *
 * @example move_item({"a", "b", "c"}, 1, 3)
 *          --> {"b", "c", "a"}
 *
 * @example move_item({"a", "b", "c"}, 1, 4)
 *          --> IndexError: Cannot insert item at index 4 when list has 2 items. (705)
 *
 * @param ls (List): The list containing the element
 * @param oldindex (Integer): The index of the item to move
 * @param newindex (Integer): The index to where the item should be moved
 * @return (List)
 *)
on move_item(ls, oldindex, newindex)
	if oldindex < 0 or newindex < 0 then
		set errmsg to "IndexError: move_item does not support reverse indexing."
		error errmsg number 705
	else if (newindex > (count ls)) then
		if (count ls) = 1 then
			set items_ to "item"
		else
			set items_ to "items"
		end if
		set errmsg to "IndexError: Cannot insert item at index " & newindex
		set errmsg to errmsg & " when list has " & (count ls) & " " & items_ & "."
		error errmsg number 705
	end if
	set {val, ls2} to pop_index(oldindex, ls)
	set ls2 to insert(val, newindex, ls2)
	return ls2
end move_item


(*!
 * Sort a list.
 *
 * This is the quicksort routine taken from Kevin Bradley's Nite Flite library.
 * http://mac.brothersoft.com/nite-flite-script-library.html
 *
 * @param theList (List): The list to sort
 * @return (List)
 *)
on sort(theList)
	--public routine, called from your script
	script bs
		property alist : theList

		on Qsort(leftIndex, rightIndex)
			--private routine called by quickSort.
			--do not call from your script!
			if rightIndex > leftIndex then
				set pivot to ((rightIndex - leftIndex) div 2) + leftIndex
				set newPivot to Qpartition(leftIndex, rightIndex, pivot)
				set theList to Qsort(leftIndex, newPivot - 1)
				set theList to Qsort(newPivot + 1, rightIndex)
			end if

		end Qsort

		on Qpartition(leftIndex, rightIndex, pivot)
			--private routine called by quickSort.
			--do not call from your script!
			set pivotValue to item pivot of bs's alist
			set temp to item pivot of bs's alist
			set item pivot of bs's alist to item rightIndex of bs's alist
			set item rightIndex of bs's alist to temp
			set tempIndex to leftIndex
			repeat with pointer from leftIndex to (rightIndex - 1)
				if item pointer of bs's alist ≤ pivotValue then
					set temp to item pointer of bs's alist
					set item pointer of bs's alist to item tempIndex of bs's alist
					set item tempIndex of bs's alist to temp
					set tempIndex to tempIndex + 1
				end if
			end repeat
			set temp to item rightIndex of bs's alist
			set item rightIndex of bs's alist to item tempIndex of bs's alist
			set item tempIndex of bs's alist to temp

			return tempIndex
		end Qpartition

	end script

	if length of bs's alist > 1 then bs's Qsort(1, length of bs's alist)
	return bs's alist
end sort


(*!
 * Count the amount of times an item appears in a list.
 *
 * @param value (Any): The item to find
 * @param ls (List): The list to search for the value.
 * @return (Integer)
 *)
on count_instances(value, ls)
	set counter to 0
	repeat with i from 1 to (count ls)
		if item i of ls is value then
			set counter to counter + 1
		end if
	end repeat
	return counter
end count_instances


(*!
 * Zip lists together, creating a list of n-item lists, where n = (count lists).
 *
 * Iterate through each of the given lists, adding their current values to an
 * n-item list. If no lists are given (`zip_many()` receives a zero-item list),
 * an empty list will be returned.
 *
 * If the lists are not the same length, the shortest will be used as the
 * iteration count, and the remaining items of the longer lists
 * will be thrown away.
 *
 * @example
 * 		zip_many({})
 * 		--> {}
 *
 * @example
 * 		set l1 to {"a", "b", "c"}
 * 		set l2 to {"d", "e", "f"}
 * 		set l3 to {1, 2, 3}
 * 		zip_many({l1, l2, l3})
 * 		--> {{"a", "d", 1}, {"b", "e", 2}, {"c", "f", 3}}
 *
 * @example
 * 		set l1 to {"a", "b", "c"}
 * 		set l2 to {"d", "e", "f"}
 * 		set l3 to {"1"}
 * 		zip_many({l1, l2, l3})
 * 		--> {{"a", "d", 1}}
 *
 * @param ls (List): A list of lists
 * @return (List)
 *)
on zip_many(ls)
	if (count ls) = 0 then
		return {}
	end if

	-- Find the shortest list to use as iteration reference
	set shortest to item 1 of ls
	repeat with l in ls
		if (count l) < (count shortest) then
			set shortest to l
		end if
	end repeat

	set zipped to {}
	set item_count to count shortest
	repeat with i from 1 to item_count
		set entry to {}
		repeat with j from 1 to (count ls)
			set end of entry to item i of item j of ls
		end repeat
		set end of zipped to entry
	end repeat
	return zipped
end zip_many


(*!
 * Zip two lists together, creating a list of 2-item lists.
 *
 * Works the same way as `zip_many()` except for only two lists.
 *
 * @param ls1 (List):
 * @param ls2 (List):
 * @return (List)
 *)
on zip(ls1, ls2)
	return zip_many({ls1, ls2})
end zip
