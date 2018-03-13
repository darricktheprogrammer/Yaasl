
Library to add additional functional programming support to Applescript. Contains helper functions that are able to be passed into `map()` and `filter()`. These are duplicates of Applescript built-in functionality, but because the built-in functionality are not first-class functions, they are unable to be passed into functional programming tools.

For example, there are helper functions for coercion such as `tostring(x)`. Even though this is built into the language, the helper function is there so it can be passed into `map()` like in the following example: `map(funclib's tostring, theList)` will convert {1, 2, 3} to {"1", "2", "3"}.

!!! warning
	Any function passed to `map` or `filter` that is not self contained (i.e., calls another function) will error out. Once the function is passed to `functools`, it is then a property of the `functools` library, meaning it no longer has access to any of the functions in it's own library. Until a fix can be determined, only attempt to `map` or `filter` using self contained functions.

Darrick Herwehe http://www.exitcodeone.com @unordered

# _FunctionRunner
Object that is responsible for actually running a single function and returning a result.

#### `_FunctionRunner.runit`
```applescript
runit(f, arg)
```
Run a given function with a single argument.

The arg will be an item in a list.

<p class="attribute_section">Arguments</p>

* **f** [_Function_] The function to run
* **arg** [_Any_] An argument to the function

<p class="attribute_section">Returns</p>

* [_Any_] 


<br/>

#### `_FunctionRunner.runwitharg`
```applescript
runwitharg(f, arg, extra_arg)
```
Run a given function with two arguments.

The first argument will be the item from a list. The second will be an extra argument needed for the function. This argument may be used as a comparison point or operator against the first argument.

<p class="attribute_section">Arguments</p>

* **f** [_Function_] The function to run
* **arg** [_Any_] An argument to the function
* **extra_arg** [_Any_] The second argument. Either a comparison point or operator against the first argument

<p class="attribute_section">Returns</p>

* [_Any_] 


<br/>



# File level functions

#### `contains_`
```applescript
contains_(x, ls)
```
Return true if the list ls contains x

<p class="attribute_section">Arguments</p>

* **x** 
* **ls** 



<br/>

#### `eq`
```applescript
eq(x, y)
```
Return true if x equals y

<p class="attribute_section">Arguments</p>

* **x** 
* **y** 



<br/>

#### `filter`
```applescript
filter(f, ls)
```
Create a list from ls for each item that returns true when passed through f

<p class="attribute_section">Arguments</p>

* **f** [_Function_] :
* **ls** [_List_] :

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
filter(is_even, {1, 2, 3})
--> {2}
```
<br/>

#### `filterWithArg`
```applescript
filterWithArg(f, ls, arg)
```
Same as `filter()`, but with an additional argument.

The additional argument is usually used to make a comparison to the original value.

<p class="attribute_section">Arguments</p>

* **f** [_Function_] :
* **ls** [_List_] :
* **arg** [_Any_] :

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
filterWithArg(lte, {1, 2, 3, 4, 5, 6}, 4)
--> {1, 2, 3, 4}
```
<br/>

#### `gt`
```applescript
gt(x, y)
```
Return true if x greater than y

<p class="attribute_section">Arguments</p>

* **x** 
* **y** 



<br/>

#### `gte`
```applescript
gte(x, y)
```
Return true if x greater than or equal to y

<p class="attribute_section">Arguments</p>

* **x** 
* **y** 



<br/>

#### `isclass`
```applescript
isclass(x, cls)
```
Return true if class of x cls

<p class="attribute_section">Arguments</p>

* **x** 
* **cls** 



<br/>

#### `isin`
```applescript
isin(x, ls)
```
Return true if x is in the list ls

<p class="attribute_section">Arguments</p>

* **x** 
* **ls** 



<br/>

#### `len`
```applescript
len(x)
```
Return the count of x

<p class="attribute_section">Arguments</p>

* **x** 



<br/>

#### `lt`
```applescript
lt(x, y)
```
Return true if x is less than y

<p class="attribute_section">Arguments</p>

* **x** 
* **y** 



<br/>

#### `lte`
```applescript
lte(x, y)
```
Return true if x is less than or equal to y

<p class="attribute_section">Arguments</p>

* **x** 
* **y** 



<br/>

#### `map`
```applescript
map(f, ls)
```
Create a new list by passing each item of a list through a function.

<p class="attribute_section">Arguments</p>

* **f** [_Function_] :
* **ls** [_List_] :

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
map(tostring, {1, 2, 3})
--> {"1", "2", "3"}
```

```applescript
map(len, {"hello", "world", "I'm", "here"})
--> {5, 5, 3, 4}
```
<br/>

#### `mapWithArg`
```applescript
mapWithArg(f, ls, arg)
```
Same as `map()`, but with an additional argument.

The last argument will be supplied as a second argument to the function.

<p class="attribute_section">Arguments</p>

* **f** [_Function_] :
* **ls** [_List_] :
* **arg** [_Any_] :

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
mapWithArg(add_value, {1, 2, 3}, 2)
--> {3, 4, 5}
```
<br/>

#### `neq`
```applescript
neq(x, y)
```
Return true if x does not equal y

<p class="attribute_section">Arguments</p>

* **x** 
* **y** 



<br/>

#### `toint`
```applescript
toint(x)
```
Coerce x to an integer

<p class="attribute_section">Arguments</p>

* **x** 



<br/>

#### `tolist`
```applescript
tolist(x)
```
Coerce x to a list

<p class="attribute_section">Arguments</p>

* **x** 



<br/>

#### `tonum`
```applescript
tonum(x)
```
Coerce x to a generic number

<p class="attribute_section">Arguments</p>

* **x** 



<br/>

#### `toreal`
```applescript
toreal(x)
```
Coerce x to a real number

<p class="attribute_section">Arguments</p>

* **x** 



<br/>

#### `tostring`
```applescript
tostring(x)
```
Coerce x to a string

<p class="attribute_section">Arguments</p>

* **x** 



<br/>

