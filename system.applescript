(*!
 * @header
 * 		Library for working with folders and files.
 *
 * 		Darrick Herwehe http://www.exitcodeone.com
 *)
property version : "1.0"


(*!
 * Determine if a file or folder exists
 *
 * @param pth (String, Alias, Disk Item) Representation of a file or folder.
 *                        			 	 This can be a string representing a
 *                        			 	 POSIX or HFS+ path, a file alias, or
 *                        			 	 System Events Disk Item.
 * @return (Boolean)
 *)
on exists_path(pth)
	if class of pth is not string then
		-- You cannot get an alias or disk item unless it already exists.
		return true
	end if
	tell application "System Events"
		return exists disk item pth
	end tell
end exists_path


(*!
 * Determine if computer is connected to a network server share
 *
 * @param servername (String): The name of the server
 * @return (Boolean)
 *)
on server_connected(servername)
	return exists_path(servername)
end server_connected


(*!
 * Return the parent folder, name, and extension of a path.
 *
 * If given a file path, the name returned will be the name of the folder, and
 * the extension will be an empty String
 *
 * @param pth (String, Alias) The file path. Accepts an HFS+ or POSIX file path
 *                     		  or a file Alias.
 * @return (List)
 *)
on path_parts(pth)
	if class of pth is alias then
		set pth to pth as string
	end if

	--Get the character that separates each folder
	set {colon, backslash, slash} to {":", "/", "\\"}

	if pth contains colon then
		set separator to colon
	else if pth contains backslash then
		set separator to backslash
	else if pth contains slash then
		set separator to slash
	else
		set separator to colon
	end if

	--Remove trailing separator from folders
	if pth ends with separator then
		set pth to items 1 thru -2 of pth as string
	end if

	set parts to _split(pth, separator)
	if ((count parts) > 1) then
		set parentdir to _join(items 1 thru -2 of parts, separator)
		set splitfilename to _split(item -1 of parts, ".")
		if (count splitfilename) > 1 then
			set filename to _join(items 1 thru -2 of splitfilename, ".")
			set extension to item -1 of splitfilename
		else
			set filename to item 1 of splitfilename
			set extension to ""
		end if

		if parentdir is "" then
			set parentdir to separator
		end if
	else
		set parentdir to ""
		set filename to pth
		set extension to ""
	end if

	return {parentdir, filename, extension}
end path_parts


on parent_dir(pth)
	set pth to _ensure_path_is_string(pth)
	set separator to _separator_of(pth)

	--Remove trailing separator from folders or else the same folder is returned
	if pth ends with separator then
		set pth to text 1 thru -2 of pth
	end if

	set parts to _split(pth, separator)
	if ((count parts) > 1) then
		return _join(items 1 thru -2 of parts, separator)
	end if
	return pth
end parent_dir


(*!
 * Extract the volume/disk name from a path.
 *
 * @param pth (String, Alias) The path from which to extract the disk name
 * @return (String)
 *)
on disk_of(pth)
	set pth to _ensure_path_is_string(pth)
	set separator to _separator_of(pth)

	set parts to _split(pth, separator)
	set partcount to (count parts)
	repeat with i from 1 to partcount
		if item i of parts is "Volumes" and i < partcount then
			return item (i + 1) of parts
		end if
	end repeat
	return item 1 of parts
end disk_of


(*
 * Private helper functions.
 *
 * These routines are available in other libraries, but are copied here to
 * reduce dependencies. It's not ideal, but these provide basic functionality
 * in most other languages.
 *
 *)
on _separator_of(pth)
	set separators to {":", "/"}
	repeat with i from 1 to (count separators)
		if pth contains item i of separators then
			return item i of separators
		end if
	end repeat
	return ":"
end _separator_of


on _ensure_path_is_string(pth)
	if class of pth is alias then
		return pth as string
	end if
	return pth
end _ensure_path_is_string


on _split(str, delimiter)
	if str is "" then
		return {str}
	end if
	set AppleScript's text item delimiters to delimiter
	set theList to text items of str
	set AppleScript's text item delimiters to ""
	return theList
end _split


on _join(theList, delimiter)
	set AppleScript's text item delimiters to delimiter
	set theText to theList as text
	set AppleScript's text item delimiters to ""
	return theText
end _join

