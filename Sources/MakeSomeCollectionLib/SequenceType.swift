//
//  CollectionType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

/// A `Sequence` type that should have conformances generated for it.
///
/// Comparisons in `Generator` only check name.
/// But other settings are respected.
public struct SequenceType: Hashable {
    let name: String
    let applicablePlatforms: Set<Platform>
    let limitedToElementTypes: Set<ElementType>
    let excludedElementTypes: Set<ElementType>
    let skipWhereClause: Bool
    let skipOptional: Bool
    let genericName: String
    let isLazy: Bool

    /// Creates a `SeqeunceType` instance.
    ///
    /// - Important: Comparisons in Generator only check name.
    ///     But other settings are respected.
    ///
    /// - Parameters:
    ///   - name: The name of the `Seqeunce` type to have conformances added to it.
    ///   - applicablePlatforms: The `Platforms` where the `Sequence` type is supported.
    ///       When this Set contains a limited set of supported platforms those are put into a `#if` check.
    ///       If this is empty then the type will not be used.
    ///   - limitedToElementTypes: A set of `ElementType` that are supported by this type.
    ///       A custom `ElementType` can add itself to this list by inserting itself into its `includedSequenceTypes` property.
    ///   - excludedElementTypes: A set of `ElementType` to explicitly ignore.
    ///       It is often better to use `limitedToElementTypes` if there are additional restrictions of the `Element` type of the `Sequence`
    ///   - skipWhereClause: When `true` no `where Element == ...` clauses will be added when conforming this type to protocols.
    ///   - skipOptional: When `true` conformances for `Optional<...>` as the `Element` type will not be added.
    ///   - genericName: When specified this will be used instead of `Element` as the name of the assoicatedtype of the `where` clause.
    ///   - isLazy: Can be used to explicitly mark the `Sequence` as lazy or not.
    ///       If it is not specified by providing `nil` then this property is synthesized as the value of `name.contains("Lazy")`
    public init(name: String, restrictedTo applicablePlatforms: Set<Platform> = Set(Platform.allCases), limitedTo limitedToElementTypes: Set<ElementType> = [], excluding excludedElementTypes: Set<ElementType> = [], skipWhereClause: Bool = false, skipOptional: Bool = false, genericName: String = "Element", isLazy: Bool? = nil) {
        self.name = name
        self.applicablePlatforms = applicablePlatforms
        self.limitedToElementTypes = limitedToElementTypes
        self.excludedElementTypes = excludedElementTypes
        self.skipWhereClause = skipWhereClause
        self.skipOptional = skipOptional
        self.genericName = genericName
        self.isLazy = isLazy ?? name.contains("Lazy")
    }
}

extension SequenceType: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.name < rhs.name
    }
}

extension SequenceType: ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral: String) {
        self.init(name: stringLiteral)
    }
}
