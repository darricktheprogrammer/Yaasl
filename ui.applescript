(**
 * Library for interacting with the user.
 *
 * Mostly contains shortcuts that help exclude error handling inline, or focus
 * the dialog window, which does not always happen by default.
 *
 * Darrick Herwehe http://www.exitcodeone.com
 *)
property version : "1.0"


(**
 * Choose from list convenience function.
 *
 * Displays a `choose from list` dialog, ensuring that the dialog has focus
 * when displayed. `choose_from_list` also handles the basic error handling
 * (such as error -128 user cancelled).
 *
 * Note that multiple items _are_ allowed to be chosen. If you choose to use
 * this function and are only expecting one value returned, you will have to get
 * the first item of the returned list.
 *
 * @example set choices to {1, 2, 3}
 *          set choice_prompt to "How many times would you like to repeat?"
 *          set repeat_num to item 1 of choose_from_list(choices, choice_prompt, item 1 of choices)
 *          --> 1
 *
 *
 * @param List The list for the user to choose from
 * @param String The text prompt, describing to the user what they are choosing
 * @param String The list item to highlight by default. If that option is not in
 *               the list, no default will be highlighted
 * @return List
 *)
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


(**
 * Display dialog convenience function.
 *
 * Displays a `display dialog` dialog, ensuring that the dialog has focus
 * when displayed. `display_dialog` also handles some basic button handling if
 * text input is not needed.
 *
 * @param String The text to be presented to the user.
 * @param [List, String] Either a list of button names, or default text to create
 *                       text input box. In this implementation, the two are
 *                       mutually exclusive. If you need text input,
 *                       and multiple button options, this function will not
 *                       work for you.
 *
 * 						 When given a list of buttons, the buttons are added to
 * 						 the dialog from left right with the rightmost button
 * 						 being the default. For example, `{"Cancel", "Okay"}`
 * 						 would add a `Cancel` button on the left, an `Okay`
 * 						 button on the right, and set `Okay` as
 * 						 the default button choice.
 * @return String
 *)
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


(**
 * Choose folder convenience function
 *
 * The main difference between this and vanilla `choose_folder` is that by
 * default, `choose_folder` starts in the current Finder window. So, if the front
 * Finder window has selected "~/Pictures/baby_pictures" that will be where the
 * prompt opens up to begin with. If there are no open Finder windows, the
 * default location will be ~/Desktop.
 *
 * Multiple selections are allowed.
 *
 * @return List
 *)
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


(**
 * Choose file convenience function
 *
 * Same as `choose_folder` but for files.
 *
 * Multiple selections are not allowed.
 *
 * @return Alias
 *)
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
