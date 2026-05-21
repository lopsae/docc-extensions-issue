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
