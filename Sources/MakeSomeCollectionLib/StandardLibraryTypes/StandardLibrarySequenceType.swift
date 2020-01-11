//
//  StandardLibrarySequenceType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public enum StandardLibrarySequenceType {
    public static let values: Set<SequenceType> = {
        let sequenceTypes: Set<SequenceType> = [
            // Sequence Types
            "AnyIterator",
            "AnySequence",
//            "ClosedRange",
//            .init(name: "Dictionary", keyOrValue: .both),
            "DropFirstSequence",
            "DropWhileSequence",
            "EmptyCollection",
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
//            "PartialRangeFrom",
            "PrefixSequence",
//            "Range",
            "ReversedCollection",
            "ReversedCollection.Iterator",
//            "StrideThrough",
//            "StrideTo",
            "UnfoldSequence",
            "UnsafeBufferPointer",
            "UnsafeMutableBufferPointer",
            .init(name: "UnsafeMutableRawBufferPointer", limitedTo: [.init(name: "UInt8", skipWhereClause: true, skipOptional: true)]),
            .init(name: "UnsafeMutableRawBufferPointer.Iterator", limitedTo: [.init(name: "UInt8", skipWhereClause: true, skipOptional: true)]),
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
