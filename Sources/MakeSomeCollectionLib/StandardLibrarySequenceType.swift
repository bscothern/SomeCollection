//
//  StandardLibrarySequenceType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public enum StandardLibrarySequenceType {
    public static let values: Set<SequenceType> = [
        // Sequence Types
        "AnyIterator",
        "AnySequence",
        "ClosedRange",
        .init(name: "Dictionary", keyOrValue: .both),
        "DropFirstSequence",
        "DropWhileSequence",
        "EmptyCollection",
        "EmptyCollection.Iterator",
        "EnumeratedSequence",
        "EnumeratedSequence.Iterator",
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
        "PartialRangeFrom",
        "PrefixSequence",
        "Range",
        "ReversedCollection",
        "ReversedCollection.Iterator",
        "StrideThrough",
        "StrideTo",
        "UnfoldSequence",
        "UnsafeBufferPointer",
        "UnsafeMutableBufferPointer",
        .init(name: "UnsafeMutableRawBufferPoint", limitedTo: ["UInt8"]),
        .init(name: "UnsafeMutableRawBufferPointer.Iterator", limitedTo: ["UInt8"]),
        "Zip2Sequence",

        // LazySequenceProtocol Types
        "LazyDropWhileSequence",
        "LazyFilterSequence",
        "LazyMapSequence",
        "LazyPrefixWhileSequence",
        "LazySequence",
    ]
}
