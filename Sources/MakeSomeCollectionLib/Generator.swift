//
//  Generator.swift
//  SomeCollection
//
//  Created by Braden Scothern on 1/10/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import Foundation

/// Parses a `GernaratorMatrix` to generate protocol definitions and conformances.
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
    
    /// Create a `Generator`.
    ///
    /// - Parameter matrix: The matrix of `Seqeunce`, `Collection`, and `Element` types to use.
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
    
    /// Run the generator.
    ///
    /// - Parameters:
    ///   - name: The name to put at the start of the two files generated.
    ///       "\(name)Conformances.swift" and "\(name)Protocols.swift" will be the files created at `outputPath`.
    ///   - outputPath: The path to where output files should be created.
    ///   - imports: Any imports that should be put at the top of the generated files.
    public func generate(name: String, into outputPath: String, imports: [String]) throws {
        let fileManager = FileManager.default
        let originalDirectory = fileManager.currentDirectoryPath
        defer { fileManager.changeCurrentDirectoryPath(originalDirectory) }
        guard let sourceRoot = fileManager.currentDirectoryPath.components(separatedBy: ".build/").first,
            !sourceRoot.isEmpty,
            fileManager.changeCurrentDirectoryPath(sourceRoot) else {
                throw Error.unableToFindPacakgeRoot
        }
        guard fileManager.changeCurrentDirectoryPath(outputPath) else {
            throw Error.unableToFindTargetOutputDirectory
        }

        try writeProtocols(name: name, imports: imports)
        try writeConformances(name: name, imports: imports)
    }

    private func writeProtocols(name: String, imports: [String]) throws {
        var protocols = """
        //
        // \(name)Protocols.swift
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
        
        matrix.elementTypes.lazy
            .filter { !$0.applicablePlatforms.isEmpty }
            .filter { elementType in
                self.generateAcrossStandardLibrary || !StandardLibraryElementType.values.contains(where: { $0.name == elementType.name })
            }
            .forEach { elementType in
                protocols += "\n"
                let isRestricted = elementType.applicablePlatforms.count != Platform.allCases.count
                if isRestricted {
                    protocols += "#if"
                    let platforms = elementType.applicablePlatforms.sorted()
                    protocols += " os(\(platforms.first!.rawValue))"

                    platforms
                        .dropFirst()
                        .forEach { platform in
                            protocols += " || os(\(platform.rawValue))"
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

        try protocols.write(toFile: "\(name)Protocols.swift", atomically: true, encoding: .utf8)
    }

    private func writeConformances(name: String, imports: [String]) throws {
        var conformances = """
        //
        // \(name)Conformances.swift
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

        try conformances.write(toFile: "\(name)Conformances.swift", atomically: true, encoding: .utf8)
    }

    private func generateConformances(for sequenceTypes: [SequenceType], isCollectionTypes: Bool, appendingTo conformances: inout String) {
        sequenceTypes
            .forEach { sequenceType in
                var added = false
                matrix.elementTypes
                    .lazy
                    .filter { !$0.applicablePlatforms.isEmpty }
                    .filter { elementType in
                        // Limited To / Included Overrides
                        sequenceType.limitedToElementTypes.isEmpty || sequenceType.limitedToElementTypes.contains { $0.name == elementType.name } || (isCollectionTypes ? elementType.includedCollectionTypes : elementType.includedSequenceTypes).contains { $0.name == sequenceType.name }
                    }
                    .filter { elementType in
                        // Excluded By SequenceType
                        !sequenceType.excludedElementTypes.contains { $0.name == elementType.name }
                    }
                    .filter { elementType in
                        // Excluded By ElementType
                        !(isCollectionTypes ? elementType.excludedCollectionTypes : elementType.excludedSequenceTypes)
                            .contains { invalidSequenceType in
                                invalidSequenceType.name == sequenceType.name
                            }
                    }
                    .filter { elementType in
                        // This allows either the SequenceType/CollectionType or the ElementType to be part of the standard library while the other isn't.
                        // If they are both in the standard library only generateAcrossStandardLibrary will allow the code to be generated for this pair.
                        self.generateAcrossStandardLibrary ||
                            !StandardLibraryElementType.values.contains(where: { $0.name == elementType.name }) ||
                            (!isCollectionTypes && !StandardLibrarySequenceType.values.contains(where: { $0.name == sequenceType.name })) ||
                            (isCollectionTypes && !StandardLibraryCollectionType.values.contains(where: { $0.name == sequenceType.name }))
                    }
                    .forEach { elementType in
                        added = true

                        let isRestricted = sequenceType.applicablePlatforms.count != Platform.allCases.count || elementType.applicablePlatforms.count != Platform.allCases.count
                        if isRestricted {
                            let platforms = sequenceType.applicablePlatforms.intersection(elementType.applicablePlatforms).sorted()
                            conformances += "\n#if"
                            conformances += " os(\(platforms.first!.rawValue))"

                            platforms
                                .dropFirst()
                                .forEach { platform in
                                    conformances += " || os(\(platform.rawValue))"
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
