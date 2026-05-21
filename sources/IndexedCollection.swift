//
//  DoccIssue
//


nonisolated
public struct IndexedCollection: Collection {

    public typealias Index = Int
    let fixed: [String] = ["one", "two", "three"]

    public var startIndex: Index { fixed.startIndex }
    public var endIndex: Index { fixed.endIndex }

    public func index(after i: Index) -> Index {
        fixed.index(after: i)
    }

    public subscript(position: Index) -> String {
        return fixed[position]
    }

}


extension IndexedCollection: BidirectionalCollection {

    public func index(before i: Index) -> Index {
        fixed.index(before: i)
    }

}


extension IndexedCollection: RandomAccessCollection {}
