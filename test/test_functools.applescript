property parent : script "ASUnit"
property suite : makeTestSuite("FuncTools")

set suite's loggers to {ConsoleLogger}
autorun(suite)


script BaseFuncToolsTest
	property parent : TestSet(me)
	property funclib : missing value


	on setUp()
		set funclib to load script (POSIX file ((POSIX path of (path to me as string) & "/../../") & "functools.scpt"))
	end setUp
end script


script MapTest
	property parent : BaseFuncToolsTest

	script map_GivenBasicHelperFunction_MapsValues
		property parent : UnitTest(me)
		set val to my funclib's map(my funclib's tolist, {1, 2, 3})
		assertEqual(val, {{1}, {2}, {3}})
	end script

	script map_GivenEmptyList_ReturnsEmptyList
		property parent : UnitTest(me)
		set val to my funclib's map(my funclib's tolist, {})
		assertEqual(val, {})
	end script

	script map_SingleItemList_MapsValue
		property parent : UnitTest(me)
		set val to my funclib's map(my funclib's tolist, {1})
		assertEqual(val, {{1}})
	end script

	script mapWithArgs_GivenFunction_MapsResults
		property parent : UnitTest(me)
		set val to my funclib's mapWithArg(my funclib's isclass, {1, 2, 3}, string)
		assertEqual(val, {false, false, false})
	end script

	script mapWithArgs_GivenEmptyList_ReturnsEmptyList
		property parent : UnitTest(me)
		set val to my funclib's mapWithArg(my funclib's isclass, {}, string)
		assertEqual(val, {})
	end script
end script


script FilterTest
	property parent : BaseFuncToolsTest

	on is_even(n)
		return (n mod 2 = 0)
	end is_even

	script filter_GivenHelperFunction_FiltersValues
		property parent : UnitTest(me)
		set val to my funclib's filter(is_even, {1, 2, 3, 4})
		assertEqual(val, {2, 4})
	end script

	script filter_GivenEmptyList_ReturnsEmptyList
		property parent : UnitTest(me)
		set val to my funclib's filter(is_even, {})
		assertEqual(val, {})
	end script

	script filterWithArgs_GivenHelperFunction_FiltersValues
		property parent : UnitTest(me)
		set vals to {"string", {a:"record"}, 1, "anotherstring"}
		set val to my funclib's filterWithArg(my funclib's isclass, vals, string)
		assertEqual(val, {"string", "anotherstring"})
	end script

	script filterWithArg_GivenEmptyList_ReturnsEmptyList
		property parent : UnitTest(me)
		set val to my funclib's filterWithArg(my funclib's isclass, {}, string)
		assertEqual(val, {})
	end script
end script








