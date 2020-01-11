//
//  SequenceType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct SequenceType: Hashable {
    public enum KeyOrValue {
        case key
        case value
        case both
    }

    @usableFromInline let name: String
    @usableFromInline let keyOrValue: KeyOrValue?
    @usableFromInline let limitedToElementTypes: Set<ElementType>

    @inlinable
    public init(name: String, keyOrValue: KeyOrValue? = nil, limitedTo limitedToElementTypes: Set<ElementType> = []) {
        self.name = name
        self.keyOrValue = keyOrValue
        self.limitedToElementTypes = limitedToElementTypes
    }
}

extension SequenceType: ExpressibleByStringLiteral {
    @inlinable
    public init(stringLiteral: String) {
        self.init(name: stringLiteral)
    }
}
