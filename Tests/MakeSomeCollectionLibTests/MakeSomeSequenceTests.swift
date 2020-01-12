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
        
        areTheSame(expectedProtocols, protocolsOutput)
        
        var conformancesOutput = try! String(contentsOfFile: "Tests/OUTPUT/TESTConformances.swift")
        conformancesOutput = conformancesOutput.components(separatedBy: "import SomeCollection").last!
        
        areTheSame(expectedConformances, conformancesOutput)
    }
    
    func areTheSame(_ expected: String, _ result: String) {
        zip(expected.split(separator: "\n", omittingEmptySubsequences: true), result.split(separator: "\n", omittingEmptySubsequences: true)).forEach { expected, result in
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
    import TestImport

    extension AnyBidirectionalCollection: SequenceOfTestElement where Element == TestElement {}
    extension AnyBidirectionalCollection: CollectionOfTestElement where Element == TestElement {}
    extension AnyBidirectionalCollection: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension AnyBidirectionalCollection: CollectionOfOptionalTestElement where Element == TestElement? {}

    extension AnyCollection: SequenceOfTestElement where Element == TestElement {}
    extension AnyCollection: CollectionOfTestElement where Element == TestElement {}
    extension AnyCollection: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension AnyCollection: CollectionOfOptionalTestElement where Element == TestElement? {}

    extension Array: SequenceOfTestElement where Element == TestElement {}
    extension Array: CollectionOfTestElement where Element == TestElement {}
    extension Array: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension Array: CollectionOfOptionalTestElement where Element == TestElement? {}

    extension ArraySlice: SequenceOfTestElement where Element == TestElement {}
    extension ArraySlice: CollectionOfTestElement where Element == TestElement {}
    extension ArraySlice: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension ArraySlice: CollectionOfOptionalTestElement where Element == TestElement? {}

    extension CollectionOfOne: SequenceOfTestElement where Element == TestElement {}
    extension CollectionOfOne: CollectionOfTestElement where Element == TestElement {}
    extension CollectionOfOne: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension CollectionOfOne: CollectionOfOptionalTestElement where Element == TestElement? {}

    extension ContiguousArray: SequenceOfTestElement where Element == TestElement {}
    extension ContiguousArray: CollectionOfTestElement where Element == TestElement {}
    extension ContiguousArray: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension ContiguousArray: CollectionOfOptionalTestElement where Element == TestElement? {}

    extension DefaultIndices: SequenceOfTestElement where Element == TestElement {}
    extension DefaultIndices: CollectionOfTestElement where Element == TestElement {}

    extension Dictionary.Keys: SequenceOfTestElement where Element == TestElement {}
    extension Dictionary.Keys: CollectionOfTestElement where Element == TestElement {}
    extension Dictionary.Keys: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension Dictionary.Keys: CollectionOfOptionalTestElement where Element == TestElement? {}

    extension Dictionary.Values: SequenceOfTestElement where Element == TestElement {}
    extension Dictionary.Values: CollectionOfTestElement where Element == TestElement {}
    extension Dictionary.Values: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension Dictionary.Values: CollectionOfOptionalTestElement where Element == TestElement? {}

    extension EmptyCollection: SequenceOfTestElement where Element == TestElement {}
    extension EmptyCollection: CollectionOfTestElement where Element == TestElement {}
    extension EmptyCollection: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension EmptyCollection: CollectionOfOptionalTestElement where Element == TestElement? {}

    extension ReversedCollection: SequenceOfTestElement where Element == TestElement {}
    extension ReversedCollection: CollectionOfTestElement where Element == TestElement {}
    extension ReversedCollection: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension ReversedCollection: CollectionOfOptionalTestElement where Element == TestElement? {}

    extension Set: SequenceOfTestElement where Element == TestElement {}
    extension Set: CollectionOfTestElement where Element == TestElement {}
    extension Set: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension Set: CollectionOfOptionalTestElement where Element == TestElement? {}

    extension Slice: SequenceOfTestElement where Element == TestElement {}
    extension Slice: CollectionOfTestElement where Element == TestElement {}
    extension Slice: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension Slice: CollectionOfOptionalTestElement where Element == TestElement? {}

    extension TestCollection: SequenceOfBool where Element == Bool {}
    extension TestCollection: CollectionOfBool where Element == Bool {}
    extension TestCollection: SequenceOfOptionalBool where Element == Bool? {}
    extension TestCollection: CollectionOfOptionalBool where Element == Bool? {}
    extension TestCollection: SequenceOfCharacter where Element == Character {}
    extension TestCollection: CollectionOfCharacter where Element == Character {}
    extension TestCollection: SequenceOfOptionalCharacter where Element == Character? {}
    extension TestCollection: CollectionOfOptionalCharacter where Element == Character? {}
    extension TestCollection: SequenceOfDouble where Element == Double {}
    extension TestCollection: CollectionOfDouble where Element == Double {}
    extension TestCollection: SequenceOfOptionalDouble where Element == Double? {}
    extension TestCollection: CollectionOfOptionalDouble where Element == Double? {}
    extension TestCollection: SequenceOfError where Element == Error {}
    extension TestCollection: CollectionOfError where Element == Error {}
    extension TestCollection: SequenceOfOptionalError where Element == Error? {}
    extension TestCollection: CollectionOfOptionalError where Element == Error? {}
    extension TestCollection: SequenceOfFloat where Element == Float {}
    extension TestCollection: CollectionOfFloat where Element == Float {}
    extension TestCollection: SequenceOfOptionalFloat where Element == Float? {}
    extension TestCollection: CollectionOfOptionalFloat where Element == Float? {}
    #if os(macOS)
    extension TestCollection: SequenceOfFloat80 where Element == Float80 {}
    extension TestCollection: CollectionOfFloat80 where Element == Float80 {}
    extension TestCollection: SequenceOfOptionalFloat80 where Element == Float80? {}
    extension TestCollection: CollectionOfOptionalFloat80 where Element == Float80? {}
    #endif
    extension TestCollection: SequenceOfInt where Element == Int {}
    extension TestCollection: CollectionOfInt where Element == Int {}
    extension TestCollection: SequenceOfOptionalInt where Element == Int? {}
    extension TestCollection: CollectionOfOptionalInt where Element == Int? {}
    extension TestCollection: SequenceOfInt16 where Element == Int16 {}
    extension TestCollection: CollectionOfInt16 where Element == Int16 {}
    extension TestCollection: SequenceOfOptionalInt16 where Element == Int16? {}
    extension TestCollection: CollectionOfOptionalInt16 where Element == Int16? {}
    extension TestCollection: SequenceOfInt32 where Element == Int32 {}
    extension TestCollection: CollectionOfInt32 where Element == Int32 {}
    extension TestCollection: SequenceOfOptionalInt32 where Element == Int32? {}
    extension TestCollection: CollectionOfOptionalInt32 where Element == Int32? {}
    extension TestCollection: SequenceOfInt64 where Element == Int64 {}
    extension TestCollection: CollectionOfInt64 where Element == Int64 {}
    extension TestCollection: SequenceOfOptionalInt64 where Element == Int64? {}
    extension TestCollection: CollectionOfOptionalInt64 where Element == Int64? {}
    extension TestCollection: SequenceOfInt8 where Element == Int8 {}
    extension TestCollection: CollectionOfInt8 where Element == Int8 {}
    extension TestCollection: SequenceOfOptionalInt8 where Element == Int8? {}
    extension TestCollection: CollectionOfOptionalInt8 where Element == Int8? {}
    extension TestCollection: SequenceOfString where Element == String {}
    extension TestCollection: CollectionOfString where Element == String {}
    extension TestCollection: SequenceOfOptionalString where Element == String? {}
    extension TestCollection: CollectionOfOptionalString where Element == String? {}
    extension TestCollection: SequenceOfStringUTF16ViewElement where Element == String.UTF16View.Element {}
    extension TestCollection: CollectionOfStringUTF16ViewElement where Element == String.UTF16View.Element {}
    extension TestCollection: SequenceOfOptionalStringUTF16ViewElement where Element == String.UTF16View.Element? {}
    extension TestCollection: CollectionOfOptionalStringUTF16ViewElement where Element == String.UTF16View.Element? {}
    extension TestCollection: SequenceOfSubstring where Element == Substring {}
    extension TestCollection: CollectionOfSubstring where Element == Substring {}
    extension TestCollection: SequenceOfOptionalSubstring where Element == Substring? {}
    extension TestCollection: CollectionOfOptionalSubstring where Element == Substring? {}
    extension TestCollection: SequenceOfTestElement where Element == TestElement {}
    extension TestCollection: CollectionOfTestElement where Element == TestElement {}
    extension TestCollection: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension TestCollection: CollectionOfOptionalTestElement where Element == TestElement? {}
    extension TestCollection: SequenceOfUInt where Element == UInt {}
    extension TestCollection: CollectionOfUInt where Element == UInt {}
    extension TestCollection: SequenceOfOptionalUInt where Element == UInt? {}
    extension TestCollection: CollectionOfOptionalUInt where Element == UInt? {}
    extension TestCollection: SequenceOfUInt16 where Element == UInt16 {}
    extension TestCollection: CollectionOfUInt16 where Element == UInt16 {}
    extension TestCollection: SequenceOfOptionalUInt16 where Element == UInt16? {}
    extension TestCollection: CollectionOfOptionalUInt16 where Element == UInt16? {}
    extension TestCollection: SequenceOfUInt32 where Element == UInt32 {}
    extension TestCollection: CollectionOfUInt32 where Element == UInt32 {}
    extension TestCollection: SequenceOfOptionalUInt32 where Element == UInt32? {}
    extension TestCollection: CollectionOfOptionalUInt32 where Element == UInt32? {}
    extension TestCollection: SequenceOfUInt64 where Element == UInt64 {}
    extension TestCollection: CollectionOfUInt64 where Element == UInt64 {}
    extension TestCollection: SequenceOfOptionalUInt64 where Element == UInt64? {}
    extension TestCollection: CollectionOfOptionalUInt64 where Element == UInt64? {}
    extension TestCollection: SequenceOfUInt8 where Element == UInt8 {}
    extension TestCollection: CollectionOfUInt8 where Element == UInt8 {}
    extension TestCollection: SequenceOfOptionalUInt8 where Element == UInt8? {}
    extension TestCollection: CollectionOfOptionalUInt8 where Element == UInt8? {}
    extension TestCollection: SequenceOfUTF16CodeUnit where Element == UTF16.CodeUnit {}
    extension TestCollection: CollectionOfUTF16CodeUnit where Element == UTF16.CodeUnit {}
    extension TestCollection: SequenceOfOptionalUTF16CodeUnit where Element == UTF16.CodeUnit? {}
    extension TestCollection: CollectionOfOptionalUTF16CodeUnit where Element == UTF16.CodeUnit? {}
    extension TestCollection: SequenceOfUTF8CodeUnit where Element == UTF8.CodeUnit {}
    extension TestCollection: CollectionOfUTF8CodeUnit where Element == UTF8.CodeUnit {}
    extension TestCollection: SequenceOfOptionalUTF8CodeUnit where Element == UTF8.CodeUnit? {}
    extension TestCollection: CollectionOfOptionalUTF8CodeUnit where Element == UTF8.CodeUnit? {}
    extension TestCollection: SequenceOfUnicodeScalar where Element == Unicode.Scalar {}
    extension TestCollection: CollectionOfUnicodeScalar where Element == Unicode.Scalar {}
    extension TestCollection: SequenceOfOptionalUnicodeScalar where Element == Unicode.Scalar? {}
    extension TestCollection: CollectionOfOptionalUnicodeScalar where Element == Unicode.Scalar? {}

    extension UnsafeMutableBufferPointer: SequenceOfTestElement where Element == TestElement {}
    extension UnsafeMutableBufferPointer: CollectionOfTestElement where Element == TestElement {}
    extension UnsafeMutableBufferPointer: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension UnsafeMutableBufferPointer: CollectionOfOptionalTestElement where Element == TestElement? {}

    extension AnyIterator: SequenceOfTestElement where Element == TestElement {}
    extension AnyIterator: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension AnySequence: SequenceOfTestElement where Element == TestElement {}
    extension AnySequence: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension DropFirstSequence: SequenceOfTestElement where Element == TestElement {}
    extension DropFirstSequence: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension DropWhileSequence: SequenceOfTestElement where Element == TestElement {}
    extension DropWhileSequence: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension EmptyCollection.Iterator: SequenceOfTestElement where Element == TestElement {}
    extension EmptyCollection.Iterator: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension FlattenSequence: SequenceOfTestElement where Element == TestElement {}
    extension FlattenSequence: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension FlattenSequence.Iterator: SequenceOfTestElement where Element == TestElement {}
    extension FlattenSequence.Iterator: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension IndexingIterator: SequenceOfTestElement where Element == TestElement {}
    extension IndexingIterator: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension JoinedSequence: SequenceOfTestElement where Element == TestElement {}
    extension JoinedSequence: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension LazyDropWhileSequence: SequenceOfTestElement where Element == TestElement {}
    extension LazyDropWhileSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyDropWhileSequence: LazySequenceOfTestElement where Element == TestElement {}
    extension LazyDropWhileSequence: LazySequenceOfOptionalTestElement where Element == TestElement? {}

    extension LazyFilterSequence: SequenceOfTestElement where Element == TestElement {}
    extension LazyFilterSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyFilterSequence: LazySequenceOfTestElement where Element == TestElement {}
    extension LazyFilterSequence: LazySequenceOfOptionalTestElement where Element == TestElement? {}

    extension LazyFilterSequence.Iterator: SequenceOfTestElement where Element == TestElement {}
    extension LazyFilterSequence.Iterator: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension LazyMapSequence: SequenceOfTestElement where Element == TestElement {}
    extension LazyMapSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyMapSequence: LazySequenceOfTestElement where Element == TestElement {}
    extension LazyMapSequence: LazySequenceOfOptionalTestElement where Element == TestElement? {}

    extension LazyMapSequence.Iterator: SequenceOfTestElement where Element == TestElement {}
    extension LazyMapSequence.Iterator: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension LazyPrefixWhileSequence: SequenceOfTestElement where Element == TestElement {}
    extension LazyPrefixWhileSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyPrefixWhileSequence: LazySequenceOfTestElement where Element == TestElement {}
    extension LazyPrefixWhileSequence: LazySequenceOfOptionalTestElement where Element == TestElement? {}

    extension LazyPrefixWhileSequence.Iterator: SequenceOfTestElement where Element == TestElement {}
    extension LazyPrefixWhileSequence.Iterator: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension LazySequence: SequenceOfTestElement where Element == TestElement {}
    extension LazySequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazySequence: LazySequenceOfTestElement where Element == TestElement {}
    extension LazySequence: LazySequenceOfOptionalTestElement where Element == TestElement? {}

    extension PrefixSequence: SequenceOfTestElement where Element == TestElement {}
    extension PrefixSequence: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension ReversedCollection.Iterator: SequenceOfTestElement where Element == TestElement {}
    extension ReversedCollection.Iterator: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension StrideThrough: SequenceOfTestElement where Element == TestElement {}

    extension StrideTo: SequenceOfTestElement where Element == TestElement {}

    extension TestSequence: SequenceOfBool where Element == Bool {}
    extension TestSequence: SequenceOfOptionalBool where Element == Bool? {}
    extension TestSequence: SequenceOfCharacter where Element == Character {}
    extension TestSequence: SequenceOfOptionalCharacter where Element == Character? {}
    extension TestSequence: SequenceOfDouble where Element == Double {}
    extension TestSequence: SequenceOfOptionalDouble where Element == Double? {}
    extension TestSequence: SequenceOfError where Element == Error {}
    extension TestSequence: SequenceOfOptionalError where Element == Error? {}
    extension TestSequence: SequenceOfFloat where Element == Float {}
    extension TestSequence: SequenceOfOptionalFloat where Element == Float? {}
    #if os(macOS)
    extension TestSequence: SequenceOfFloat80 where Element == Float80 {}
    extension TestSequence: SequenceOfOptionalFloat80 where Element == Float80? {}
    #endif
    extension TestSequence: SequenceOfInt where Element == Int {}
    extension TestSequence: SequenceOfOptionalInt where Element == Int? {}
    extension TestSequence: SequenceOfInt16 where Element == Int16 {}
    extension TestSequence: SequenceOfOptionalInt16 where Element == Int16? {}
    extension TestSequence: SequenceOfInt32 where Element == Int32 {}
    extension TestSequence: SequenceOfOptionalInt32 where Element == Int32? {}
    extension TestSequence: SequenceOfInt64 where Element == Int64 {}
    extension TestSequence: SequenceOfOptionalInt64 where Element == Int64? {}
    extension TestSequence: SequenceOfInt8 where Element == Int8 {}
    extension TestSequence: SequenceOfOptionalInt8 where Element == Int8? {}
    extension TestSequence: SequenceOfString where Element == String {}
    extension TestSequence: SequenceOfOptionalString where Element == String? {}
    extension TestSequence: SequenceOfStringUTF16ViewElement where Element == String.UTF16View.Element {}
    extension TestSequence: SequenceOfOptionalStringUTF16ViewElement where Element == String.UTF16View.Element? {}
    extension TestSequence: SequenceOfSubstring where Element == Substring {}
    extension TestSequence: SequenceOfOptionalSubstring where Element == Substring? {}
    extension TestSequence: SequenceOfTestElement where Element == TestElement {}
    extension TestSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension TestSequence: SequenceOfUInt where Element == UInt {}
    extension TestSequence: SequenceOfOptionalUInt where Element == UInt? {}
    extension TestSequence: SequenceOfUInt16 where Element == UInt16 {}
    extension TestSequence: SequenceOfOptionalUInt16 where Element == UInt16? {}
    extension TestSequence: SequenceOfUInt32 where Element == UInt32 {}
    extension TestSequence: SequenceOfOptionalUInt32 where Element == UInt32? {}
    extension TestSequence: SequenceOfUInt64 where Element == UInt64 {}
    extension TestSequence: SequenceOfOptionalUInt64 where Element == UInt64? {}
    extension TestSequence: SequenceOfUInt8 where Element == UInt8 {}
    extension TestSequence: SequenceOfOptionalUInt8 where Element == UInt8? {}
    extension TestSequence: SequenceOfUTF16CodeUnit where Element == UTF16.CodeUnit {}
    extension TestSequence: SequenceOfOptionalUTF16CodeUnit where Element == UTF16.CodeUnit? {}
    extension TestSequence: SequenceOfUTF8CodeUnit where Element == UTF8.CodeUnit {}
    extension TestSequence: SequenceOfOptionalUTF8CodeUnit where Element == UTF8.CodeUnit? {}
    extension TestSequence: SequenceOfUnicodeScalar where Element == Unicode.Scalar {}
    extension TestSequence: SequenceOfOptionalUnicodeScalar where Element == Unicode.Scalar? {}

    extension UnfoldSequence: SequenceOfTestElement where Element == TestElement {}
    extension UnfoldSequence: SequenceOfOptionalTestElement where Element == TestElement? {}

    extension UnsafeBufferPointer: SequenceOfTestElement where Element == TestElement {}
    extension UnsafeBufferPointer: SequenceOfOptionalTestElement where Element == TestElement? {}
    """
}
