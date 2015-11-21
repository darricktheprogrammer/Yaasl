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
			set errnum to "0: no error"
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
end script
