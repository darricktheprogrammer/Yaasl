property parent : script "ASUnit"
property suite : makeTestSuite("List")

set suite's loggers to {ConsoleLogger}
autorun(suite)


script BaseListTest
	property parent : TestSet(me)
	property listlib : missing value
	
	property shortlist: {"a", "b", "c"}
	property longlist: {"a", "b", "c", "d", "e", "f", "g"}
		
	on setUp()
		set listlib to load script (POSIX file ((POSIX path of (path to me as string) & "/../../") & "list.scpt"))
	end setUp
end script
