
Library for basic math functions



# File level functions

#### `abs`
```applescript
abs(n)
```
Calculate the absolute value of a number

<p class="attribute_section">Arguments</p>

* **n** [_Number_] 

<p class="attribute_section">Returns</p>

* [_Number_] 


<br/>

#### `avg`
```applescript
avg(ls)
```
Compute the average given a list of numbers

<p class="attribute_section">Arguments</p>

* **ls** [_List_]  A list of numbers (can be reals or integers)

<p class="attribute_section">Returns</p>

* [_Real_] 


<p class="attribute_section">Examples</p>

```applescript
avg({1, 2, 3, 4, 5})
--> 3.0
```
<br/>

#### `ceil`
```applescript
ceil(n)
```
Determine the next integer up from the given number

<p class="attribute_section">Arguments</p>

* **n** [_Number_] 

<p class="attribute_section">Returns</p>

* [_Integer_] 


<br/>

#### `floor`
```applescript
floor(n)
```
Determine the next integer down from the given number

<p class="attribute_section">Arguments</p>

* **n** [_Number_] 

<p class="attribute_section">Returns</p>

* [_Integer_] 


<br/>

#### `is_even`
```applescript
is_even(n)
```
Determine if a number is even

<p class="attribute_section">Arguments</p>

* **n** [_Number_] 

<p class="attribute_section">Returns</p>

* [_Boolean_] 


<br/>

#### `is_odd`
```applescript
is_odd(n)
```
Determine if a number is odd

<p class="attribute_section">Arguments</p>

* **n** [_Number_] 

<p class="attribute_section">Returns</p>

* [_Boolean_] 


<br/>

#### `max`
```applescript
max(ls)
```
Calculate the largest item in a list

Can be used for any type that can be compared, not just numbers. For example, text can be compared where `b > a`. However, lists cannot be compared, and numbers cannot be compared to text. `max()` does not try to error check item types and leaves it up to you to follow Applescript's comparison rules.

<p class="attribute_section">Arguments</p>

* **ls** [_List_] 

<p class="attribute_section">Returns</p>

* [_Any_] 


<br/>

#### `min`
```applescript
min(ls)
```
Calculate the smallest item in a list

Can be used for any type that can be compared, not just numbers. For example, text can be compared where `b < a`. However, lists cannot be compared, and numbers cannot be compared to text. `min()` does not try to error check item types and leaves it up to you to follow Applescript's comparison rules.

<p class="attribute_section">Arguments</p>

* **ls** [_List_] 

<p class="attribute_section">Returns</p>

* [_Any_] 


<br/>

#### `sqrt`
```applescript
sqrt(n)
```
Calculate the square root of a number

<p class="attribute_section">Arguments</p>

* **n** [_Number_] 

<p class="attribute_section">Returns</p>

* [_Real_] 


<br/>

#### `sum`
```applescript
sum(ls)
```
Sum a list of numbers.

Returns 0 if the list is empty.

<p class="attribute_section">Arguments</p>

* **ls** [_List_]  The list of numbers

<p class="attribute_section">Returns</p>

* [_Number_] 


<p class="attribute_section">Examples</p>

```applescript
sum({1, 2, 3})
--> 6
```
<br/>

