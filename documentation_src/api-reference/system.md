
Library for working with folders and files.



# File level functions

#### `disk_of`
```applescript
disk_of(pth)
```
Extract the volume/disk name from a path.

<p class="attribute_section">Arguments</p>

* **pth** [_String, Alias_]  The path from which to extract the disk name

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `exists_path`
```applescript
exists_path(pth)
```
Determine if a file or folder exists

<p class="attribute_section">Arguments</p>

* **pth** [_String, Alias, Disk Item_]  Representation of a file or folder. This can be a string representing a POSIX or HFS+ path, a file alias, or System Events Disk Item.

<p class="attribute_section">Returns</p>

* [_Boolean_] 


<br/>

#### `parent_dir`
```applescript
parent_dir(pth)
```
Get the parent directory of the given path

<p class="attribute_section">Arguments</p>

* **pth** [_String, Alias, Disk Item_]  The original path

<p class="attribute_section">Returns</p>

* [_String_] 


<br/>

#### `path_parts`
```applescript
path_parts(pth)
```
Return the parent folder, name, and extension of a path.

If given a file path, the name returned will be the name of the folder, and the extension will be an empty String

<p class="attribute_section">Arguments</p>

* **pth** [_String, Alias_]  The file path. Accepts an HFS+ or POSIX file path or a file Alias.

<p class="attribute_section">Returns</p>

* [_List_] 


<br/>

#### `server_connected`
```applescript
server_connected(servername)
```
Determine if computer is connected to a network server share

<p class="attribute_section">Arguments</p>

* **servername** [_String_] The name of the server

<p class="attribute_section">Returns</p>

* [_Boolean_] 


<br/>

