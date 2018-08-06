# Yet Another AppleScript Library

Yaasl is a collection of Applescript libraries with useful subroutines. It mostly provides basic functionality found in other languages, and is heavily based on the Python standard library. On top of basic functionality, like splitting and joining strings, Yaasl also provides some more advanced functions, such as the functional `map` and `filter` routines and a simplistic version of Python's `string.format`.

See the full documentation at <yaasl?>.readthedocs.io.

# Why another library?

There are plenty of libraries out there, but they tend to exist to simply scratch the original maintainer's itch tailored to their own use case. This leaves each library only providing partial functionality for other end users. [`applescript-stdlib`](https://github.com/hhas/applescript-stdlib) shares some of the same goals as Yaasl, but relies on SDEFS and Script Bundles, and is meant as a proof-of-concept for actual built-in Applescript commands, where Yaasl aims for a pure Applescript solution.

Yaasl comes with a full test suite and complete auto-api documentation.

# Installation options

Open each library in Script Editor and save as a compiled script. Or compile on the command line using `osacompile`:

```bash
osacompile ./list.applescript > "~/Library/Script Libraries/list.scpt"
```

# Usage

If you've installed the libraries in the `Script Libraries` folder, you can import libraries with the `use` statement.

```applescript
use strlib: script "string"
strlib's format("This is a {} string", "test")
--> This is a test string
```

If the libraries are located elsewhere, use them by using the `load script` statement

```applescript
set strlib to load script file "/path/to/string.scpt"
strlib's format("This is a {} string", "test")
--> This is a test string
```
