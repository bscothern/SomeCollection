//
//  StandardLibraryCollectionType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public enum StandardLibraryCollectionType {
    /// All the genericName Standard Library Collection Types and their restrictions within the standard library to conform to SequenceOf/CollectionOf protocols.
    ///
    /// - Note: `CollectionDifference` is not genericName.
    public static let values: Set<CollectionType> = [
        // Collection Types
        "AnyCollection",
        .init(
            "ClosedRange",
            limitedTo: ["Int8", "Int16", "Int32", "Int64", "Int", "UInt8", "UInt16", "UInt32", "UInt64", "UInt"],
            skipOptional: true,
            genericName: "Bound"
        ),
        .init(
            "DefaultIndices",
            limitedTo: StandardLibraryElementType.values.subtracting(["Bool", "Error"]),
            skipOptional: true
        ),
//        "Dictionary"
        .init(
            "Dictionary.Keys",
            limitedTo: StandardLibraryElementType.values.subtracting(["Error"])
        ),
        .init(
            "Set",
            limitedTo: StandardLibraryElementType.values.subtracting(["Error"])
        ),
        "Slice",

        // BidirectionalCollection Types
        "AnyBidirectionalCollection",
        "ReversedCollection",
        .init(
            "String",
            limitedTo: ["Character"],
            skipWhereClause: true,
            skipOptional: true
        ),
        .init(
            "String.UnicodeScalarView",
            limitedTo: ["Unicode.Scalar"],
            skipWhereClause: true,
            skipOptional: true
        ),
        .init(
            "String.UTF16View",
            limitedTo: ["UTF16.CodeUnit"],
            skipWhereClause: true,
            skipOptional: true
        ),
        .init(
            "String.UTF8View",
            limitedTo: ["UTF8.CodeUnit"],
            skipWhereClause: true,
            skipOptional: true
        ),
        .init(
            "Substring.UnicodeScalarView",
            limitedTo: ["Unicode.Scalar"],
            skipWhereClause: true,
            skipOptional: true
        ),
        .init(
            "Substring.UTF16View",
            limitedTo: ["String.UTF16View.Element"],
            skipWhereClause: true,
            skipOptional: true
        ),
        .init(
            "Substring.UTF8View",
            limitedTo: ["String.UTF8View.Element"],
            skipWhereClause: true,
            skipOptional: true
        ),

        // MutableCollection Type
        "Array",
        "ArraySlice",
        "CollectionOfOne",
        "ContiguousArray",
        "Dictionary.Values",
        "EmptyCollection",
        "UnsafeMutableBufferPointer",
        .init(
            "UnsafeMutableRawBufferPointer",
            limitedTo: ["UInt8"],
            skipWhereClause: true,
            skipOptional: true
        ),

        // RangeReplaceableCollection Type
//        Array is defined above
//        ArraySlice is defined above
//        ContiguousArray is defined above
//        String is defined above
//        String.UnicodeScalarView is defined above
//        Substring is defined above
//        Substring.UnicodeScalarView is defined above
    ]
}
