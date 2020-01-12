//
//  ElementType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct ElementType: Hashable {
    let name: String
    let applicablePlatforms: Set<Platform>
    let excludedSequenceTypes: Set<SequenceType>
    let excludedCollectionTypes: Set<CollectionType>
    let includedSequenceTypes: Set<SequenceType>
    let includedCollectionTypes: Set<CollectionType>

    var simpleName: String { name.replacingOccurrences(of: ".", with: "") }

    public init(_ name: String, restrictedTo applicablePlatforms: Set<Platform> = Set(Platform.allCases), excludedSequenceTypes: Set<SequenceType> = [], excludedCollectionTypes: Set<CollectionType> = [], includedSequenceTypes: Set<SequenceType> = [], includedCollectionTypes: Set<CollectionType> = []) {
        self.name = name
        self.applicablePlatforms = applicablePlatforms
        self.excludedSequenceTypes = excludedSequenceTypes
        self.excludedCollectionTypes = excludedCollectionTypes
        self.includedSequenceTypes = includedSequenceTypes
        self.includedCollectionTypes = includedCollectionTypes
    }
}

extension ElementType: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.name < rhs.name
    }
}

extension ElementType: ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral: String) {
        self.init(stringLiteral)
    }
}
