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
    let excludedSequencesTypes: Set<SequenceType>
    let excludedCollectionTypes: Set<CollectionType>

    var simpleName: String { name.replacingOccurrences(of: ".", with: "") }

    public init(_ name: String, restrictedTo applicablePlatforms: Set<Platform> = Set(Platform.allCases), excludedSequencesTypes: Set<SequenceType> = [], excludedCollectionTypes: Set<CollectionType> = []) {
        self.name = name
        self.applicablePlatforms = applicablePlatforms
        self.excludedSequencesTypes = excludedSequencesTypes
        self.excludedCollectionTypes = excludedCollectionTypes
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
