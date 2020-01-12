//
//  Version.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

internal struct Version: CustomStringConvertible {
    let major = 1
    let minor = 0
    let patch = 0

    var description: String { "\(major).\(minor).\(patch)" }

    init() {}
}
