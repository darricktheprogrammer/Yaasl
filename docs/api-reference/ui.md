
Library for interacting with the user.

Mostly contains shortcuts that help exclude error handling inline, or focus the dialog window, which does not always happen by default.

Darrick Herwehe http://www.exitcodeone.com



# File level functions

#### `choose_from_list`
```applescript
choose_from_list(choice_list, choice_prompt, default_item)
```
Choose from list convenience function.

Displays a `choose from list` dialog, ensuring that the dialog has focus when displayed. `choose_from_list` also handles the basic error handling (such as error -128 user cancelled).

Note that multiple items _are_ allowed to be chosen. If you choose to use this function and are only expecting one value returned, you will have to get the first item of the returned list.

<p class="attribute_section">Arguments</p>

* **choice_list** [_List_] The list for the user to choose from
* **choice_prompt** [_String_] The text prompt, describing to the user what they are choosing
* **default_item** [_String_] The list item to highlight by default. If that option is not in the list, no default will be highlighted

<p class="attribute_section">Returns</p>

* [_List_] 


<p class="attribute_section">Examples</p>

```applescript
set choices to {1, 2, 3}
set choice_prompt to "How many times would you like to repeat?"
set repeat_num to item 1 of choose_from_list(choices, choice_prompt, item 1 of choices)
--> 1
```
<br/>

