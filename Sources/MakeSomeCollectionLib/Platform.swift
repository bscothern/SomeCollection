//
//  Platform.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

/// Describes the platforms supported by Swift for use in `#if os(...)` compiler directives.
public enum Platform: String, CaseIterable {
    case macOS
    case iOS
    case tvOS
    case watchOS
    case linux = "Linux"
}

extension Platform: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
