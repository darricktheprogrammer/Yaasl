(*!
 * @header
 * 		Library to add additional functional programming support to Applescript.
 * 		Contains helper functions that are able to be passed into `map()` and
 * 		`filter()`. These are duplicates of Applescript built-in functionality, but
 * 		because the built-in functionality are not first-class functions, they are
 * 		unable to be passed into functional programming tools.
 *
 * 		For example, there are helper functions for coercion such as `tostring(x)`.
 * 		Even though this is built into the language, the helper function is there
 * 		so it can be passed into `map()` like in the following example:
 * 		`map(funclib's tostring, theList)` will convert `{1, 2, 3}` to `{"1", "2", "3"}`.
 *
 * 		!!! warning: Any function passed to `map` or `filter` that is not
 * 		self contained (i.e., it calls another function) will cause an error. Once the
 * 		function is passed to `functools`, it is then a property of the `functools`
 * 		library, meaning it no longer has access to any of the functions in it's own
 * 		library. Until a fix can be determined, only attempt to `map` or `filter`
 * 		using self contained functions.
 *
 *)
property version : "1.0"


-- Helper functions

(*! Return `true` if `x` is less than `y` *)
on lt(x, y)
	return x < y
end lt

(*! Return `true` if `x` is less than or equal to `y` *)
on lte(x, y)
	return x ≤ y
end lte

(*! Return `true` if `x` greater than `y` *)
on gt(x, y)
	x > y
end gt

(*! Return `true` if `x` greater than or equal to `y` *)
on gte(x, y)
	return x ≥ y
end gte

(*! Return `true` if `x` equals `y` *)
on eq(x, y)
	return x = y
end eq

(*! Return `true` if `x` does not equal `y` *)
on neq(x, y)
	return x ≠ y
end neq

(*! Return `true` if `x` is in the list `ls` *)
on isin(x, ls)
	return x is in ls
end isin

(*! Return `true` if the list `ls` contains `x` *)
on contains_(x, ls)
	return isin(x, ls)
end contains_

(*! Return `true` if class of `x` is `cls` *)
on isclass(x, cls)
	return class of x is cls
end isclass

(*! Return the count of `x` *)
on len(x)
	return (count x)
end len

(*! Coerce `x` to a string *)
on tostring(x)
	return x as string
end tostring

(*! Coerce `x` to a real number *)
on toreal(x)
	return x as real
end toreal

(*! Coerce `x` to an integer *)
on toint(x)
	return x as integer
end toint

(*! Coerce `x` to a generic number *)
on tonum(x)
	return x as number
end tonum

(*! Coerce `x` to a list *)
on tolist(x)
	return x as list
end tolist


(*!
 * Object that is responsible for actually running a single function and returning a result.
 *)
script _FunctionRunner
	property function : missing value

	(*!
	 * Run a given function with a single argument.
	 *
	 * The arg will be an item in a list.
	 *
	 * @param f (Function) The function to run
	 * @param arg (Any) An argument to the function
	 * @return (Any)
	 *)
	on runit(f, arg)
		set function to f
		return function(arg)
	end runit

	(*!
	 * Run a given function with two arguments.
	 *
	 * The first argument will be the item from a list. The second will be an
	 * extra argument needed for the function. This argument may be used as
	 * a comparison point or operator against the first argument.
	 *
	 * @param f (Function) The function to run
	 * @param arg (Any) An argument to the function
	 * @param extra_arg (Any) The second argument. Either a comparison point or
	 *                         operator against the first argument
	 * @return (Any)
	 *)
	on runwitharg(f, arg, extra_arg)
		set function to f
		return function(arg, extra_arg)
	end runwitharg
end script


(*!
 * Create a new list by passing each item of a list through a function.
 *
 * @example map(tostring, {1, 2, 3})
 *          	--> {"1", "2", "3"}
 *
 * @example map(len, {"hello", "world", "I'm", "here"})
 *          	--> {5, 5, 3, 4}
 *
 * @param f (Function)
 * @param ls (List)
 * @return (List)
 *)
on map(f, ls)
	if ls = {} then
		return ls
	end if
	return {_FunctionRunner's runit(f, item 1 of ls)} & map(f, rest of ls)
end map


(*!
 * Create a list from ls for each item that returns true when passed through f
 *
 * @example filter(is_even, {1, 2, 3})
 *          	--> {2}
 *
 * @param f (Function)
 * @param ls (List)
 * @return (List)
 *)
on filter(f, ls)
	if ls = {} then
		return {}
	else if not _FunctionRunner's runit(f, item 1 of ls) then
		return {} & filter(f, rest of ls)
	else
		return {item 1 of ls} & filter(f, rest of ls)
	end if
end filter


(*!
 * Same as `map()`, but with an additional argument.
 *
 * The last argument will be supplied as a second argument to the function.
 *
 * @example mapWithArg(add_value, {1, 2, 3}, 2)
 *          	--> {3, 4, 5}
 *
 * @param f (Function)
 * @param ls (List)
 * @param arg (Any)
 * @return (List)
 *)
on mapWithArg(f, ls, arg)
	if ls = {} then
		return ls
	end if
	return _FunctionRunner's runwitharg(f, item 1 of ls, arg) & mapWithArg(f, rest of ls, arg)
end mapWithArg


(*!
 * Same as `filter()`, but with an additional argument.
 *
 * The additional argument is usually used to make a comparison to the
 * original value.
 *
 * @example filterWithArg(lte, {1, 2, 3, 4, 5, 6}, 4)
 *          	--> {1, 2, 3, 4}
 *
 * @param f (Function)
 * @param ls (List)
 * @param arg (Any)
 * @return (List)
 *)
on filterWithArg(f, ls, arg)
	if ls = {} then
		return {}
	else if not _FunctionRunner's runwitharg(f, item 1 of ls, arg) then
		return {} & filterWithArg(f, rest of ls, arg)
	else
		return {item 1 of ls} & filterWithArg(f, rest of ls, arg)
	end if
end filterWithArg
