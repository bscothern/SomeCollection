//
//  CollectionType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct SequenceType: Hashable {
    @usableFromInline let name: String
    @usableFromInline let limitedToElementTypes: Set<ElementType>
    @usableFromInline let excludedElementTypes: Set<ElementType>
    @usableFromInline let skipWhereClause: Bool
    @usableFromInline let skipOptional: Bool
    @usableFromInline let genericName: String
    @usableFromInline let isLazy: Bool

    @inlinable
    public init(_ name: String, limitedTo limitedToElementTypes: Set<ElementType> = [], excluding excludedElementTypes: Set<ElementType> = [], skipWhereClause: Bool = false, skipOptional: Bool = false, genericName: String = "Element", isLazy: Bool? = nil) {
        self.name = name
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
        self.init(stringLiteral)
    }
}
