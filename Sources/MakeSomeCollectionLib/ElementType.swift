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
    let skipWhereClause: Bool
    let skipOptional: Bool

    public init(name: String, restrictedTo applicablePlatforms: Set<Platform> = Set(Platform.allCases), skipWhereClause: Bool = false, skipOptional: Bool = false) {
        self.name = name
        self.applicablePlatforms = applicablePlatforms
        self.skipWhereClause = skipWhereClause
        self.skipOptional = skipOptional
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
