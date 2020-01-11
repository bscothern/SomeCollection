//
//  CollectionType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct CollectionType: Hashable {
    public enum KeyOrValue {
        case key
        case value
        case both
    }

    @usableFromInline let name: String
    @usableFromInline let keyOrValue: KeyOrValue?
    @usableFromInline let limitedToElementTypes: Set<ElementType>
    @usableFromInline let excludedElementTypes: Set<ElementType>

    @inlinable
    public init(name: String, keyOrValue: KeyOrValue? = nil, limitedTo limitedToElementTypes: Set<ElementType> = [], excluding excludedElementTypes: Set<ElementType> = []) {
        self.name = name
        self.keyOrValue = keyOrValue
        self.limitedToElementTypes = limitedToElementTypes
        self.excludedElementTypes = excludedElementTypes
    }
}

extension CollectionType: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.name < rhs.name
    }
}

extension CollectionType: ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral: String) {
        self.init(name: stringLiteral)
    }
}
