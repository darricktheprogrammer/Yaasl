property parent : script "ASUnit"
property suite : makeTestSuite("String")

set suite's loggers to {ConsoleLogger}
autorun(suite)


script BaseStringTest
	property parent : TestSet(me)
	property strlib : missing value

	property commastring : "A,test,string."
	property hyphenstring : "A-test-string."
	property commalist : {"A", "test", "string."}

	on setUp()
		tell application "System Events"
			set top_level to POSIX path of (container of container of (path to me)) & "/"
		end tell
		set strlib to load script (top_level & "string.scpt")
	end setUp
end script




script TextDelimiters
	property parent : BaseStringTest

	script split_SplitStringOnDelimiter_ReturnsList
		property parent : UnitTest(me)
		set ls to my strlib's split(my commastring, ",")
		assertEqual(my commalist, ls)
	end script

	script split_SplitSingleCharString_ReturnsTwoEmptyStrings
		property parent : UnitTest(me)
		set ls to my strlib's split(",", ",")
		assertEqual({"", ""}, ls)
	end script

	script split_SplitStringWithoutDelimiter_ReturnsSingleItemList
		property parent : UnitTest(me)
		set ls to my strlib's split("string", ",")
		assertEqual({"string"}, ls)
	end script

	script split_EmptyString_ReturnsSingleListWithEmptyString
		property parent : UnitTest(me)
		set ls to my strlib's split("", ",")
		assertEqual({""}, ls)
	end script


	script join_JoinStringOnDelimiter_ReturnsString
		property parent : UnitTest(me)
		set str to my strlib's join(my commalist, ",")
		assertEqual(my commastring, str)
	end script

	script join_JoinSingleItemList_ReturnsFirstItemOfList
		property parent : UnitTest(me)
		set str to my strlib's join({"string"}, ",")
		assertEqual("string", str)
	end script

	script join_JoinEmptyList_ReturnsEmptyString
		property parent : UnitTest(me)
		set str to my strlib's join({}, ",")
		assertEqual("", str)
	end script


	script SearchAndReplace_GivenDelimiters_ReplacesText
		property parent : UnitTest(me)
		set str to my strlib's search_and_replace(my commastring, ",", "-")
		assertEqual(my hyphenstring, str)
	end script

	script SearchAndReplace_GivenEmptyString_ReturnsEmptyString
		property parent : UnitTest(me)
		set str to my strlib's search_and_replace("", ",", "-")
		assertEqual("", str)
	end script

	script SearchAndReplace_NoDelimitersInString_ReturnsSameString
		property parent : UnitTest(me)
		set str to my strlib's search_and_replace(my commastring, ":", "-")
		assertEqual(my commastring, str)
	end script
end script




script TextCase
	property parent : BaseStringTest

	script toLower_GivenUppercaseString_ReturnsLowercaseString
		property parent : UnitTest(me)
		set str to my strlib's to_lower("STRING")
		assertEqual("string", str)
	end script

	script toLower_GivenLowercaseString_ReturnsSameString
		property parent : UnitTest(me)
		set str to my strlib's to_lower("string")
		assertEqual("string", str)
	end script

	script toLower_GivenEmptyString_ReturnsEmptyString
		property parent : UnitTest(me)
		set str to my strlib's to_lower("")
		assertEqual("", str)
	end script


	script toUpper_GivenLowercaseString_ReturnsUpperString
		property parent : UnitTest(me)
		set str to my strlib's to_upper("string")
		assertEqual("STRING", str)
	end script

	script toUpper_GivenUppercaseString_ReturnsSameString
		property parent : UnitTest(me)
		set str to my strlib's to_upper("STRING")
		assertEqual("STRING", str)
	end script

	script toUpper_GivenEmptyString_ReturnsEmptyString
		property parent : UnitTest(me)
		set str to my strlib's to_upper("")
		assertEqual("", str)
	end script


	script titleCase_GivenString_ConvertsToTitleCase
		property parent : UnitTest(me)
		set str to my strlib's title_case("sample text")
		assertEqual("Sample Text", str)
	end script

	script titleCase_GivenStringWithStopWord_DoesNotConvertStopWord
		property parent : UnitTest(me)
		set str to my strlib's title_case("alice in wonderland")
		assertEqual("Alice in Wonderland", str)
	end script

	script titleCase_StringWithNoSpaces_OnlyCapitalizesFirstLetter
		property parent : UnitTest(me)
		set str to my strlib's title_case("alice-in-wonderland")
		assertEqual("Alice-in-wonderland", str)
	end script

	script titleCase_WordFollowingTab_IsNotConverted
		property parent : UnitTest(me)
		set str to my strlib's title_case("tabbed	text")
		assertEqual("Tabbed	text", str)
	end script


	script sentenceCase_WithPeriods_ConvertsText
		property parent : UnitTest(me)
		set str to my strlib's sentence_case("a simple test. just two sentences.")
		assertEqual("A simple test. Just two sentences.", str)
	end script

	script sentenceCase_WithExclamationMarks_ConvertsText
		property parent : UnitTest(me)
		set str to my strlib's sentence_case("a simple test! just two sentences!")
		assertEqual("A simple test! Just two sentences!", str)
	end script

	script sentenceCase_WithQuestionMarks_ConvertsText
		property parent : UnitTest(me)
		set str to my strlib's sentence_case("a simple test? just two sentences?")
		assertEqual("A simple test? Just two sentences?", str)
	end script

	script sentenceCase_StringStartingWithPunctuation_ConvertsText
		property parent : UnitTest(me)
		set str to my strlib's sentence_case("... test. sample.")
		assertEqual("... Test. Sample.", str)
	end script

	script sentenceCase_EmptyString_ReturnsEmptyString
		property parent : UnitTest(me)
		set str to my strlib's sentence_case("")
		assertEqual("", str)
	end script

	script sentenceCase_NoPunctuation_CapitalizesFirstLetter
		property parent : UnitTest(me)
		set str to my strlib's sentence_case("alice in wonderland")
		assertEqual("Alice in wonderland", str)
	end script


	script ConvertCase_ToUppercase_ReturnsUppercase
		property parent : UnitTest(me)
		set str to my strlib's convert_case("string", "uppercase")
		assertEqual("STRING", str)
	end script

	script ConvertCase_ToLowercase_ReturnsLowercase
		property parent : UnitTest(me)
		set str to my strlib's convert_case("STRING", "lowercase")
		assertEqual("string", str)
	end script

	script ConvertCase_ToTitleCase_ReturnsTitleCase
		property parent : UnitTest(me)
		set str to my strlib's convert_case("alice in wonderland", "titlecase")
		assertEqual("Alice in Wonderland", str)
	end script

	script ConvertCase_ToSentenceCase_ReturnsSentenceCase
		property parent : UnitTest(me)
		set str to my strlib's convert_case("test sentence. second sentence", "sentencecase")
		assertEqual("Test sentence. Second sentence", str)
	end script
end script


script TextTrimming
	property parent : BaseStringTest

	script trim_StringWithSpaces_TrimsString
		property parent : UnitTest(me)
		set str to my strlib's trim("   string   ")
		assertEqual("string", str)
	end script

	script trim_StringWithTabs_TrimsString
		property parent : UnitTest(me)
		set str to my strlib's trim("			string			")
		assertEqual("string", str)
	end script

	script trim_StringWithLinefeeds_TrimsString
		property parent : UnitTest(me)
		set str to my strlib's trim("


string


")
		assertEqual("string", str)
	end script

	script trim_StringWithoutWhitespace_ReturnsSameString
		property parent : UnitTest(me)
		set str to my strlib's trim("string")
		assertEqual("string", str)
	end script

	script trim_EmptyString_ReturnsEmptyString
		property parent : UnitTest(me)
		set str to my strlib's trim("")
		assertEqual("", str)
	end script
end script


script StringPadding
	property parent : BaseStringTest

	script PadLeft_StringShorterThanPadding_PadsString
		property parent : UnitTest(me)
		set str to my strlib's pad_left("string", 10)
		assertEqual(10, count str)
	end script

	script PadLeft_StringLongerThanPadding_ReturnsOriginalString
		property parent : UnitTest(me)
		set str to my strlib's pad_left("string", 3)
		assertEqual(6, count str)
	end script

	script PadLeft_PaddingString_AddsSpacesToBeginning
		property parent : UnitTest(me)
		set str to my strlib's pad_left("string", 10)
		assertEqual(" ", item 1 of str)
	end script

	script PadLeft_PaddingString_FormatsStringCorrectly
		property parent : UnitTest(me)
		set str to my strlib's pad_left("string", 10)
		assertEqual("    string", str)
	end script


	script PadRight_StringShorterThanPadding_PadsString
		property parent : UnitTest(me)
		set str to my strlib's pad_right("string", 10)
		assertEqual(10, count str)
	end script

	script PadRight_StringLongerThanPadding_ReturnsOriginalString
		property parent : UnitTest(me)
		set str to my strlib's pad_right("string", 3)
		assertEqual(6, count str)
	end script

	script PadRight_PaddingString_AddsSpacesToEnd
		property parent : UnitTest(me)
		set str to my strlib's pad_right("string", 10)
		assertEqual(" ", item -1 of str)
	end script

	script PadRight_PaddingString_FormatsStringCorrectly
		property parent : UnitTest(me)
		set str to my strlib's pad_right("string", 10)
		assertEqual("string    ", str)
	end script


	script PadLeftWithChar_PaddingString_FormatsStringCorrectly
		property parent : UnitTest(me)
		set str to my strlib's pad_left_with_char("0", "string", 10)
		assertEqual("0000string", str)
	end script

	script PadLeftWithChar_GivenMultiCharPadding_ThrowsError
		property parent : UnitTest(me)
		try
			set str to my strlib's pad_left_with_char("00", "string", 10)
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(701, errnum)
	end script


	script PadRightWithChar_PaddingString_FormatsStringCorrectly
		property parent : UnitTest(me)
		set str to my strlib's pad_right_with_char("0", "string", 10)
		assertEqual("string0000", str)
	end script

	script PadRightWithChar_GivenMultiCharPadding_ThrowsError
		property parent : UnitTest(me)
		try
			set str to my strlib's pad_right_with_char("00", "string", 10)
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(701, errnum)
	end script
end script


(*
 *          --> This is a test string.
 *        --> This is a test string.
 *   --> This is a test string.
 * format("These are {}: {*}.", {"curly braces"}) --> These are curly braces: {}.
 *)
script StringFormatting
	property parent : BaseStringTest

	script format_SingleReplacementWithStringArg_FormatsString
		property parent : UnitTest(me)
		set str to my strlib's format("This is a {} string.", "test")
		assertEqual("This is a test string.", str)
	end script

	script format_SingleReplacementWithListArg_FormatsString
		property parent : UnitTest(me)
		set str to my strlib's format("This is a {} string.", {"test"})
		assertEqual("This is a test string.", str)
	end script

	script format_MultipleReplacement_FormatsString
		property parent : UnitTest(me)
		set str to my strlib's format("This is a {} {}.", {"test", "string"})
		assertEqual("This is a test string.", str)
	end script

	script format_ReplacementWithEscapedCurlyBraces_FormatsStringWithCurlyBraces
		property parent : UnitTest(me)
		set str to my strlib's format("These are {}: {*}.", {"curly braces"})
		assertEqual("These are curly braces: {}.", str)
	end script

	script format_TooManyArgs_ThrowsError
		property parent : UnitTest(me)
		try
			set str to my strlib's format("This is a {}.", {"test", "string"})
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(702, errnum)
	end script

	script format_NotEnoughArgs_ThrowsError
		property parent : UnitTest(me)
		try
			set str to my strlib's format("This is a {} {}.", {"test"})
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(702, errnum)
	end script
end script
