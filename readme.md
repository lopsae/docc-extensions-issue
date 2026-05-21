Docc-Extensions-Issue
=====================

This repository is an example of an issue found with `docc` and `swift-docc-plugin` that occurs
when a packaged type (in this repository, `FixedCollection`) implements a standard library protocol 
(`BidirectionalCollection`), and the package also offers an extension to the same type with public 
members (`BidirectionalCollection/finalIndex`).

In this situation, the produced Docc documentation for `FixedCollection` will contain two links to
`BidirectionalCollection` implementations, and the content of both those links changes randomly when
building:
+ Either it contains the package extension members (`finalIndex`)
+ Or it contains the original `BidirectionalCollection` members.



How to reproduce
----------------

Check out this repository, in the root folder start the documentation server for the included
documentation:
```zsh
./scripts/documentation-server
```

Navigate to http://localhost:8000/docs/documentation/doccextensionsissue/
+ Notice there are two links to `BidirectionalCollection Implementations`
+ Both open http://localhost:8000/docs/documentation/doccextensionsissue/fixedcollection/bidirectionalcollection-implementations
+ `BidirectionalCollection` page contains documentation for `finalIndex`


Rebuild the documentation, the `generate-static-docs` will run `generate-documentation` and also
prettify all json files to minimize the amount of changes:
```zsh
./scripts/generate-static-docs
```

> Note: Since this issue happens randomly, but frequently, the command may need to run a couple of 
> times.

Notice that some files changed upon rebuild:
+ Notice `bidirectionalcollection-implementations.json` and `index.json` have changed content.
+ The page for `FixedCollection` does not change, still containing two 
  `BidirectionalCollection Implementations` links that open the same page.
+ Open http://localhost:8000/docs/documentation/doccextensionsissue/fixedcollection/bidirectionalcollection-implementations
+ Notice it now contains documentation for the original `BidirectionalCollection`, like `last` or 
  `reversed`


Upon rebuilding documentation with `generate-static-docs`, the content will randomly change between
the committed state (no changes), or the original `BidirectionalCollection` members state.



Workaround
----------

Using the `--experimental-skip-synthesized-symbols` flag for `generate-documentation` partially
solves the issue since the original `BidirectionalCollection` members are not included. The single 
`BidirectionalCollection Implementations` link in `FixedCollection` now always contains the package
members.



`swift-docc-plugin` version
---------------------------

Testing of this issue was done using `swift-docc-plugin` at version `1.5.0`.

Issue was reproduced on `main` (`647c708`) as of May 21th, 2026.



Other Observations
------------------

### Removing extensions

If the extension to `BidirectionalCollection` is removed from the code, the issue stops happening:
+ `FixedCollection` page will contain a single link to `BidirectionalCollection` that always points
  to the same content.

If the `--exclude-extended-types` flag for `generate-documentation` is used, the generated site
seems to stabilize (it does not change without code changes), since the documentation for the
`BidirectionalCollection` is not included.



### Using `generate-documentation` directly

This issue is also reproducible by running directly `generate-documentation`:
```zsh
swift package --allow-writing-to-directory ./docs \
    generate-documentation --target "DoccExtensionsIssue" \
    --disable-indexing \
    --transform-for-static-hosting \
    --hosting-base-path "/docs" \
    --output-path ./docs
```

However this will modify a lot of files, making the change hard to discern. The behavior of 
`BidirectionalCollection` flipping between two states still remains.



### Removing ` .build`

The issue still happens even if removing `.build` before rebuilding the documentation.



### Building documentation in Xcode

Part of this issue can be also seen when running `Build Documentation` in Xcode:
+ The `FixedCollection` will contain two links to `BidirectionalCollection Implementations` both
  pointing to the same content.
+ The links seems to consistently always contain the original `BidirectionalCollection` members.
