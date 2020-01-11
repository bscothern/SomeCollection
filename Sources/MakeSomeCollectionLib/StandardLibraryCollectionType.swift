//
//  StandardLibraryCollectionType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public enum StandardLibraryCollectionType {
    public static let values: Set<CollectionType> = [
        // Collection Types
        "AnyCollection",
        "ClosedRange",
        "CollectionDifference",
//        "DefaultIndices",
        .init(name: "Dictionary", keyOrValue: .both),
        .init(name: "Dictionary.Keys", keyOrValue: .key),
        "Set",
        "Slice",

        // BidirectionalCollection Types
        "AnyBidirectionalCollection",
        .init(name: "IndexSet", limitedTo: ["Int"]),
        "IndexSet.RangeView", // ?
        "ReversedCollection",
        .init(name: "String", limitedTo: ["Character"]),
        .init(name:"String.UnicodeScalarView", limitedTo: ["Unicode.Scalar"]),
        .init(name: "String.UTF16View", limitedTo: ["UTF16.CodeUnit"]),
        .init(name: "String.UTF8View", limitedTo: ["UTF8.CodeUnit"]),
        .init(name: "Substring.UnicodeScalarView", limitedTo: ["Unicode.Scalar"]),
        .init(name: "Substring.UTF16View", limitedTo: ["String.UTF16View.Element"]),
        .init(name: "Substring.UTF8View", limitedTo: ["String.UTF8View.Element"]),

        // MutableCollection Type
        "Array",
        "ArraySlice",
        "CollectionOfOne",
        "ContiguousArray",
        .init(name: "Data", limitedTo: ["UInt8"]),
        .init(name: "Dictionary.Values", keyOrValue: .value),
        "EmptyCollection",
        "IndexPath",
        "UnsafeMutableBufferPointer",
        .init(name: "UnsafeMutableRawBufferPoint", limitedTo: ["UInt8"]),

        // RangeReplaceableCollection Type
        "Array",
        "ArraySlice",
        "ContiguousArray",
        .init(name: "Data", limitedTo: ["UInt8"]),
        .init(name: "String", limitedTo: ["Character"]),
        .init(name:"String.UnicodeScalarView", limitedTo: ["Unicode.Scalar"]),
        .init(name: "Substring", limitedTo: ["Character"]),
        .init(name: "Substring.UnicodeScalarView", limitedTo: ["String.UnicodeScalarView.Element"]),
    ]
}
