//
//  ElementType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public struct ElementType: Hashable {
    var name: String
    var applicablePlatforms: Set<Platform>

    public init(name: String, restrictedTo applicablePlatforms: Set<Platform> = Set(Platform.allCases)) {
        self.name = name
        self.applicablePlatforms = applicablePlatforms
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