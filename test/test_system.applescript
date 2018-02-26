property parent : script "ASUnit"
property suite : makeTestSuite("System")

set suite's loggers to {ConsoleLogger}
autorun(suite)


script BaseSystemTest
	property parent : TestSet(me)
	property systemlib : missing value

	property NO_ERROR : "0: no error"
	property startup_disk : missing value

	-- System log should be available on all systems, so it is good for alias testing
	property systemlog : item 1 of (list disks) & ":private:var:log:system.log"

	on setUp()
		tell application "System Events" to set startup_disk to name of startup disk
		tell application "System Events"
			set top_level to POSIX path of (container of container of (path to me)) & "/"
		end tell
		set systemlib to load script (top_level & "system.scpt")
	end setUp
end script


script PathData
	property parent : BaseSystemTest

	script ExistsPath_HFSOfExistingPath_ReturnsTrue
		property parent : UnitTest(me)
		set path_exists to my systemlib's exists_path((path to desktop as string))
		assertEqual(true, path_exists)
	end script

	script ExistsPath_HFSOfNonExistingPath_ReturnsFalse
		property parent : UnitTest(me)
		set path_exists to my systemlib's exists_path("No:path:exists:")
		assertEqual(false, path_exists)
	end script

	script ExistsPath_PosixOfExistingPath_ReturnsTrue
		property parent : UnitTest(me)
		set path_exists to my systemlib's exists_path(POSIX path of (path to desktop as string))
		assertEqual(true, path_exists)
	end script

	script ExistsPath_PosixOfNonExistingPath_ReturnsFalse
		property parent : UnitTest(me)
		set path_exists to my systemlib's exists_path("/No/path/exists")
		assertEqual(false, path_exists)
	end script

	script ExistsPath_ExistingAlias_ReturnsTrue
		property parent : UnitTest(me)
		set path_exists to my systemlib's exists_path(path to desktop)
		assertEqual(true, path_exists)
	end script

	script ExistsPath_ExistingDiskItem_ReturnsTrue
		property parent : UnitTest(me)
		tell application "System Events"
			set the_path to disk item (path to desktop as string)
		end tell
		set path_exists to my systemlib's exists_path(the_path)
		assertEqual(true, path_exists)
	end script


	-- script ParentDir_FileAlias_ReturnsParentDirectory
	-- 	property parent : UnitTest(me)
	-- 	set pardir to my systemlib's parent_dir(alias my systemlog)
	-- 	assertEqual("Kobol:private:var:log", pardir)
	-- end script

	-- script ParentDir_HFSString_ReturnsParentDirectory
	-- 	property parent : UnitTest(me)
	-- 	set pardir to my systemlib's parent_dir(alias "Kobol:private:var:log:system.log")
	-- 	assertEqual("Kobol:private:var:log", pardir)
	-- end script

	-- script PathParts_ExistingAlias_ReturnsParts
	-- 	property parent : UnitTest(me)
	-- 	-- system log should be available on all systems
	-- 	set parts to my systemlib's path_parts(alias "Kobol:private:var:log:system.log")
	-- 	assertEqual({"Kobol:private:var:log", "system", "log"}, parts)
	-- end script

	script PathParts_HFSString_ReturnsParts
		property parent : UnitTest(me)
		set parts to my systemlib's path_parts("test:path:filename.ext")
		assertEqual({"test:path", "filename", "ext"}, parts)
	end script

	script PathParts_PosixString_ReturnsParts
		property parent : UnitTest(me)
		set parts to my systemlib's path_parts("/test/path/filename.ext")
		assertEqual({"/test/path", "filename", "ext"}, parts)
	end script

	script PathParts_MissingExtension_ReturnsEmptyString
		property parent : UnitTest(me)
		set parts to my systemlib's path_parts("/test/path/filename")
		assertEqual("", item -1 of parts)
	end script

	script PathParts_MultipleDotsInFilename_ReturnsLastAsExtension
		property parent : UnitTest(me)
		set parts to my systemlib's path_parts("/test/path/filename.1.0.ext")
		assertEqual("ext", item -1 of parts)
	end script

	script PathParts_Directory_ReturnsFolderNameWithoutExtension
		property parent : UnitTest(me)
		set parts to my systemlib's path_parts("/test/path/foldername/")
		assertEqual({"/test/path", "foldername", ""}, parts)
	end script

	script PathParts_RootDirectory_ReturnsParts
		property parent : UnitTest(me)
		set parts to my systemlib's path_parts("/test/")
		assertEqual({"/", "test", ""}, parts)
	end script

	script PathParts_FilenameOnly_ReturnsFilename
		property parent : UnitTest(me)
		set parts to my systemlib's path_parts("test")
		assertEqual({"", "test", ""}, parts)
	end script


	script DiskOf_GivenPosixPath_ReturnsDisk
		property parent : UnitTest(me)
		set disk_name to my systemlib's disk_of("/Volumes/diskname/dir/file.txt")
		assertEqual("diskname", disk_name)
	end script

	script DiskOf_GivenHFSPathToConnectedDisk_ReturnsDisk
		property parent : UnitTest(me)
		set disk_name to my systemlib's disk_of("Macintosh HD:Users:dir:file.txt")
		assertEqual("Macintosh HD", disk_name)
	end script

	script DiskOf_GivenHFSPathToUnconnectedDisk_ReturnsDisk
		property parent : UnitTest(me)
		set disk_name to my systemlib's disk_of("diskname:Users:dir:file.txt")
		assertEqual("diskname", disk_name)
	end script

	script DiskOf_GivenHFSPosixFile_ReturnsDisk
		property parent : UnitTest(me)
		set disk_name to my systemlib's disk_of("Macintosh HD:Volumes:diskname:dir:file.txt")
		assertEqual("diskname", disk_name)
	end script
end script






