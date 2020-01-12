//
//  ElementType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

/// A `Sequence`/`Collection` `Element` type to add protocol conformance for.
///
/// Comparisons in `Generator` only check name.
/// But other settings are respected.
public struct ElementType: Hashable {
    let name: String
    let applicablePlatforms: Set<Platform>
    let excludedSequenceTypes: Set<SequenceType>
    let excludedCollectionTypes: Set<CollectionType>
    let includedSequenceTypes: Set<SequenceType>
    let includedCollectionTypes: Set<CollectionType>

    var simpleName: String { name.replacingOccurrences(of: ".", with: "") }

    /// Creates an `ElementType`.
    ///
    /// - Parameters:
    ///   - name: The name of the `Element` type.
    ///   - applicablePlatforms: The `Platforms` where the `Element` type is supported.
    ///       When this Set contains a limited set of supported platforms those are put into a `#if` check.
    ///       If this is empty then the type will not be used.
    ///   - excludedSequenceTypes: A set of `Sequence` types that don't support this type.
    ///   - excludedCollectionTypes: A set of `Collection` types that don't support this type.
    ///   - includedSequenceTypes: A set of `Sequence` types that should act as if they support this type is part of its `limitedToElementTypes` property.
    ///   - includedCollectionTypes: A set of `Collection` types that should act as if they support this type is part of its `limitedToElementTypes` property.
    public init(name: String, restrictedTo applicablePlatforms: Set<Platform> = Set(Platform.allCases), excludedSequenceTypes: Set<SequenceType> = [], excludedCollectionTypes: Set<CollectionType> = [], includedSequenceTypes: Set<SequenceType> = [], includedCollectionTypes: Set<CollectionType> = []) {
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
        self.init(name: stringLiteral)
    }
}
