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
                    protocols += "\n#endif"
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
        generateConformances(for: matrix.collectionTypes, isCollectionTypes: true, appendingTo: &conformances)
        generateConformances(for: matrix.sequenceTypes, isCollectionTypes: false, appendingTo: &conformances)

        try conformances.write(toFile: "SomeCollectionConformances.swift", atomically: true, encoding: .utf8)
    }

    private func generateConformances(for set: Set<SequenceType>, isCollectionTypes: Bool, appendingTo conformances: inout String) {
        set.sorted()
            .forEach { sequenceType in
                var added = false
                matrix.elementTypes
                    .sorted()
                    .lazy
                    .filter { sequenceType.limitedToElementTypes.isEmpty || sequenceType.limitedToElementTypes.contains($0) }
                    .filter { !sequenceType.excludedElementTypes.contains($0) }
                    .filter { elementType in
                        // This allows either the SequenceType/CollectionType or the ElementType to be part of the standard library while the other isn't.
                        // If they are both in the standard library only generateAcrossStandardLibrary will allow the code to be generated for this pair.
                        self.generateAcrossStandardLibrary ||
                            !StandardLibraryElementType.values.contains(where: { $0.name == elementType.name }) ||
                            !StandardLibrarySequenceType.values.contains(where: { $0.name == sequenceType.name }) ||
                            !StandardLibraryCollectionType.values.contains(where: { $0.name == sequenceType.name })
                    }
                    .forEach { elementType in
                        added = true

                        let isRestricted = elementType.applicablePlatforms.count != Platform.allCases.count
                        if isRestricted {
                            conformances += "\n#if"
                            elementType.applicablePlatforms
                                .sorted()
                                .forEach { platform in
                                    conformances += " os(\(platform.rawValue))"
                                }
                        }

                        if sequenceType.skipWhereClause {
                            conformances += "\nextension \(sequenceType.name): \(elementType.sequenceName) {}"

                            if isCollectionTypes {
                                conformances += "\nextension \(sequenceType.name): \(elementType.collectionName) {}"
                            }

                            if !sequenceType.skipOptional {
                                conformances += "\nextension \(sequenceType.name): \(elementType.sequenceNameOptional) {}"
                                if isCollectionTypes {
                                    conformances += "\nextension \(sequenceType.name): \(elementType.collectionNameOptional) {}"
                                }
                            }
                        } else {
                            conformances += "\nextension \(sequenceType.name): \(elementType.sequenceName) where \(sequenceType.genericName) == \(elementType.name) {}"
                            if isCollectionTypes {
                                conformances += "\nextension \(sequenceType.name): \(elementType.collectionName) where \(sequenceType.genericName) == \(elementType.name) {}"
                            }

                            if !sequenceType.skipOptional {
                                conformances += "\nextension \(sequenceType.name): \(elementType.sequenceNameOptional) where \(sequenceType.genericName) == \(elementType.name)? {}"
                                if isCollectionTypes {
                                    conformances += "\nextension \(sequenceType.name): \(elementType.collectionNameOptional) where \(sequenceType.genericName) == \(elementType.name)? {}"
                                }
                            }
                        }

                        if isRestricted {
                            conformances += "\n#endif"
                        }
                    }

                if added {
                    conformances += "\n"
                }
            }
    }
}

fileprivate extension ElementType {
    var sequenceName: String { "SequenceOf\(simpleName)" }
    var collectionName: String { "CollectionOf\(simpleName)" }

    var sequenceNameOptional: String { "SequenceOfOptional\(simpleName)" }
    var collectionNameOptional: String { "CollectionOfOptional\(simpleName)" }
}
