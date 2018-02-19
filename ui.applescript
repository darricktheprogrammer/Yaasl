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
on chooseFromList(currList, currDialog, defaultItem)
	--Window management: gets front app, and returns focus to that app when done

	set frontAppPath to path to frontmost application
	tell application "Finder" to set FrontAppName to name of frontAppPath
	tell me to activate

	set myChoice to choose from list currList with prompt currDialog default items defaultItem with multiple selections allowed
	set theResult to result
	tell application FrontAppName to activate
	if theResult is false then
		error number -128
	else
		set myChoice to theResult
		set myChoice to every item of myChoice
	end if
	return myChoice
end chooseFromList


--Sub-routine to display a dialog, while managing the program windows
--------------------------------------------------------------------------------
on dispDialog(theText, typeSpecifier)
	--Window management: gets front app, and returns focus to that app when done

	set frontAppPath to path to frontmost application
	tell application "Finder" to set FrontAppName to name of frontAppPath
	tell me to activate

	if class of typeSpecifier is list then
		set theButtons to typeSpecifier
		set theDialog to display dialog theText buttons theButtons default button (item -1 of theButtons)
		set userInput to button returned of theDialog
	else
		set startingText to typeSpecifier
		set theDialog to display dialog theText default answer startingText
		set userInput to text returned of theDialog
	end if

	tell application FrontAppName to activate
	return userInput
end dispDialog


--Sub-routine to let user choose a path; default path is the front Finder window
--------------------------------------------------------------------------------
on getPathFromUser()
	tell application "Finder"
		try
			set theSelection to folder of front window as alias
		on error
			set theSelection to (path to desktop)
		end try
	end tell

	set folderChoice to choose folder with prompt "Where are the files?" default location theSelection with multiple selections allowed
	return folderChoice
end getPathFromUser


--Sub-routine to let user choose a path; default path is the front Finder window
--------------------------------------------------------------------------------
on getFileFromUser()
	tell application "Finder"
		try
			set theSelection to folder of front window as alias
		on error
			set theSelection to (path to desktop)
		end try
	end tell

	set fileChoice to choose file with prompt "Where is the file?" default location theSelection
	return fileChoice
end getFileFromUser
