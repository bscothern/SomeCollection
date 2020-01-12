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
        
        let expectedOutput = """
        """
    }
}
