(**
 * Library for interacting with the user.
 *
 * Mostly contains shortcuts that help exclude error handling inline.
 *
 * Darrick Herwehe http://www.exitcodeone.com
 *)
property version : "1.0"


--Sub-routine to manage windows while get user list input
--------------------------------------------------------------------------------
	--Window management: gets front app, and returns focus to that app when done

on choose_from_list(choice_list, choice_prompt, default_item)
	set frontAppPath to path to frontmost application
	tell application "Finder" to set FrontAppName to name of frontAppPath
	tell me to activate

	set myChoice to choose from list choice_list with prompt choice_prompt default items default_item with multiple selections allowed
	set theResult to result
	tell application FrontAppName to activate
	if theResult is false then
		error number -128
	else
		set myChoice to theResult
		set myChoice to every item of myChoice
	end if
	return myChoice
end choose_from_list

--Sub-routine to display a dialog, while managing the program windows
--------------------------------------------------------------------------------
	--Window management: gets front app, and returns focus to that app when done

on display_dialog(dialog_text, user_input_method)
	set frontAppPath to path to frontmost application
	tell application "Finder" to set FrontAppName to name of frontAppPath
	tell me to activate

	if class of user_input_method is list then
		set theButtons to user_input_method
		set theDialog to display dialog dialog_text buttons theButtons default button (item -1 of theButtons)
		set userInput to button returned of theDialog
	else
		set startingText to user_input_method
		set theDialog to display dialog dialog_text default answer startingText
		set userInput to text returned of theDialog
	end if

	tell application FrontAppName to activate
	return userInput
end display_dialog


--Sub-routine to let user choose a path; default path is the front Finder window
--------------------------------------------------------------------------------
on choose_folder()
	tell application "Finder"
		try
			set theSelection to folder of front window as alias
		on error
			set theSelection to (path to desktop)
		end try
	end tell

	set folderChoice to choose folder with prompt "Where are the files?" default location theSelection with multiple selections allowed
	return folderChoice
end choose_folder


--Sub-routine to let user choose a path; default path is the front Finder window
--------------------------------------------------------------------------------
on choose_file()
	tell application "Finder"
		try
			set theSelection to folder of front window as alias
		on error
			set theSelection to (path to desktop)
		end try
	end tell

	set fileChoice to choose file with prompt "Where is the file?" default location theSelection
	return fileChoice
end choose_file
