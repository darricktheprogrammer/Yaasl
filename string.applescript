(**
 * Library for working with and manipulating text
 *
 * Darrick Herwehe http://www.exitcodeone.com
 *)

property version : "1.0"


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
property WHITESPACE : "
"


(**
 * Split a string into a list on the delimiter.
 *
 * @param String The string to split.
 * @param String The delimiter on which to split the string.
 * @return List
 *)
on split(str, delimiter)
	if str is "" then
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
	if str is "" then
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


(**
 * Remove whitespace from beginning and end of string.
 *
 * @param String The string to trim.
 * @return String
 *)
on trim(str)
	if str is "" then
		return str
	end if

	repeat with i from 1 to (count str)
		if item i of str is not in WHITESPACE then
			set strstart to i
			exit repeat
		end if
	end repeat

	repeat with i from (count str) to 1 by -1
		if item i of str is not in WHITESPACE then
			set strend to i
			exit repeat
		end if
	end repeat

	return text strstart thru strend of str
end trim


(**
 * Pad a string with spaces on the left until it reaches the desired width.
 *
 * @param String The string to pad.
 * @param Integer The desired width of the string.
 * @return String
 *)
on pad_left(str, padwidth)
	return pad_left_with_char(" ", str, padwidth)
end pad_left


(**
 * Pad a string with spaces on the right until it reaches the desired width.
 *
 * @param String The string to pad.
 * @param Integer The desired width of the string.
 * @return String
 *)
on pad_right(str, padwidth)
	return pad_right_with_char(" ", str, padwidth)
end pad_right


(**
 * Pad a string with the given on the left until it reaches the desired width.
 *
 * @param Char A single character to be used for padding.
 * @param String The string to pad.
 * @param Integer The desired width of the string.
 * @return String
 *)
on pad_left_with_char(char, str, padwidth)
	if (count char) > 1 then
		error "Cannot pad with character " & quoted form of char & ". Can only pad with a single character." number 701
	end if

	set padcount to padwidth - (count str)
	repeat with i from 1 to padcount
		set str to char & str
	end repeat
	return str
end pad_left_with_char


(**
 * Pad a string with the given on the right until it reaches the desired width.
 *
 * @param Char A single character to be used for padding.
 * @param String The string to pad.
 * @param Integer The desired width of the string.
 * @return String
 *)
on pad_right_with_char(char, str, padwidth)
	if (count char) > 1 then
		error "Cannot pad with character " & quoted form of char & ". Can only pad with a single character." number 701
	end if

	set padcount to padwidth - (count str)
	repeat with i from 1 to padcount
		set str to str & char
	end repeat
	return str
end pad_right_with_char


(**
 * Simplistic, python-style string formatter.
 *
 * This routine is based on python's `string.format()` method, but is a lot simpler.
 * It will replace each instance of curly braces (`{}`) in the first string argument
 * with the corresponding string from the list given as the second argument. This
 * routine does not support python's more advanced string replacement features, such
 * as the mini-language, or positional/keyworded substitutions.
 *
 * As a convenience, if there is only one replacement to be made, the second argument
 * can simply be a string. It does not have to be a list.
 *
 * To escape a set of braces, simply put an asterisk in between them. This will
 * tell `format()` to ignore them, and they will be printed out as a standard set of braces.
 *
 * ```
 * format("This is a {} string.", "test")         --> This is a test string.
 * format("This is a {} string.", {"test"})       --> This is a test string.
 * format("This is a {} {}", {"test", "string"})  --> This is a test string.
 * format("This is a {} string.", {"test"})       --> This is a test string.
 * format("These are {}: {*}.", {"curly braces"}) --> These are curly braces: {}.
 * ```
 *
 * @param String The original string formatting template.
 * @param [String, List] One or more strings used to replace `{}` in the string template.
 * @return String
 *)
on format(str, args)
	if class of args is not list then
		set args to {args}
	end if

	set parts to split(str, "{}")

	-- Make sure the amount of args matches the amount of braces
	set {braceCount, argcount} to {(count parts) - 1, count args}
	if braceCount ­ argcount then
		set errmsg to format("Expected {} arguments, but received {}.", {braceCount, argcount})
		error errmsg number 702
	end if

	set formatted to {}
	set partLen to (count parts)
	repeat with i from 1 to partLen
		set end of formatted to item i of parts
		if i < partLen then
			set end of formatted to (item i of args as string)
		end if
	end repeat

	return search_and_replace(formatted as string, "{*}", "{}")
end format
