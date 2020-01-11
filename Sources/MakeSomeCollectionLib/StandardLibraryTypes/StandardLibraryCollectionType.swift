//
//  StandardLibraryCollectionType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public enum StandardLibraryCollectionType {
    
    /// All the Generic Standard Library Collection Types and their restrictions within the standard library to conform to SequenceOf/CollectionOf protocols.
    ///
    /// - Note: `CollectionDifference` is not generic.
    public static let values: Set<CollectionType> = [
        // Collection Types
        "AnyCollection",
        .init(name: "ClosedRange", limitedTo: ["Int8", "Int16", "Int32", "Int64", "Int", "UInt8", "UInt16", "UInt32", "UInt64", "UInt"], skipOptional: true, generic: "Bound"),
        .init(name: "DefaultIndices", excluding: ["Bool", "Error"], skipOptional: true),
//        .init(name: "Dictionary", keyOrValue: .both),
//        .init(name: "Dictionary.Keys", keyOrValue: .key),
        .init(name: "Set", excluding: ["Error"]),
        "Slice",
        
        // BidirectionalCollection Types
        "AnyBidirectionalCollection",
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
        .init(name: "Dictionary.Values", keyOrValue: .value),
        "EmptyCollection",
        "UnsafeMutableBufferPointer",
        .init(name: "UnsafeMutableRawBufferPointer", limitedTo: ["UInt8"], skipWhereClause: true, skipOptional: true),

        // RangeReplaceableCollection Type
        "Array",
        "ArraySlice",
        "ContiguousArray",
        .init(name: "String", limitedTo: ["Character"]),
        .init(name:"String.UnicodeScalarView", limitedTo: ["Unicode.Scalar"]),
        .init(name: "Substring", limitedTo: ["Character"]),
        .init(name: "Substring.UnicodeScalarView", limitedTo: ["String.UnicodeScalarView.Element"]),
    ]
}
