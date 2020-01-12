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

        "UInt8",
        "UInt16",
        "UInt32",
        "UInt64",
        "UInt",

        "Float",
        "Double",
        .init(
            "Float80",
            restrictedTo: [.macOS]
        ),

        "Bool",

        "Error",

        "String",
        "Substring",
        "Character",
        "Unicode.Scalar",
        "UTF16.CodeUnit",
        "UTF8.CodeUnit",
        "String.UTF16View.Element",
    ]
}
