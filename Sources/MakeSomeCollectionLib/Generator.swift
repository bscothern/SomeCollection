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
    public func generate(into outputPath: String, imports: [String] = []) throws {
        let fileManager = FileManager.default
        guard let sourceRoot = fileManager.currentDirectoryPath.components(separatedBy: ".build/").first,
            !sourceRoot.isEmpty,
            fileManager.changeCurrentDirectoryPath(sourceRoot) else {
                throw Error.unableToFindPacakgeRoot
        }
        guard fileManager.changeCurrentDirectoryPath(outputPath) else {
            throw Error.unableToFindTargetOutputDirectory
        }

        try writeProtocols(imports: imports)
        try writeConformances(imports: imports)
    }

    private func writeProtocols(imports: [String]) throws {
        var protocols = """
        //
        // SomeCollectionProtocols.swift
        //
        // Auto Generated
        // MakeSomeCollectionLib \(Version())
        // \(date)
        //
        """
        
        if !generateAcrossStandardLibrary {
            protocols += "\nimport SomeCollection"
        }
        imports.forEach { `import` in
            protocols += "\nimport \(`import`)"
        }
        if !generateAcrossStandardLibrary || !imports.isEmpty {
            protocols += "\n"
        }
        
        matrix.elementTypes.forEach { elementType in
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
            public protocol Lazy\(elementType.sequenceName): LazySequenceProtocol, \(elementType.sequenceName) {}
            public protocol Lazy\(elementType.collectionName): LazyCollectionProtocol, \(elementType.collectionName) {}
            public protocol Lazy\(elementType.sequenceNameOptional): LazySequenceProtocol, \(elementType.sequenceNameOptional) {}
            public protocol Lazy\(elementType.collectionNameOptional): LazyCollectionProtocol, \(elementType.collectionNameOptional) {}
            """
            
            if isRestricted {
                protocols += "\n#endif"
            }
            protocols += "\n"
        }

        try protocols.write(toFile: "SomeCollectionProtocols.swift", atomically: true, encoding: .utf8)
    }

    private func writeConformances(imports: [String]) throws {
        var conformances = """
        //
        // SomeCollectionConformances.swift
        //
        // Auto Generated
        // MakeSomeCollectionLib \(Version())
        // \(date)
        //
        """
        
        if !generateAcrossStandardLibrary {
            conformances += "\nimport SomeCollection"
        }
        imports.forEach { `import` in
            conformances += "\nimport \(`import`)"
        }
        if !generateAcrossStandardLibrary || !imports.isEmpty {
            conformances += "\n"
        }

        generateConformances(for: matrix.collectionTypes, isCollectionTypes: true, appendingTo: &conformances)
        generateConformances(for: matrix.sequenceTypes, isCollectionTypes: false, appendingTo: &conformances)

        try conformances.write(toFile: "SomeCollectionConformances.swift", atomically: true, encoding: .utf8)
    }

    private func generateConformances(for sequenceTypes: [SequenceType], isCollectionTypes: Bool, appendingTo conformances: inout String) {
        sequenceTypes
            .forEach { sequenceType in
                var added = false
                matrix.elementTypes
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
                        
                        var conformancesToApply: [String] = []
                        var whereClause: String {
                            sequenceType.skipWhereClause ? "" : " where \(sequenceType.genericName) == \(elementType.name)"
                        }

                        conformancesToApply.append("\(elementType.sequenceName)\(whereClause)")
                        if isCollectionTypes {
                            conformancesToApply.append("\(elementType.collectionName)\(whereClause)")
                        }

                        if !sequenceType.skipOptional {
                            conformancesToApply.append("\(elementType.sequenceNameOptional)\(whereClause)?")
                            if isCollectionTypes {
                                conformancesToApply.append("\(elementType.collectionNameOptional)\(whereClause)?")
                            }
                        }

                        if sequenceType.isLazy {
                            conformancesToApply.append("\(elementType.lazySequenceName)\(whereClause)")
                            if isCollectionTypes {
                                conformancesToApply.append("\(elementType.lazyCollectionName)\(whereClause)")
                            }

                            if !sequenceType.skipOptional {
                                conformancesToApply.append("\(elementType.lazySequenceNameOptional)\(whereClause)?")
                                if isCollectionTypes {
                                    conformancesToApply.append("\(elementType.lazyCollectionNameOptional)\(whereClause)?")
                                }
                            }
                        }

                        conformancesToApply.forEach {
                            conformances += "\nextension \(sequenceType.name): \($0) {}"
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
    
    var lazySequenceName: String { "Lazy\(sequenceName)" }
    var lazyCollectionName: String { "Lazy\(collectionName)" }

    var lazySequenceNameOptional: String { "Lazy\(sequenceNameOptional)" }
    var lazyCollectionNameOptional: String { "Lazy\(collectionNameOptional)" }
}
