
Library for working with and manipulating lists



# File level functions

#### `count_instances`
```applescript
count_instances(value, ls)
```
Count the amount of times an item appears in a list.

<p class="attribute_section">Arguments</p>

* **value** [_Any_] The item to find
* **ls** [_List_] The list to search for the value.

<p class="attribute_section">Returns</p>

* [_Integer_] 


<br/>

#### `diff`
```applescript
diff(l1, l2)
```
Return the values of the first list that are not present in the second list.

Because of Applescript comparison limitations, records and lists are not supported by this routine. Any lists containing a record or list will throw a TypeError.

<p class="attribute_section">Arguments</p>

* **l1** [_List_] The first list to compare. This is where the result set will come from.
* **l2** [_List_] The list that is being compared to

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
diff({"a", "b", "c", "d"}, {"a", "b", "e", "f"})
--> {"c", "d"}
```
<br/>

#### `index_of`
```applescript
index_of(theItem, ls)
```
Get the index of the first occurrence of an item in a list.

Applescript provides the `offset` command for strings, but does not provide a way to get the index of an item in a list. This provides that missing functionality.

Returns 0 if the item is not found.

<p class="attribute_section">Arguments</p>

* **theItem** [_Any_] The item to find in the list
* **ls** [_List_] The list in which to find the item

<p class="attribute_section">Returns</p>

* [_Integer_] 


<br/>

#### `insert`
```applescript
insert(theItem, ix, ls)
```
Insert an item into a given position in a list.

The item will be placed in the position before the given index, so `insert(x, 1, ls)` will be placed in the first position and `insert(x, (count ls) + 1, ls)` is the same as `set end of ls to x`.

<p class="attribute_section">Arguments</p>

* **theItem** [_Any_] The item to insert into the list
* **ix** [_Integer_] The index where the item should be inserted into the list
* **ls** [_List_] The list in which to insert the item

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
insert("d", 4, {"a", "b", "c"})
--> {"a", "b", "c", "d"}
```
<br/>

#### `intersect`
```applescript
intersect(l1, l2)
```
Return only the values of the first list also contained in the second list.

Basically the opposite of `diff()`

<p class="attribute_section">Arguments</p>

* **l1** [_List_] The first list to compare. This is where the result set will come from.
* **l2** [_List_] The list that is being compared to

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
intersect({"a", "b", "c", "d"}, {"a", "b", "e", "f"})
--> {"a", "b"}
```
<br/>

#### `move_item`
```applescript
move_item(ls, oldindex, newindex)
```
Move an item from one spot in the list to another.

Note that `move_item` removes the item from the list _first_, then readds it in the desired location. So, if you want to move an item to the end of a 3 item list, you would specify `3` as the `newindex`, not `4`.

<p class="attribute_section">Arguments</p>

* **ls** [_List_] The list containing the element
* **oldindex** [_Integer_] The index of the item to move
* **newindex** [_Integer_] The index to where the item should be moved

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
move_item({"a", "b", "c"}, 1, 3)
--> {"b", "c", "a"}
```

```applescript
move_item({"a", "b", "c"}, 1, 4)
--> IndexError: Cannot insert item at index 4 when list has 2 items. (705)
```
<br/>

#### `pop`
```applescript
pop(ls)
```
Remove the last item from a list and return it.

Acts as a shortcut for `pop_index((count ls), ls)`

Because an item cannot be deleted in place from a list, the return value will be a list containing both the popped value and the original list minus the last item (items 1 thru -2 of the list).

The first item will be the popped value. The second value will be the updated list.

<p class="attribute_section">Arguments</p>

* **ls** [_List_] The list from which to pop the last value

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
listlib's pop({"a", "b", "c"})
--> {"c", {"a", "b"}}
```
<br/>

#### `pop_index`
```applescript
pop_index(ix, ls)
```
Remove an item from a list at the given index and return it.

Because an item cannot be deleted in place from a list, the return value will be a list containing both the popped value and the original list minus the popped item (`rest of list` if index is 1).

The first item will be the popped value. The second value will be the updated list.

If you just want to delete at an item at an index and do not care about the return value, you can run `pop_index()` and simply ignore the first return value.

!!! warning
	`pop_index()` does not support reverse indexing. You will receive an error for `pop_index(-1, ls)`. To reverse index you will need to pass the actual index number to be popped: `pop_index((count ls), ls)`

<p class="attribute_section">Arguments</p>

* **ix** [_Integer_] The index to pop from the list
* **ls** [_List_] The list from which to pop the last value

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
-- Pop an item and get its value
listlib's pop_index(2, {"a", "b", "c"})
--> {"b", {"a", "c"}}
```

```applescript
-- Delete an item from a list, ignoring its return value
set {_, ls} to listlib's pop_index(2, {"a", "b", "c"})
```
<br/>

#### `remove`
```applescript
remove(theItem, ls)
```
Remove the first occurrence of an item from a list.

If the item is not present in the list, the list will remain unchanged.

<p class="attribute_section">Arguments</p>

* **theItem** [_Any_]  The item to remove
* **ls** [_List_] The list from which to remove the item.

<p class="attribute_section">Returns</p>

* [_List_] 


<br/>

#### `sort`
```applescript
sort(theList)
```
Sort a list.

This is the quicksort routine taken from Kevin Bradley's Nite Flite library. http://mac.brothersoft.com/nite-flite-script-library.html

<p class="attribute_section">Arguments</p>

* **theList** [_List_] The list to sort

<p class="attribute_section">Returns</p>

* [_List_] 


<br/>

#### `unique`
```applescript
unique(ls)
```
Remove duplicate items from a list.

Because of Applescript comparison limitations, records and lists are not supported by this routine. Any lists containing a record or list will throw a TypeError.

<p class="attribute_section">Arguments</p>

* **ls** [_List_] The list containing duplicates to delete

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
unique({"a", "b", "c", "a", "b"})
--> {"a", "b", c}
```
<br/>

#### `zip`
```applescript
zip(ls1, ls2)
```
Zip two lists together, creating a list of 2-item lists.

Works the same way as `zip_many()` except for only two lists.

<p class="attribute_section">Arguments</p>

* **ls1** [_List_] :
* **ls2** [_List_] :

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
set l1 to {"a", "b", "c"}
set l2 to {"d", "e", "f"}
zip(l1, l2)
--> {{"a", "d"}, {"b", "e"}, {"c", "f"}}
```
<br/>

#### `zip_many`
```applescript
zip_many(ls)
```
Zip lists together, creating a list of n-item lists, where n = (count lists).

Iterate through each of the given lists, adding their current values to an n-item list. If no lists are given (`zip_many()` receives a zero-item list), an empty list will be returned.

If the lists are not the same length, the shortest will be used as the iteration count, and the remaining items of the longer lists will be thrown away.

<p class="attribute_section">Arguments</p>

* **ls** [_List_] A list of lists

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
zip_many({})
--> {}
```

```applescript
set l1 to {"a", "b", "c"}
set l2 to {"d", "e", "f"}
set l3 to {1, 2, 3}
zip_many({l1, l2, l3})
--> {{"a", "d", 1}, {"b", "e", 2}, {"c", "f", 3}}
```

```applescript
set l1 to {"a", "b", "c"}
set l2 to {"d", "e", "f"}
set l3 to {"1"}
zip_many({l1, l2, l3})
--> {{"a", "d", 1}}
```
<br/>

