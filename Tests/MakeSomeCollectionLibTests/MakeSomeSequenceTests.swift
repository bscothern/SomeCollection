import Foundation
import MakeSomeCollectionLib
import XCTest

final class MakeSomeCollectionLibTests: XCTestCase {
    func testExample() throws {
        let fileManager = FileManager.default
        let originalDirectory = fileManager.currentDirectoryPath
        defer { fileManager.changeCurrentDirectoryPath(originalDirectory) }
        guard let sourceRoot = fileManager.currentDirectoryPath.components(separatedBy: ".build/").first,
            !sourceRoot.isEmpty,
            fileManager.changeCurrentDirectoryPath(sourceRoot) else {
                throw Generator.Error.unableToFindPacakgeRoot
        }
        
        let sequences: Set<SequenceType> = [
            "TestSequence"
        ]
        
        let collections: Set<CollectionType> = [
            "TestCollection"
        ]
        
        let elements: Set<ElementType> = [
            "TestElement"
        ]
        
        let matrix = GenerationMatrix(
            sequenceTypes: sequences.union(StandardLibrarySequenceType.values),
            collectionTypes: collections.union(StandardLibraryCollectionType.values),
            elementTypes: elements.union(StandardLibraryElementType.values)
        )
        
        let generator = Generator(matrix: matrix)
        do {
            try generator.generate(
                name: "TEST",
                into: "Tests/OUTPUT",
                imports: ["TestImport"]
            )
        } catch {
            XCTFail("Generator Error: \(error)")
        }
        
        var protocolsOutput = try! String(contentsOfFile: "Tests/OUTPUT/TESTProtocols.swift")
        protocolsOutput = protocolsOutput.components(separatedBy: "import SomeCollection").last!
        
        zip(expectedProtocols.split(separator: "\n", omittingEmptySubsequences: true), protocolsOutput.split(separator: "\n", omittingEmptySubsequences: true)).forEach { expected, result in
            XCTAssertEqual(expected, result)
        }
    }
    
    let expectedProtocols = """
    import TestImport

    public protocol SequenceOfTestElement: Sequence where Element == TestElement {}
    public protocol CollectionOfTestElement: Collection, SequenceOfTestElement {}
    public protocol SequenceOfOptionalTestElement: Sequence where Element == TestElement? {}
    public protocol CollectionOfOptionalTestElement: Collection, SequenceOfOptionalTestElement {}
    public protocol LazySequenceOfTestElement: LazySequenceProtocol, SequenceOfTestElement {}
    public protocol LazyCollectionOfTestElement: LazyCollectionProtocol, CollectionOfTestElement {}
    public protocol LazySequenceOfOptionalTestElement: LazySequenceProtocol, SequenceOfOptionalTestElement {}
    public protocol LazyCollectionOfOptionalTestElement: LazyCollectionProtocol, CollectionOfOptionalTestElement {}
    """
    
    let expectedConformances = """
    """
}
