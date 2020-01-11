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

    public let name: String
    public let keyOrValue: KeyOrValue?
    public let limitedToElementTypes: Set<ElementType>

    @inlinable
    public init(name: String, keyOrValue: KeyOrValue? = nil, limitedTo limitedToElementTypes: Set<ElementType> = []) {
        self.name = name
        self.keyOrValue = keyOrValue
        self.limitedToElementTypes = limitedToElementTypes
    }
}

extension CollectionType: ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral: String) {
        self.init(name: stringLiteral)
    }
}
