//
//  StandardLibrarySequenceType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public enum StandardLibrarySequenceType {
    /// All the generic Sequence types in the standard library.
    public static let values: Set<SequenceType> = {
        let sequenceTypes: Set<SequenceType> = [
            // Sequence Types
            "AnyIterator",
            "AnySequence",
            "DropFirstSequence",
            "DropWhileSequence",
            "EmptyCollection.Iterator",
//            "EnumeratedSequence",
//            "EnumeratedSequence.Iterator",
            "FlattenSequence",
            "FlattenSequence.Iterator",
            "IndexingIterator",
            "JoinedSequence",
            "LazyDropWhileSequence",
            "LazyFilterSequence",
            "LazyFilterSequence.Iterator",
            "LazyMapSequence.Iterator",
            "LazyPrefixWhileSequence",
            "LazyPrefixWhileSequence.Iterator",
            "LazySequence",
            .init(name: "PartialRangeFrom", limitedTo: ["Int8", "Int16", "Int32", "Int64", "Int", "UInt8", "UInt16", "UInt32", "UInt64", "UInt"], skipOptional: true, generic: "Bound"),
            "PrefixSequence",
            .init(name: "Range", limitedTo: ["Int8", "Int16", "Int32", "Int64", "Int", "UInt8", "UInt16", "UInt32", "UInt64", "UInt"], skipOptional: true, generic: "Bound"),
            "ReversedCollection.Iterator",
            .init(name: "StrideThrough", excluding: ["Bool", "Error", "String", "Substring"], skipOptional: true),
            .init(name: "StrideTo", excluding: ["Bool", "Error", "String", "Substring"], skipOptional: true),
            "UnfoldSequence",
            "UnsafeBufferPointer",
            .init(name: "UnsafeMutableRawBufferPointer.Iterator", limitedTo: ["UInt8"], skipWhereClause: true, skipOptional: true),
//            "Zip2Sequence",

            // LazySequenceProtocol Types
            "LazyDropWhileSequence",
            "LazyFilterSequence",
            "LazyMapSequence",
            "LazyPrefixWhileSequence",
            "LazySequence",
        ]
        return sequenceTypes.filter { sequenceType in
            StandardLibraryCollectionType.values.contains { $0.name != sequenceType.name }
        }
    }()
}
