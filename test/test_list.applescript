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

		tell application "System Events"
			set top_level to POSIX path of (container of container of (path to me)) & "/"
		end tell
		set listlib to load script (top_level & "list.scpt")
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

	script insert_RecordAtEnd_InsertsRecord
		property parent : UnitTest(me)
		set ls to my listlib's insert({e:5, f:6}, 4, my shortlist)
		assertEqual({"a", "b", "c", {e:5, f:6}}, ls)
	end script

	script insert_RecordAtBeginning_InsertsRecord
		property parent : UnitTest(me)
		set ls to my listlib's insert({e:5, f:6}, 1, my shortlist)
		assertEqual({{e:5, f:6}, "a", "b", "c"}, ls)
	end script

	script insert_RecordInMiddle_InsertsRecord
		property parent : UnitTest(me)
		set ls to my listlib's insert({e:5, f:6}, 2, my shortlist)
		assertEqual({"a", {e:5, f:6}, "b", "c"}, ls)
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

	script popIndex_GivenCountOfListPlusOneIndex_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's pop_index(4, my shortlist)
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


	script remove_ItemInList_RemovesItem
		property parent : UnitTest(me)
		set ls to my listlib's remove("a", my shortlist)
		assertEqual(rest of my shortlist, ls)
	end script

	script remove_ItemNotInList_ReturnsUnchangedList
		property parent : UnitTest(me)
		set ls to my listlib's remove("d", my shortlist)
		assertEqual(my shortlist, ls)
	end script

	script remove_RecordItem_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's remove(item 1 of my recordlist, my recordlist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script


	script diff_DifferentLists_ReturnsDiff
		property parent : UnitTest(me)
		set ls to my listlib's diff(my longlist, my shortlist)
		assertEqual({"d", "e", "f", "g"}, ls)
	end script

	script diff_SameList_ReturnsEmptyList
		property parent : UnitTest(me)
		set ls to my listlib's diff(my shortlist, my shortlist)
		assertEqual({}, ls)
	end script

	script diff_NoOverlap_ReturnsOriginalList
		property parent : UnitTest(me)
		set ls to my listlib's diff(my shortlist, {})
		assertEqual(my shortlist, ls)
	end script

	script diff_FirstListContainsRecord_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's diff(my recordlist, my shortlist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script

	script diff_SecondListContainsRecord_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's diff(my shortlist, my recordlist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script


	script intersect_DifferentLists_ReturnsIntersectingPortion
		property parent : UnitTest(me)
		set ls to my listlib's intersect(my longlist, my shortlist)
		assertEqual({"a", "b", "c"}, ls)
	end script

	script intersect_SameList_ReturnsSameList
		property parent : UnitTest(me)
		set ls to my listlib's intersect(my shortlist, my shortlist)
		assertEqual(my shortlist, ls)
	end script

	script intersect_NoOverlap_ReturnsEmptyList
		property parent : UnitTest(me)
		set ls to my listlib's intersect(my shortlist, {})
		assertEqual({}, ls)
	end script

	script intersect_FirstListContainsRecord_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's intersect(my recordlist, my shortlist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script

	script intersect_SecondListContainsRecord_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's intersect(my shortlist, my recordlist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script


	script MoveItem_FromFrontToBack_MovesItem
		property parent : UnitTest(me)
		set ls to my listlib's move_item(my shortlist, 1, 3)
		assertEqual({"b", "c", "a"}, ls)
	end script

	script MoveItem_ToSameSpot_ReturnsSameList
		property parent : UnitTest(me)
		set ls to my listlib's move_item(my shortlist, 2, 2)
		assertEqual(my shortlist, ls)
	end script

	script MoveItem_ToBeginning_MovesItem
		property parent : UnitTest(me)
		set ls to my listlib's move_item(my shortlist, 2, 1)
		assertEqual({"b", "a", "c"}, ls)
	end script

	script MoveItem_MoveRecord_MovesRecord
		property parent : UnitTest(me)
		set ls to my listlib's move_item(my recordlist, 1, 2)
		assertEqual({{c:3, d:4}, {a:1, b:2}}, ls)
	end script

	script MoveItem_GivenNegativeIndexAsItemIndex_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's move_item(my shortlist, -1, 3)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(705, errnum)
	end script

	script MoveItem_GivenNegativeIndexAsTargetIndex_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's move_item(my shortlist, 1, -1)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(705, errnum)
	end script

	script MoveItem_GivenZeroAsOriginalIndex_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's move_item(my shortlist, 0, 3)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(705, errnum)
	end script

	script MoveItem_GivenZeroAsTargetIndex_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's move_item(my shortlist, 1, 0)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(705, errnum)
	end script

	script MoveItem_GivenOutOfBoundsOriginalIndex_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's move_item(my shortlist, 4, 0)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(705, errnum)
	end script

	script MoveItem_GivenOutOfBoundsTargetIndex_ThrowsError
		property parent : UnitTest(me)
		try
			set ls to my listlib's move_item(my shortlist, 1, 4)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(705, errnum)
	end script

	script sort_OutOfOrderList_SortsList
		property parent : UnitTest(me)
		set ls to my listlib's sort({"c", "a", "b"})
		assertEqual({"a", "b", "c"}, ls)
	end script
end script


script ListInformation
	property parent : BaseListTest

	script indexOf_TextItem_ReturnsIndex
		property parent : UnitTest(me)
		set ix to my listlib's index_of("a", my shortlist)
		assertEqual(1, ix)
	end script

	script indexOf_NumberItem_ReturnsIndex
		property parent : UnitTest(me)
		set ix to my listlib's index_of(1, {1, 2, 3})
		assertEqual(1, ix)
	end script

	script indexOf_RecordItem_ThrowsError
		property parent : UnitTest(me)
		try
			set ix to my listlib's index_of(item 1 of my recordlist, my recordlist)
			set errnum to my NO_ERROR
		on error number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script

	script indexOf_EmptyList_ReturnsZero
		property parent : UnitTest(me)
		set ix to my listlib's index_of("a", {})
		assertEqual(0, ix)
	end script

	script indexOf_ItemNotInList_ReturnsZero
		property parent : UnitTest(me)
		set ix to my listlib's index_of("d", my shortlist)
		assertEqual(0, ix)
	end script

	script indexOf_ItemInListMultipleTimes_ReturnsFirstOccurence
		property parent : UnitTest(me)
		set ls to my shortlist & my shortlist
		set ix to my listlib's index_of("a", ls)
		assertEqual(1, ix)
	end script

	script CountInstances_FoundOnce_Returns1
		property parent : UnitTest(me)
		set instanceCount to my listlib's count_instances("a", my shortlist)
		assertEqual(1, instanceCount)
	end script

	script CountInstances_FoundTwice_Returns2
		property parent : UnitTest(me)
		set instanceCount to my listlib's count_instances("a", my shortlist & my shortlist)
		assertEqual(2, instanceCount)
	end script

	script CountInstances_NotInList_Returns0
		property parent : UnitTest(me)
		set instanceCount to my listlib's count_instances("d", my shortlist)
		assertEqual(0, instanceCount)
	end script

	script CountInstances_LookingForRecord_ReturnsCount
		property parent : UnitTest(me)
		set instanceCount to my listlib's count_instances({a:1, b:2}, my recordlist)
		assertEqual(1, instanceCount)
	end script
end script


script FunctionalRoutines
	property parent : BaseListTest

	script zipMany_ZeroItemList_ReturnsEmptyList
		property parent : UnitTest(me)
		set ls to my listlib's zip_many({})
		assertEqual({}, ls)
	end script

	script zipMany_MixedClassLists_ZipsLists
		property parent : UnitTest(me)
		set l1 to {"a", "b", "c"}
		set l2 to {"d", "e", "f"}
		set l3 to {1, 2, 3}
		set zipped to my listlib's zip_many({l1, l2, l3})
		assertEqual({{"a", "d", 1}, {"b", "e", 2}, {"c", "f", 3}}, zipped)
	end script

	script zipMany_FirstListShorter_ZipsToShorterLength
		property parent : UnitTest(me)
		set l1 to {"a"}
		set l2 to {"d", "e", "f"}
		set l3 to {1, 2, 3}
		set zipped to my listlib's zip_many({l1, l2, l3})
		assertEqual({{"a", "d", 1}}, zipped)
	end script

	script zipMany_OtherListShorter_ZipsToShorterLength
		property parent : UnitTest(me)
		set l1 to {"a", "b", "c"}
		set l2 to {"d", "e", "f"}
		set l3 to {1}
		set zipped to my listlib's zip_many({l1, l2, l3})
		assertEqual({{"a", "d", 1}}, zipped)
	end script

	script zipMany_GivenRecord_ZipsLists
		property parent : UnitTest(me)
		set l1 to {"a", "b", "c"}
		set l2 to {{a:1}, {b:2}, {c:3}}
		set l3 to {1, 2, 3}
		set zipped to my listlib's zip_many({l1, l2, l3})
		assertEqual({{"a", {a:1}, 1}, {"b", {b:2}, 2}, {"c", {c:3}, 3}}, zipped)
	end script


	script zip_ZeroItemList_ReturnsEmptyList
		property parent : UnitTest(me)
		set ls to my listlib's zip({}, {})
		assertEqual({}, ls)
	end script

	script zip_MixedClassLists_ZipsLists
		property parent : UnitTest(me)
		set l1 to {"a", "b", "c"}
		set l2 to {1, 2, 3}
		set zipped to my listlib's zip(l1, l2)
		assertEqual({{"a", 1}, {"b", 2}, {"c", 3}}, zipped)
	end script

	script zip_FirstListShorter_ZipsToShorterLength
		property parent : UnitTest(me)
		set l1 to {"a"}
		set l2 to {1, 2, 3}
		set zipped to my listlib's zip(l1, l2)
		assertEqual({{"a", 1}}, zipped)
	end script

	script zip_OtherListShorter_ZipsToShorterLength
		property parent : UnitTest(me)
		set l1 to {"a", "b", "c"}
		set l2 to {1}
		set zipped to my listlib's zip(l1, l2)
		assertEqual({{"a", 1}}, zipped)
	end script

	script zip_GivenRecord_ZipsLists
		property parent : UnitTest(me)
		set l1 to {"a", "b", "c"}
		set l2 to {{a:1}, {b:2}, {c:3}}
		set zipped to my listlib's zip(l1, l2)
		assertEqual({{"a", {a:1}}, {"b", {b:2}}, {"c", {c:3}}}, zipped)
	end script
end script
