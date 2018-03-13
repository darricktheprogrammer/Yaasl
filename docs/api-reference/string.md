
Library for working with and manipulating text

Darrick Herwehe http://www.exitcodeone.com



# File level functions

#### `convert_case`
```applescript
convert_case(str, tCase)
```
Alternative method of converting case without directly calling the other routines.

<p class="attribute_section">Arguments</p>

* **str** [_String_] The text to convert.
* **tCase** [_String_] The desired case ("uppercase", "lowercase", "titlecase", or "sentencecase")

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `format`
```applescript
format(str, args)
```
Simplistic, python-style string formatter.

This routine is based on python's `string.format()` method, but is a lot simpler. It will replace each instance of curly braces (`{}`) in the first string argument with the corresponding string from the list given as the second argument. This routine does not support python's more advanced string replacement features, such as the mini-language, or positional/keyworded substitutions.

As a convenience, if there is only one replacement to be made, the second argument can simply be a string. It does not have to be a list.

To escape a set of braces, simply put an asterisk in between them. This will tell `format()` to ignore them, and they will be printed out as a standard set of braces.

``` format("This is a {} string.", "test")         --> This is a test string. format("This is a {} string.", {"test"})       --> This is a test string. format("This is a {} {}", {"test", "string"})  --> This is a test string. format("This is a {} string.", {"test"})       --> This is a test string. format("These are {}: {*}.", {"curly braces"}) --> These are curly braces: {}. ```

<p class="attribute_section">Arguments</p>

* **str** [_String_] The original string formatting template.
* **args** [_String, List_]  One or more strings used to replace `{}` in the string template.

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `join`
```applescript
join(theList, delimiter)
```
Convert a list to string, inserting a delimiter between each list item.

<p class="attribute_section">Arguments</p>

* **theList** [_List_] The list to convert.
* **delimiter** [_String_] The text to insert between list items.

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `pad_left`
```applescript
pad_left(str, padwidth)
```
Pad a string with spaces on the left until it reaches the desired width.

<p class="attribute_section">Arguments</p>

* **str** [_String_] The string to pad.
* **padwidth** [_Integer_] The desired width of the string.

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `pad_left_with_char`
```applescript
pad_left_with_char(char, str, padwidth)
```
Pad a string with the given on the left until it reaches the desired width.

<p class="attribute_section">Arguments</p>

* **char** [_Char_] A single character to be used for padding.
* **str** [_String_] The string to pad.
* **padwidth** [_Integer_] The desired width of the string.

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `pad_right`
```applescript
pad_right(str, padwidth)
```
Pad a string with spaces on the right until it reaches the desired width.

<p class="attribute_section">Arguments</p>

* **str** [_String_] The string to pad.
* **padwidth** [_Integer_] The desired width of the string.

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `pad_right_with_char`
```applescript
pad_right_with_char(char, str, padwidth)
```
Pad a string with the given on the right until it reaches the desired width.

<p class="attribute_section">Arguments</p>

* **char** [_Char_] A single character to be used for padding.
* **str** [_String_] The string to pad.
* **padwidth** [_Integer_] The desired width of the string.

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `search_and_replace`
```applescript
search_and_replace(str, oldText, newText)
```
Search for text and replace it.

<p class="attribute_section">Arguments</p>

* **str** [_String_] The original string.
* **oldText** [_String_] The text to replace.
* **newText** [_String_] The replacement text.

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `sentence_case`
```applescript
sentence_case(str)
```
Convert text to contain capital letters at beginning of each sentence.

The end of a sentences is considered to be one of ".!?" followed by one or two spaces.

<p class="attribute_section">Arguments</p>

* **str** [_String_] The string to convert.

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `split`
```applescript
split(str, delimiter)
```
Split a string into a list on the delimiter.

<p class="attribute_section">Arguments</p>

* **str** [_String_] The string to split.
* **delimiter** [_String_] The delimiter on which to split the string.

<p class="attribute_section">Returns</p>

* [_List_] 


<br/>

#### `title_case`
```applescript
title_case(str)
```
Convert text to title case.

Does not take punctuation into account. Only words preceded by a space will be capitalized.

The following words will always be converted to lowercase and not capitalized: a, an, in, the, and, but, for, or, nor, to.

<p class="attribute_section">Arguments</p>

* **str** [_String_] The text to convert.

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `to_lower`
```applescript
to_lower(str)
```
Convert a string to all lowercase, maintaining special characters.

<p class="attribute_section">Arguments</p>

* **str** [_String_] The string in which to convert the case.

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `to_upper`
```applescript
to_upper(str)
```
Convert a string to all uppercase, maintaining special characters.

<p class="attribute_section">Arguments</p>

* **str** [_String_] The string in which to convert the case.

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `trim`
```applescript
trim(str)
```
Remove whitespace from beginning and end of string.

<p class="attribute_section">Arguments</p>

* **str** [_String_] The string to trim.

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

