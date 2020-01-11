//
//  Generator.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import Foundation

public struct Generator {
    // MARK: - Types
    public enum Error: Swift.Error {
        case unableToFindPacakgeRoot
        case unableToFindTargetOutputDirectory
    }

    // MARK: - Properties
    let matrix: GenerationMatrix
    let generateAcrossStandardLibrary: Bool

    var date: String { String(Date().description.split(separator: " ").first!) }

    // MARK: - Init
    public init(matrix: GenerationMatrix) {
        self.init(matrix: matrix, generateAcrossStandardLibrary: false)
    }

    private init(matrix: GenerationMatrix, generateAcrossStandardLibrary: Bool) {
        self.matrix = matrix
        self.generateAcrossStandardLibrary = generateAcrossStandardLibrary
    }

    // MARK: - Funcs
    // MARK: Public Static
    public static func _forStandardLibrary() -> Self {
        let matrix = GenerationMatrix(
            sequenceTypes: StandardLibrarySequenceType.values,
            collectionTypes: StandardLibraryCollectionType.values,
            elementTypes: StandardLibraryElementType.values
        )
        return .init(matrix: matrix, generateAcrossStandardLibrary: true)
    }

    // MARK: Public
    public func generate(into outputPath: String) throws {
        let fileManager = FileManager.default
        guard let sourceRoot = fileManager.currentDirectoryPath.components(separatedBy: ".build/").first,
            !sourceRoot.isEmpty,
            fileManager.changeCurrentDirectoryPath(sourceRoot) else {
                throw Error.unableToFindPacakgeRoot
        }
        guard fileManager.changeCurrentDirectoryPath(outputPath) else {
            throw Error.unableToFindTargetOutputDirectory
        }

        try writeBasicProtocols()
    }

    public func writeBasicProtocols() throws {
        var protocols = """
        //
        // SomeCollectionProtocols.swift
        //
        // Auto Generated
        // MakeSomeCollectionLib \(Version())
        // \(date)
        //

        """
        matrix.elementTypes
            .sorted()
            .forEach { elementType in
                protocols += "\n"
                let isRestricted = elementType.applicablePlatforms.count != Platform.allCases.count
                if isRestricted {
                    protocols += "#if"
                    elementType.applicablePlatforms
                        .sorted()
                        .forEach { platform in
                            protocols += " os(\(platform.rawValue))"
                        }
                    protocols += "\n"
                }

                protocols += """
                public protocol \(elementType.sequenceName): Sequence where Element == \(elementType.name) {}
                public protocol \(elementType.collectionName): Collection, \(elementType.sequenceName) {}
                """

                if isRestricted {
                    protocols += """

                    #endif
                    """
                }
                protocols += "\n"
            }

        try protocols.write(toFile: "SomeCollectionProtocols.swift", atomically: true, encoding: .utf8)
    }
}

fileprivate extension ElementType {
    var sequenceName: String { "SequenceOf\(name)" }
    var collectionName: String { "CollectionOf\(name)" }
}
