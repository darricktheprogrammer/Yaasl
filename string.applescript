(**
 * Library for working with and manipulating text
 *
 * Darrick Herwehe http://www.exitcodeone.com
 *)

property version : 1.0




(**
 * Split a string into a list on the delimiter.
 *
 * @param String The string to split.
 * @param String The delimiter on which to split the string.
 * @return List
 *)
on split(str, delimiter)
	if str is ""
		return {str}
	end if
	set AppleScript's text item delimiters to delimiter
	set theList to text items of str
	set AppleScript's text item delimiters to ""
	return theList
end split


(**
 * Convert a list to string, inserting a delimiter between each list item.
 *
 * @param List The list to convert.
 * @param String The text to insert between list items.
 * @return String
 *)
on join(theList, delimiter)
	set AppleScript's text item delimiters to delimiter
	set theText to theList as text
	set AppleScript's text item delimiters to ""
	return theText
end join
