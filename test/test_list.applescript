property parent : script "ASUnit"
property suite : makeTestSuite("List")

set suite's loggers to {ConsoleLogger}
autorun(suite)


script BaseListTest
	property parent : TestSet(me)
	property listlib : missing value

	property emptylist : missing value
	property shortlist : missing value
	property recordlist : missing value
	property longlist : missing value
	property NO_ERROR : "0: no error"

	on setUp()
		set emptylist to {}
		set shortlist to {"a", "b", "c"}
		set recordlist to {{a:1, b:2}, {c:3, d:4}}
		set longlist to {"a", "b", "c", "d", "e", "f", "g"}

		set listlib to load script (POSIX file ((POSIX path of (path to me as string) & "/../../") & "list.scpt"))
	end setUp
end script


script ListToListManipulations
	property parent : BaseListTest

	script unique_ListWithDuplicates_ReturnsUniqueList
		property parent : UnitTest(me)
		set ls to my listlib's unique({1, 1, 2, 2, 3, 3})
		assertEqual({1, 2, 3}, ls)
	end script

	script unique_ListWithoutDuplicates_ReturnsSameList
		property parent : UnitTest(me)
		set ls to my listlib's unique(my shortlist)
		assertEqual(my shortlist, ls)
	end script

	script unique_EmptyList_ReturnsEmptyList
		property parent : UnitTest(me)
		set ls to my listlib's unique(my emptylist)
		assertEqual(my emptylist, ls)
	end script

	script unique_RecordList_ThrowsError
		property parent : UnitTest(me)
		set badlist to my recordlist & my recordlist
		try
			set ls to my listlib's unique(badlist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try

		assertEqual(704, errnum)
	end script

	script unique_ListofLists_ThrowsError
		property parent : UnitTest(me)
		set badlist to my shortlist
		set end of badlist to my shortlist
		try
			set ls to my listlib's unique(badlist)
			set errnum to "0: no error"
		on error number errnum
			set errnum to errnum
		end try

		assertEqual(704, errnum)
	end script


	script insert_IntoFrontOfList_AddsItemToFrontOfList
		property parent : UnitTest(me)
		set ls to my listlib's insert("0", 1, my shortlist)
		assertEqual({"0"} & my shortlist, ls)
	end script

	script insert_IntoBackOfList_AddsItemToBackOfList
		property parent : UnitTest(me)
		set ls to my listlib's insert("d", 4, my shortlist)
		assertEqual(my shortlist & {"d"}, ls)
	end script

	script insert_IntoMiddleOfList_AddsItemToMiddleOfList
		property parent : UnitTest(me)
		set ls to my listlib's insert("z", 2, my shortlist)
		assertEqual({"a", "z", "b", "c"}, ls)
	end script

	script insert_GivenZeroIndex_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's insert("0", 0, my shortlist)
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(705, errnum)
	end script

	script insert_GivenOutOfBoundsIndex_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's insert("d", 5, my shortlist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(705, errnum)
	end script

	script insert_GivenNegativeIndex_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's insert("d", -1, my shortlist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(705, errnum)
	end script

	script insert_IntoEmptyList_CreatesOneItemLIst
		property parent : UnitTest(me)
		set ls to my listlib's insert("a", 1, my emptylist)
		assertEqual({"a"}, ls)
	end script


	script popIndex_PopFirstItem_PopsFirstItem
		property parent : UnitTest(me)
		set ls to my listlib's pop_index(1, my shortlist)
		assertEqual({"a", {"b", "c"}}, ls)
	end script

	script popIndex_PopLastItem_PopsLastItem
		property parent : UnitTest(me)
		set ls to my listlib's pop_index(3, my shortlist)
		assertEqual({"c", {"a", "b"}}, ls)
	end script

	script popIndex_PopMiddleItem_PopsMiddleItem
		property parent : UnitTest(me)
		set ls to my listlib's pop_index(2, my shortlist)
		assertEqual({"b", {"a", "c"}}, ls)
	end script

	script popIndex_EmptyList_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's pop_index(1, my emptylist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(errnum, 705)
	end script

	script popIndex_GivenOutOfBoundsIndex_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's pop_index(5, my shortlist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(errnum, 705)
	end script

	script popIndex_GivenZeroIndex_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's pop_index(0, my shortlist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(errnum, 705)
	end script

	script popIndex_GivenNegativeIndex_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's pop_index(-1, my shortlist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(errnum, 705)
	end script

	script popIndex_GivenNotAList_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's pop_index(1, "A string")
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(errnum, 704)
	end script


	script pop_GivenList_PopsLastItem
		property parent : UnitTest(me)
		set ls to my listlib's pop(my shortlist)
		assertEqual({"c", {"a", "b"}}, ls)
	end script

	script pop_GivenNotAList_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's pop("A string")
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(errnum, 704)
	end script

	script pop_EmptyList_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's pop(my emptylist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(errnum, 705)
	end script
end script
