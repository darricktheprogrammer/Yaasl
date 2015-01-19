(**
 * Library for working with and manipulating text
 *
 * Darrick Herwehe http://www.exitcodeone.com
 *)

property version : 1.0


(**Ascii lowercase letters a-z*)
property ASCII_LOWERCASE : "abcdefghijklmnopqrstuvwxyz"

(**Ascii uppercase letters A-Z*)
property ASCII_UPPERCASE : "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

(**Numbers 0-9*)
property DIGITS : "0123456789"

(**Combination of ASCII_LOWERCASE and ASCII_UPPERCASE*)
property ASCII_LETTERS : ASCII_LOWERCASE & ASCII_UPPERCASE

(**Punctuation and special characters*)
property SPECIAL_CHARS : "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"

(**Whitespace characters tab, space, return, and linefeed*)
property WHITESPACE : " \t\r\n"


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


(**
 * Search for text and replace it.
 *
 * @param String The original string.
 * @param String The text to replace.
 * @param String The replacement text.
 * @return String
 *)
on search_and_replace(str, oldText, newText)
	set AppleScript's text item delimiters to oldText
	set myList to text items of str
	set AppleScript's text item delimiters to newText
	set str to myList as string
	set AppleScript's text item delimiters to ""
	return str
end search_and_replace
