property parent : script "ASUnit"
property suite : makeTestSuite("Math")

set suite's loggers to {ConsoleLogger}
autorun(suite)


script BaseMathTest
	property parent : TestSet(me)
	property mathlib : missing value


	on setUp()
		tell application "System Events"
			set top_level to POSIX path of (container of container of (path to me)) & "/"
		end tell
		set mathlib to load script (top_level & "math.scpt")
	end setUp
end script


script ListBasedMath
	property parent : BaseMathTest

	script sum_ListOfNumbers_ReturnsSum
		property parent : UnitTest(me)
		set val to my mathlib's sum({1, 2, 3, 4, 5})
		assertEqual(15, val)
	end script

	script sum_EmptyList_ReturnsZero
		property parent : UnitTest(me)
		set val to my mathlib's sum({})
		assertEqual(0, val)
	end script

	script sum_NonList_ThrowsError
		property parent : UnitTest(me)
		try
			set val to my mathlib's sum(1)
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script

	script sum_NonNumberInList_ThrowsError
		property parent : UnitTest(me)
		try
			set val to my mathlib's sum({"a", "b", "c"})
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script


	script avg_ListOfNumbers_ReturnsAverage
		property parent : UnitTest(me)
		set val to my mathlib's avg({1, 2, 3, 4, 5})
		assertEqual(3.0, val)
	end script

	script avg_EmptyList_ReturnsZero
		property parent : UnitTest(me)
		set val to my mathlib's avg({})
		assertEqual(0, val)
	end script

	script avg_NonList_ThrowsError
		property parent : UnitTest(me)
		try
			set val to my mathlib's avg(1)
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script

	script avg_NonNumberInList_ThrowsError
		property parent : UnitTest(me)
		try
			set val to my mathlib's avg({"a", "b", "c"})
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script


	script max_GivenIntegerList_ReturnsLargestValue
		property parent : UnitTest(me)
		set val to my mathlib's max({1, 4, 5, 9, 2})
		assertEqual(9, val)
	end script

	script max_GivenTextList_ReturnsLargestValue
		property parent : UnitTest(me)
		set val to my mathlib's max({"a", "d", "c", "b"})
		assertEqual("d", val)
	end script

	script max_GivenMixedList_ThrowsError
		property parent : UnitTest(me)
		try
			set val to my mathlib's max({"c", "b", 1, 2})
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(-1700, errnum)
	end script

	script max_GivenNotAList_ThrowsError
		property parent : UnitTest(me)
		try
			set val to my mathlib's max(1)
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script


	script min_GivenIntegerList_ReturnsLargestValue
		property parent : UnitTest(me)
		set val to my mathlib's min({1, 4, 5, 9, 2})
		assertEqual(1, val)
	end script

	script min_GivenTextList_ReturnsLargestValue
		property parent : UnitTest(me)
		set val to my mathlib's min({"a", "d", "c", "b"})
		assertEqual("a", val)
	end script

	script min_GivenMixedList_ThrowsError
		property parent : UnitTest(me)
		try
			set val to my mathlib's min({"c", "b", 1, 2})
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(-1700, errnum)
	end script

	script min_GivenNotAList_ThrowsError
		property parent : UnitTest(me)
		try
			set val to my mathlib's min(1)
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script
end script


script SingleNumberFunctions
	property parent : BaseMathTest

	script abs_GivenPositiveNumber_ReturnsSameNumber
		property parent : UnitTest(me)
		set val to my mathlib's abs(1)
		assertEqual(1, val)
	end script

	script abs_GivenNegativeNumber_ReturnsPositiveEquivalent
		property parent : UnitTest(me)
		set val to my mathlib's abs(-1)
		assertEqual(1, val)
	end script

	script abs_GivenZero_ReturnsZero
		property parent : UnitTest(me)
		set val to my mathlib's abs(-1)
		assertEqual(1, val)
	end script

	script abs_GivenNonNumber_ThrowsError
		property parent : UnitTest(me)
		try
			set val to my mathlib's abs({})
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script


	script ceil_GivenInteger_ReturnsSameNumber
		property parent : UnitTest(me)
		set val to my mathlib's ceil(5)
		assertEqual(5, val)
	end script

	script ceil_GivenReal_ReturnsNextNumber
		property parent : UnitTest(me)
		set val to my mathlib's ceil(4.7)
		assertEqual(5, val)
	end script

	script ceil_GivenText_ReturnsNextNumber
		property parent : UnitTest(me)
		try
			set val to my mathlib's ceil("a")
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script


	script floor_GivenInteger_ReturnsSameNumber
		property parent : UnitTest(me)
		set val to my mathlib's floor(5)
		assertEqual(5, val)
	end script

	script floor_GivenReal_ReturnsNextNumber
		property parent : UnitTest(me)
		set val to my mathlib's floor(4.7)
		assertEqual(4, val)
	end script

	script floor_GivenText_ReturnsNextNumber
		property parent : UnitTest(me)
		try
			set val to my mathlib's floor("a")
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script


	script sqrt_GivenPerfectSquare_ReturnsSquareRoot
		property parent : UnitTest(me)
		set val to my mathlib's sqrt(25)
		assertEqual(5, val)
	end script

	script sqrt_GivenNotPerfectSquare_ReturnsDecimal
		property parent : UnitTest(me)
		-- Coercing to string because the float values don't quite match up
		-- and shows as a failure:
		(*
			FAILURES
			------------------------------------------------------------------
			test: BaseMathTest - sqrt_GivenNotPerfectSquare_ReturnsDecimal
			      Expected: 4.795831523313
			        Actual: 4.795831523313
			------------------------------------------------------------------
		*)
		set val to my mathlib's sqrt(23) as string
		assertEqual("4.795831523313", val)
	end script

	script sqrt_GivenNegativeNumber_ReturnsPositiveNumber
		property parent : UnitTest(me)
		set val to my mathlib's sqrt(-25)
		assertEqual(5, val)
	end script

	script sqrt_GivenNotANumber_ThrowsError
		property parent : UnitTest(me)
		try
			set val to my mathlib's sqrt("a")
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script


	script isEven_GivenEven_ReturnsTrue
		property parent : UnitTest(me)
		set val to my mathlib's is_even(2)
		assertEqual(true, val)
	end script

	script isEven_GivenOdd_ReturnsFalse
		property parent : UnitTest(me)
		set val to my mathlib's is_even(3)
		assertEqual(false, val)
	end script

	script isEven_GivenNotANumber_ThrowsError
		property parent : UnitTest(me)
		try
			set val to my mathlib's is_even("a")
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script


	script isOdd_GivenEven_ReturnsTrue
		property parent : UnitTest(me)
		set val to my mathlib's is_odd(3)
		assertEqual(true, val)
	end script

	script isOdd_GivenOdd_ReturnsFalse
		property parent : UnitTest(me)
		set val to my mathlib's is_odd(2)
		assertEqual(false, val)
	end script

	script isOdd_GivenNotANumber_ThrowsError
		property parent : UnitTest(me)
		try
			set val to my mathlib's is_odd("a")
		on error msg number errnum
			set errnum to errnum
		end try
		assertEqual(704, errnum)
	end script
end script
