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


(**
 * Convert a string to all lowercase, maintaining special characters.
 *
 * @param String The string in which to convert the case.
 * @return String
 *)
on to_lower(str)
	repeat with i from 1 to (count ASCII_UPPERCASE)
		set str to my search_and_replace(str, item i of ASCII_UPPERCASE, item i of ASCII_LOWERCASE)
	end repeat
	return str
end to_lower


(**
 * Convert a string to all uppercase, maintaining special characters.
 *
 * @param String The string in which to convert the case.
 * @return String
 *)
on to_upper(str)
	repeat with i from 1 to (count ASCII_LOWERCASE)
		set str to my search_and_replace(str, item i of ASCII_LOWERCASE, item i of ASCII_UPPERCASE)
	end repeat
	return str
end to_upper


(**
 * Convert text to title case.
 *
 * Does not take punctuation into account. Only words preceded by a space
 * will be capitalized.
 *
 * The following words will always be converted to lowercase and not capitalized:
 * a, an, in, the, and, but, for, or, nor, to.
 *
 * @param String The text to convert.
 *)
on title_case(str)
	set stopwords to {"a", "an", "in", "the", "and", "but", "for", "or", "nor", "to"}
	set allWords to my split(str, space)
	
	set fixedWords to {}
	repeat with i from 1 to (count allWords)
		set currWord to item i of allWords
		set thisWord to ""
		repeat with j from 1 to (count currWord)
			if j = 1 and currWord is not in stopwords then
				set thisWord to thisWord & my to_upper(item j of currWord)
			else
				set thisWord to thisWord & my to_lower(item j of currWord)
			end if
		end repeat
		set end of fixedWords to thisWord
	end repeat
	return my join(fixedWords, space)
end title_case


(**
 * Convert text to contain capital letters at beginning of each sentence.
 *
 * The end of a sentences is considered to be one of ".!?"
 * followed by one or two spaces.
 *
 * @param String The string to convert.
 * @return String
 *)
on sentence_case(str)
	if str is ""
		return str
	end if

	set punctbreaks to {". ", ".  ", "! ", "!  ", "? ", "?  "}

	repeat with i from 1 to (count punctbreaks)
		set sentences to my split(str, item i of punctbreaks)
		repeat with j from 1 to (count sentences)
			set sentence to item j of sentences
			set item j of sentences to (to_upper(text 1 of sentence) & rest of text items of sentence) as string
		end repeat
		set str to my join(sentences, item i of punctbreaks)
	end repeat
	return str
end sentence_case


(**
 * Alternative method of converting case without directly calling the other routines.
 *
 * @param String The text to convert.
 * @param String The desired case ("uppercase", "lowercase", "titlecase", or "sentencecase")
 *)
on convert_case(str, tCase)
	if tCase is "uppercase" then
		return my to_upper(str)
	else if tCase is "lowercase" then
		return my to_lower(str)
	else if tCase is "titlecase" then
		return my title_case(str)
	else if tCase is "sentencecase" then
		return my sentence_case(str)
	else
		return str
	end if
end convert_case
