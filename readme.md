Docc-Extensions-Issue
=====================

This repository is an example of an issue found with `docc` and `swift-docc-plugin` that occurs
when a packaged type (in this repository, `FixedCollection`) implements a foundational type 
(`BidirectionalCollection`), and the package also offers an extension to the same type with public 
members (`BidirectionalCollection/finalIndex`).

In this situation, the produced Docc documentation for `FixedCollection` will contain two links to
the `BidirectionalCollection`, and the content of both those links changes randomly when building
between the package extension members (`finalIndex`), and the original `BidirectionalCollection`
members.


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

> Note: Since this the issue happens randomly, but frequently, you may need to run this command a couple of times.

Notice that some files changed upon rebuild:
+ Notice `bidirectionalcollection-implementations.json` and `index.json` have changed content.
+ The page for `FixedCollection` does not change, still containing two 
  `BidirectionalCollection Implementations` links that open the same page.
+ Open http://localhost:8000/docs/documentation/doccextensionsissue/fixedcollection/bidirectionalcollection-implementations
+ Notice it now contains documentation for the original `BidirectionalCollection`, like `last` or 
  `reversed`


Upon rebuilding documentation with `generate-static-docs`, the content will randomly change between
the committed state (no changes), or the original `BidirectionalCollection` members state.
