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

        try writeProtocols()
        try writeConformances()
    }

    public func writeProtocols() throws {
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
                guard generateAcrossStandardLibrary || !StandardLibraryElementType.values.contains(where: { $0.name == elementType.name })  else {
                    return
                }

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
                public protocol \(elementType.sequenceNameOptional): Sequence where Element == \(elementType.name)? {}
                public protocol \(elementType.collectionNameOptional): Collection, \(elementType.sequenceNameOptional) {}
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

    public func writeConformances() throws {
        var conformances = """
        //
        // SomeCollectionConformances.swift
        //
        // Auto Generated
        // MakeSomeCollectionLib \(Version())
        // \(date)
        //

        """

        var seen: Set<String> = []
        matrix.collectionTypes
            .sorted()
            .forEach { collectionType in
                seen.insert(collectionType.name)

                var added = false
                matrix.elementTypes
                    .sorted().lazy
                    .filter { collectionType.limitedToElementTypes.isEmpty || collectionType.limitedToElementTypes.contains($0) }
                    .filter { !collectionType.excludedElementTypes.contains($0) }
                    .filter { elementType in
                        // This allows either the CollectionType or the ElementType to be part of the standard library while the other isn't.
                        // If they are both in the standard library only generateAcrossStandardLibrary will allow the code to be generated for this pair.
                        self.generateAcrossStandardLibrary || !StandardLibraryElementType.values.contains(where: { $0.name == elementType.name }) || !StandardLibraryCollectionType.values.contains(where: { $0.name == collectionType.name })
                    }
                    .forEach { elementType in
                        added = true

                        if elementType.skipWhereClause {
                            conformances += """

                            extension \(collectionType.name): \(elementType.sequenceName) {}
                            extension \(collectionType.name): \(elementType.collectionName) {}
                            """

                            if !elementType.skipOptional {
                                conformances += """

                                extension \(collectionType.name): \(elementType.sequenceNameOptional) {}
                                extension \(collectionType.name): \(elementType.collectionNameOptional) {}
                                """
                            }
                        } else {
                            conformances += """

                            extension \(collectionType.name): \(elementType.sequenceName) where Element == \(elementType.name) {}
                            extension \(collectionType.name): \(elementType.collectionName) where Element == \(elementType.name) {}
                            """

                            if !elementType.skipOptional {
                                conformances += """
                                
                                extension \(collectionType.name): \(elementType.sequenceNameOptional) where Element == \(elementType.name)? {}
                                extension \(collectionType.name): \(elementType.collectionNameOptional) where Element == \(elementType.name)? {}
                                """
                            }
                        }
                    }

                if added {
                    conformances += "\n"
                }
            }

        try conformances.write(toFile: "SomeCollectionConformances.swift", atomically: true, encoding: .utf8)
    }
}

fileprivate extension ElementType {
    var sequenceName: String { "SequenceOf\(name)" }
    var collectionName: String { "CollectionOf\(name)" }

    var sequenceNameOptional: String { "SequenceOfOptional\(name)" }
    var collectionNameOptional: String { "CollectionOfOptional\(name)" }
}
