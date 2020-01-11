//
//  StandardLibraryElementType.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

public enum StandardLibraryElementType {
    public static let values: Set<ElementType> = [
        "Int8",
        "Int16",
        "Int32",
        "Int64",
        "Int",

        "Float",
        "Double",
        .init(name: "Float80", restrictedTo: [.macOS]),
    ]
}
