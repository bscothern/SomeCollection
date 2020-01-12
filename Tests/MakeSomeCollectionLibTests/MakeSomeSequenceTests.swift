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
            "TestSequence",
            .init(
                "TestSequence2",
                limitedTo: ["Bool", "Int"]
            ),
            .init(
                "TestSequence3",
                excluding: ["String", "Error"]
            ),
        ]
        
        let collections: Set<CollectionType> = [
            "TestCollection",
            .init("TestCollection2", limitedTo: ["Bool", "Int"]),
            .init("TestCollection3", excluding: ["String", "Error"]),
        ]
        
        let elements: Set<ElementType> = [
            "TestElement",
            .init(
                "TestElement2",
                includedSequenceTypes: ["Range"],
                includedCollectionTypes: ["DefaultIndices"]
            ),
            .init(
                "TestElement3",
                excludedSequenceTypes: ["AnySequence"],
                excludedCollectionTypes: ["Array"]
            ),
            .init(
                "TestElement4",
                restrictedTo: [.iOS]
            ),
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
    
    func areTheSame(_ expected: String, _ result: String, line: UInt = #line) {
        zip(expected.split(separator: "\n", omittingEmptySubsequences: true), result.split(separator: "\n", omittingEmptySubsequences: true)).forEach { expected, result in
            XCTAssertEqual(expected, result, line: line)
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
    extension AnyBidirectionalCollection: SequenceOfTestElement2 where Element == TestElement2 {}
    extension AnyBidirectionalCollection: CollectionOfTestElement2 where Element == TestElement2 {}
    extension AnyBidirectionalCollection: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension AnyBidirectionalCollection: CollectionOfOptionalTestElement2 where Element == TestElement2? {}
    extension AnyBidirectionalCollection: SequenceOfTestElement3 where Element == TestElement3 {}
    extension AnyBidirectionalCollection: CollectionOfTestElement3 where Element == TestElement3 {}
    extension AnyBidirectionalCollection: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension AnyBidirectionalCollection: CollectionOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension AnyBidirectionalCollection: SequenceOfTestElement4 where Element == TestElement4 {}
    extension AnyBidirectionalCollection: CollectionOfTestElement4 where Element == TestElement4 {}
    extension AnyBidirectionalCollection: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension AnyBidirectionalCollection: CollectionOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension AnyCollection: SequenceOfTestElement where Element == TestElement {}
    extension AnyCollection: CollectionOfTestElement where Element == TestElement {}
    extension AnyCollection: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension AnyCollection: CollectionOfOptionalTestElement where Element == TestElement? {}
    extension AnyCollection: SequenceOfTestElement2 where Element == TestElement2 {}
    extension AnyCollection: CollectionOfTestElement2 where Element == TestElement2 {}
    extension AnyCollection: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension AnyCollection: CollectionOfOptionalTestElement2 where Element == TestElement2? {}
    extension AnyCollection: SequenceOfTestElement3 where Element == TestElement3 {}
    extension AnyCollection: CollectionOfTestElement3 where Element == TestElement3 {}
    extension AnyCollection: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension AnyCollection: CollectionOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension AnyCollection: SequenceOfTestElement4 where Element == TestElement4 {}
    extension AnyCollection: CollectionOfTestElement4 where Element == TestElement4 {}
    extension AnyCollection: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension AnyCollection: CollectionOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension Array: SequenceOfTestElement where Element == TestElement {}
    extension Array: CollectionOfTestElement where Element == TestElement {}
    extension Array: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension Array: CollectionOfOptionalTestElement where Element == TestElement? {}
    extension Array: SequenceOfTestElement2 where Element == TestElement2 {}
    extension Array: CollectionOfTestElement2 where Element == TestElement2 {}
    extension Array: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension Array: CollectionOfOptionalTestElement2 where Element == TestElement2? {}
    #if os(iOS)
    extension Array: SequenceOfTestElement4 where Element == TestElement4 {}
    extension Array: CollectionOfTestElement4 where Element == TestElement4 {}
    extension Array: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension Array: CollectionOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension ArraySlice: SequenceOfTestElement where Element == TestElement {}
    extension ArraySlice: CollectionOfTestElement where Element == TestElement {}
    extension ArraySlice: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension ArraySlice: CollectionOfOptionalTestElement where Element == TestElement? {}
    extension ArraySlice: SequenceOfTestElement2 where Element == TestElement2 {}
    extension ArraySlice: CollectionOfTestElement2 where Element == TestElement2 {}
    extension ArraySlice: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension ArraySlice: CollectionOfOptionalTestElement2 where Element == TestElement2? {}
    extension ArraySlice: SequenceOfTestElement3 where Element == TestElement3 {}
    extension ArraySlice: CollectionOfTestElement3 where Element == TestElement3 {}
    extension ArraySlice: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension ArraySlice: CollectionOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension ArraySlice: SequenceOfTestElement4 where Element == TestElement4 {}
    extension ArraySlice: CollectionOfTestElement4 where Element == TestElement4 {}
    extension ArraySlice: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension ArraySlice: CollectionOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension CollectionOfOne: SequenceOfTestElement where Element == TestElement {}
    extension CollectionOfOne: CollectionOfTestElement where Element == TestElement {}
    extension CollectionOfOne: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension CollectionOfOne: CollectionOfOptionalTestElement where Element == TestElement? {}
    extension CollectionOfOne: SequenceOfTestElement2 where Element == TestElement2 {}
    extension CollectionOfOne: CollectionOfTestElement2 where Element == TestElement2 {}
    extension CollectionOfOne: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension CollectionOfOne: CollectionOfOptionalTestElement2 where Element == TestElement2? {}
    extension CollectionOfOne: SequenceOfTestElement3 where Element == TestElement3 {}
    extension CollectionOfOne: CollectionOfTestElement3 where Element == TestElement3 {}
    extension CollectionOfOne: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension CollectionOfOne: CollectionOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension CollectionOfOne: SequenceOfTestElement4 where Element == TestElement4 {}
    extension CollectionOfOne: CollectionOfTestElement4 where Element == TestElement4 {}
    extension CollectionOfOne: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension CollectionOfOne: CollectionOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension ContiguousArray: SequenceOfTestElement where Element == TestElement {}
    extension ContiguousArray: CollectionOfTestElement where Element == TestElement {}
    extension ContiguousArray: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension ContiguousArray: CollectionOfOptionalTestElement where Element == TestElement? {}
    extension ContiguousArray: SequenceOfTestElement2 where Element == TestElement2 {}
    extension ContiguousArray: CollectionOfTestElement2 where Element == TestElement2 {}
    extension ContiguousArray: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension ContiguousArray: CollectionOfOptionalTestElement2 where Element == TestElement2? {}
    extension ContiguousArray: SequenceOfTestElement3 where Element == TestElement3 {}
    extension ContiguousArray: CollectionOfTestElement3 where Element == TestElement3 {}
    extension ContiguousArray: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension ContiguousArray: CollectionOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension ContiguousArray: SequenceOfTestElement4 where Element == TestElement4 {}
    extension ContiguousArray: CollectionOfTestElement4 where Element == TestElement4 {}
    extension ContiguousArray: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension ContiguousArray: CollectionOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension DefaultIndices: SequenceOfTestElement2 where Element == TestElement2 {}
    extension DefaultIndices: CollectionOfTestElement2 where Element == TestElement2 {}

    extension Dictionary.Values: SequenceOfTestElement where Element == TestElement {}
    extension Dictionary.Values: CollectionOfTestElement where Element == TestElement {}
    extension Dictionary.Values: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension Dictionary.Values: CollectionOfOptionalTestElement where Element == TestElement? {}
    extension Dictionary.Values: SequenceOfTestElement2 where Element == TestElement2 {}
    extension Dictionary.Values: CollectionOfTestElement2 where Element == TestElement2 {}
    extension Dictionary.Values: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension Dictionary.Values: CollectionOfOptionalTestElement2 where Element == TestElement2? {}
    extension Dictionary.Values: SequenceOfTestElement3 where Element == TestElement3 {}
    extension Dictionary.Values: CollectionOfTestElement3 where Element == TestElement3 {}
    extension Dictionary.Values: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension Dictionary.Values: CollectionOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension Dictionary.Values: SequenceOfTestElement4 where Element == TestElement4 {}
    extension Dictionary.Values: CollectionOfTestElement4 where Element == TestElement4 {}
    extension Dictionary.Values: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension Dictionary.Values: CollectionOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension EmptyCollection: SequenceOfTestElement where Element == TestElement {}
    extension EmptyCollection: CollectionOfTestElement where Element == TestElement {}
    extension EmptyCollection: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension EmptyCollection: CollectionOfOptionalTestElement where Element == TestElement? {}
    extension EmptyCollection: SequenceOfTestElement2 where Element == TestElement2 {}
    extension EmptyCollection: CollectionOfTestElement2 where Element == TestElement2 {}
    extension EmptyCollection: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension EmptyCollection: CollectionOfOptionalTestElement2 where Element == TestElement2? {}
    extension EmptyCollection: SequenceOfTestElement3 where Element == TestElement3 {}
    extension EmptyCollection: CollectionOfTestElement3 where Element == TestElement3 {}
    extension EmptyCollection: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension EmptyCollection: CollectionOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension EmptyCollection: SequenceOfTestElement4 where Element == TestElement4 {}
    extension EmptyCollection: CollectionOfTestElement4 where Element == TestElement4 {}
    extension EmptyCollection: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension EmptyCollection: CollectionOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension ReversedCollection: SequenceOfTestElement where Element == TestElement {}
    extension ReversedCollection: CollectionOfTestElement where Element == TestElement {}
    extension ReversedCollection: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension ReversedCollection: CollectionOfOptionalTestElement where Element == TestElement? {}
    extension ReversedCollection: SequenceOfTestElement2 where Element == TestElement2 {}
    extension ReversedCollection: CollectionOfTestElement2 where Element == TestElement2 {}
    extension ReversedCollection: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension ReversedCollection: CollectionOfOptionalTestElement2 where Element == TestElement2? {}
    extension ReversedCollection: SequenceOfTestElement3 where Element == TestElement3 {}
    extension ReversedCollection: CollectionOfTestElement3 where Element == TestElement3 {}
    extension ReversedCollection: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension ReversedCollection: CollectionOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension ReversedCollection: SequenceOfTestElement4 where Element == TestElement4 {}
    extension ReversedCollection: CollectionOfTestElement4 where Element == TestElement4 {}
    extension ReversedCollection: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension ReversedCollection: CollectionOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension Slice: SequenceOfTestElement where Element == TestElement {}
    extension Slice: CollectionOfTestElement where Element == TestElement {}
    extension Slice: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension Slice: CollectionOfOptionalTestElement where Element == TestElement? {}
    extension Slice: SequenceOfTestElement2 where Element == TestElement2 {}
    extension Slice: CollectionOfTestElement2 where Element == TestElement2 {}
    extension Slice: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension Slice: CollectionOfOptionalTestElement2 where Element == TestElement2? {}
    extension Slice: SequenceOfTestElement3 where Element == TestElement3 {}
    extension Slice: CollectionOfTestElement3 where Element == TestElement3 {}
    extension Slice: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension Slice: CollectionOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension Slice: SequenceOfTestElement4 where Element == TestElement4 {}
    extension Slice: CollectionOfTestElement4 where Element == TestElement4 {}
    extension Slice: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension Slice: CollectionOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

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
    extension TestCollection: SequenceOfTestElement2 where Element == TestElement2 {}
    extension TestCollection: CollectionOfTestElement2 where Element == TestElement2 {}
    extension TestCollection: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension TestCollection: CollectionOfOptionalTestElement2 where Element == TestElement2? {}
    extension TestCollection: SequenceOfTestElement3 where Element == TestElement3 {}
    extension TestCollection: CollectionOfTestElement3 where Element == TestElement3 {}
    extension TestCollection: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension TestCollection: CollectionOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension TestCollection: SequenceOfTestElement4 where Element == TestElement4 {}
    extension TestCollection: CollectionOfTestElement4 where Element == TestElement4 {}
    extension TestCollection: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension TestCollection: CollectionOfOptionalTestElement4 where Element == TestElement4? {}
    #endif
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

    extension TestCollection2: SequenceOfBool where Element == Bool {}
    extension TestCollection2: CollectionOfBool where Element == Bool {}
    extension TestCollection2: SequenceOfOptionalBool where Element == Bool? {}
    extension TestCollection2: CollectionOfOptionalBool where Element == Bool? {}
    extension TestCollection2: SequenceOfInt where Element == Int {}
    extension TestCollection2: CollectionOfInt where Element == Int {}
    extension TestCollection2: SequenceOfOptionalInt where Element == Int? {}
    extension TestCollection2: CollectionOfOptionalInt where Element == Int? {}

    extension TestCollection3: SequenceOfBool where Element == Bool {}
    extension TestCollection3: CollectionOfBool where Element == Bool {}
    extension TestCollection3: SequenceOfOptionalBool where Element == Bool? {}
    extension TestCollection3: CollectionOfOptionalBool where Element == Bool? {}
    extension TestCollection3: SequenceOfCharacter where Element == Character {}
    extension TestCollection3: CollectionOfCharacter where Element == Character {}
    extension TestCollection3: SequenceOfOptionalCharacter where Element == Character? {}
    extension TestCollection3: CollectionOfOptionalCharacter where Element == Character? {}
    extension TestCollection3: SequenceOfDouble where Element == Double {}
    extension TestCollection3: CollectionOfDouble where Element == Double {}
    extension TestCollection3: SequenceOfOptionalDouble where Element == Double? {}
    extension TestCollection3: CollectionOfOptionalDouble where Element == Double? {}
    extension TestCollection3: SequenceOfFloat where Element == Float {}
    extension TestCollection3: CollectionOfFloat where Element == Float {}
    extension TestCollection3: SequenceOfOptionalFloat where Element == Float? {}
    extension TestCollection3: CollectionOfOptionalFloat where Element == Float? {}
    #if os(macOS)
    extension TestCollection3: SequenceOfFloat80 where Element == Float80 {}
    extension TestCollection3: CollectionOfFloat80 where Element == Float80 {}
    extension TestCollection3: SequenceOfOptionalFloat80 where Element == Float80? {}
    extension TestCollection3: CollectionOfOptionalFloat80 where Element == Float80? {}
    #endif
    extension TestCollection3: SequenceOfInt where Element == Int {}
    extension TestCollection3: CollectionOfInt where Element == Int {}
    extension TestCollection3: SequenceOfOptionalInt where Element == Int? {}
    extension TestCollection3: CollectionOfOptionalInt where Element == Int? {}
    extension TestCollection3: SequenceOfInt16 where Element == Int16 {}
    extension TestCollection3: CollectionOfInt16 where Element == Int16 {}
    extension TestCollection3: SequenceOfOptionalInt16 where Element == Int16? {}
    extension TestCollection3: CollectionOfOptionalInt16 where Element == Int16? {}
    extension TestCollection3: SequenceOfInt32 where Element == Int32 {}
    extension TestCollection3: CollectionOfInt32 where Element == Int32 {}
    extension TestCollection3: SequenceOfOptionalInt32 where Element == Int32? {}
    extension TestCollection3: CollectionOfOptionalInt32 where Element == Int32? {}
    extension TestCollection3: SequenceOfInt64 where Element == Int64 {}
    extension TestCollection3: CollectionOfInt64 where Element == Int64 {}
    extension TestCollection3: SequenceOfOptionalInt64 where Element == Int64? {}
    extension TestCollection3: CollectionOfOptionalInt64 where Element == Int64? {}
    extension TestCollection3: SequenceOfInt8 where Element == Int8 {}
    extension TestCollection3: CollectionOfInt8 where Element == Int8 {}
    extension TestCollection3: SequenceOfOptionalInt8 where Element == Int8? {}
    extension TestCollection3: CollectionOfOptionalInt8 where Element == Int8? {}
    extension TestCollection3: SequenceOfStringUTF16ViewElement where Element == String.UTF16View.Element {}
    extension TestCollection3: CollectionOfStringUTF16ViewElement where Element == String.UTF16View.Element {}
    extension TestCollection3: SequenceOfOptionalStringUTF16ViewElement where Element == String.UTF16View.Element? {}
    extension TestCollection3: CollectionOfOptionalStringUTF16ViewElement where Element == String.UTF16View.Element? {}
    extension TestCollection3: SequenceOfSubstring where Element == Substring {}
    extension TestCollection3: CollectionOfSubstring where Element == Substring {}
    extension TestCollection3: SequenceOfOptionalSubstring where Element == Substring? {}
    extension TestCollection3: CollectionOfOptionalSubstring where Element == Substring? {}
    extension TestCollection3: SequenceOfTestElement where Element == TestElement {}
    extension TestCollection3: CollectionOfTestElement where Element == TestElement {}
    extension TestCollection3: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension TestCollection3: CollectionOfOptionalTestElement where Element == TestElement? {}
    extension TestCollection3: SequenceOfTestElement2 where Element == TestElement2 {}
    extension TestCollection3: CollectionOfTestElement2 where Element == TestElement2 {}
    extension TestCollection3: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension TestCollection3: CollectionOfOptionalTestElement2 where Element == TestElement2? {}
    extension TestCollection3: SequenceOfTestElement3 where Element == TestElement3 {}
    extension TestCollection3: CollectionOfTestElement3 where Element == TestElement3 {}
    extension TestCollection3: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension TestCollection3: CollectionOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension TestCollection3: SequenceOfTestElement4 where Element == TestElement4 {}
    extension TestCollection3: CollectionOfTestElement4 where Element == TestElement4 {}
    extension TestCollection3: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension TestCollection3: CollectionOfOptionalTestElement4 where Element == TestElement4? {}
    #endif
    extension TestCollection3: SequenceOfUInt where Element == UInt {}
    extension TestCollection3: CollectionOfUInt where Element == UInt {}
    extension TestCollection3: SequenceOfOptionalUInt where Element == UInt? {}
    extension TestCollection3: CollectionOfOptionalUInt where Element == UInt? {}
    extension TestCollection3: SequenceOfUInt16 where Element == UInt16 {}
    extension TestCollection3: CollectionOfUInt16 where Element == UInt16 {}
    extension TestCollection3: SequenceOfOptionalUInt16 where Element == UInt16? {}
    extension TestCollection3: CollectionOfOptionalUInt16 where Element == UInt16? {}
    extension TestCollection3: SequenceOfUInt32 where Element == UInt32 {}
    extension TestCollection3: CollectionOfUInt32 where Element == UInt32 {}
    extension TestCollection3: SequenceOfOptionalUInt32 where Element == UInt32? {}
    extension TestCollection3: CollectionOfOptionalUInt32 where Element == UInt32? {}
    extension TestCollection3: SequenceOfUInt64 where Element == UInt64 {}
    extension TestCollection3: CollectionOfUInt64 where Element == UInt64 {}
    extension TestCollection3: SequenceOfOptionalUInt64 where Element == UInt64? {}
    extension TestCollection3: CollectionOfOptionalUInt64 where Element == UInt64? {}
    extension TestCollection3: SequenceOfUInt8 where Element == UInt8 {}
    extension TestCollection3: CollectionOfUInt8 where Element == UInt8 {}
    extension TestCollection3: SequenceOfOptionalUInt8 where Element == UInt8? {}
    extension TestCollection3: CollectionOfOptionalUInt8 where Element == UInt8? {}
    extension TestCollection3: SequenceOfUTF16CodeUnit where Element == UTF16.CodeUnit {}
    extension TestCollection3: CollectionOfUTF16CodeUnit where Element == UTF16.CodeUnit {}
    extension TestCollection3: SequenceOfOptionalUTF16CodeUnit where Element == UTF16.CodeUnit? {}
    extension TestCollection3: CollectionOfOptionalUTF16CodeUnit where Element == UTF16.CodeUnit? {}
    extension TestCollection3: SequenceOfUTF8CodeUnit where Element == UTF8.CodeUnit {}
    extension TestCollection3: CollectionOfUTF8CodeUnit where Element == UTF8.CodeUnit {}
    extension TestCollection3: SequenceOfOptionalUTF8CodeUnit where Element == UTF8.CodeUnit? {}
    extension TestCollection3: CollectionOfOptionalUTF8CodeUnit where Element == UTF8.CodeUnit? {}
    extension TestCollection3: SequenceOfUnicodeScalar where Element == Unicode.Scalar {}
    extension TestCollection3: CollectionOfUnicodeScalar where Element == Unicode.Scalar {}
    extension TestCollection3: SequenceOfOptionalUnicodeScalar where Element == Unicode.Scalar? {}
    extension TestCollection3: CollectionOfOptionalUnicodeScalar where Element == Unicode.Scalar? {}

    extension UnsafeMutableBufferPointer: SequenceOfTestElement where Element == TestElement {}
    extension UnsafeMutableBufferPointer: CollectionOfTestElement where Element == TestElement {}
    extension UnsafeMutableBufferPointer: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension UnsafeMutableBufferPointer: CollectionOfOptionalTestElement where Element == TestElement? {}
    extension UnsafeMutableBufferPointer: SequenceOfTestElement2 where Element == TestElement2 {}
    extension UnsafeMutableBufferPointer: CollectionOfTestElement2 where Element == TestElement2 {}
    extension UnsafeMutableBufferPointer: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension UnsafeMutableBufferPointer: CollectionOfOptionalTestElement2 where Element == TestElement2? {}
    extension UnsafeMutableBufferPointer: SequenceOfTestElement3 where Element == TestElement3 {}
    extension UnsafeMutableBufferPointer: CollectionOfTestElement3 where Element == TestElement3 {}
    extension UnsafeMutableBufferPointer: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension UnsafeMutableBufferPointer: CollectionOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension UnsafeMutableBufferPointer: SequenceOfTestElement4 where Element == TestElement4 {}
    extension UnsafeMutableBufferPointer: CollectionOfTestElement4 where Element == TestElement4 {}
    extension UnsafeMutableBufferPointer: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension UnsafeMutableBufferPointer: CollectionOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension AnyIterator: SequenceOfTestElement where Element == TestElement {}
    extension AnyIterator: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension AnyIterator: SequenceOfTestElement2 where Element == TestElement2 {}
    extension AnyIterator: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension AnyIterator: SequenceOfTestElement3 where Element == TestElement3 {}
    extension AnyIterator: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension AnyIterator: SequenceOfTestElement4 where Element == TestElement4 {}
    extension AnyIterator: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension AnySequence: SequenceOfTestElement where Element == TestElement {}
    extension AnySequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension AnySequence: SequenceOfTestElement2 where Element == TestElement2 {}
    extension AnySequence: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    #if os(iOS)
    extension AnySequence: SequenceOfTestElement4 where Element == TestElement4 {}
    extension AnySequence: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension DropFirstSequence: SequenceOfTestElement where Element == TestElement {}
    extension DropFirstSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension DropFirstSequence: SequenceOfTestElement2 where Element == TestElement2 {}
    extension DropFirstSequence: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension DropFirstSequence: SequenceOfTestElement3 where Element == TestElement3 {}
    extension DropFirstSequence: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension DropFirstSequence: SequenceOfTestElement4 where Element == TestElement4 {}
    extension DropFirstSequence: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension DropWhileSequence: SequenceOfTestElement where Element == TestElement {}
    extension DropWhileSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension DropWhileSequence: SequenceOfTestElement2 where Element == TestElement2 {}
    extension DropWhileSequence: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension DropWhileSequence: SequenceOfTestElement3 where Element == TestElement3 {}
    extension DropWhileSequence: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension DropWhileSequence: SequenceOfTestElement4 where Element == TestElement4 {}
    extension DropWhileSequence: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension EmptyCollection.Iterator: SequenceOfTestElement where Element == TestElement {}
    extension EmptyCollection.Iterator: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension EmptyCollection.Iterator: SequenceOfTestElement2 where Element == TestElement2 {}
    extension EmptyCollection.Iterator: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension EmptyCollection.Iterator: SequenceOfTestElement3 where Element == TestElement3 {}
    extension EmptyCollection.Iterator: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension EmptyCollection.Iterator: SequenceOfTestElement4 where Element == TestElement4 {}
    extension EmptyCollection.Iterator: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension FlattenSequence: SequenceOfTestElement where Element == TestElement {}
    extension FlattenSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension FlattenSequence: SequenceOfTestElement2 where Element == TestElement2 {}
    extension FlattenSequence: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension FlattenSequence: SequenceOfTestElement3 where Element == TestElement3 {}
    extension FlattenSequence: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension FlattenSequence: SequenceOfTestElement4 where Element == TestElement4 {}
    extension FlattenSequence: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension FlattenSequence.Iterator: SequenceOfTestElement where Element == TestElement {}
    extension FlattenSequence.Iterator: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension FlattenSequence.Iterator: SequenceOfTestElement2 where Element == TestElement2 {}
    extension FlattenSequence.Iterator: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension FlattenSequence.Iterator: SequenceOfTestElement3 where Element == TestElement3 {}
    extension FlattenSequence.Iterator: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension FlattenSequence.Iterator: SequenceOfTestElement4 where Element == TestElement4 {}
    extension FlattenSequence.Iterator: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension IndexingIterator: SequenceOfTestElement where Element == TestElement {}
    extension IndexingIterator: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension IndexingIterator: SequenceOfTestElement2 where Element == TestElement2 {}
    extension IndexingIterator: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension IndexingIterator: SequenceOfTestElement3 where Element == TestElement3 {}
    extension IndexingIterator: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension IndexingIterator: SequenceOfTestElement4 where Element == TestElement4 {}
    extension IndexingIterator: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension JoinedSequence: SequenceOfTestElement where Element == TestElement {}
    extension JoinedSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension JoinedSequence: SequenceOfTestElement2 where Element == TestElement2 {}
    extension JoinedSequence: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension JoinedSequence: SequenceOfTestElement3 where Element == TestElement3 {}
    extension JoinedSequence: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension JoinedSequence: SequenceOfTestElement4 where Element == TestElement4 {}
    extension JoinedSequence: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension LazyDropWhileSequence: SequenceOfTestElement where Element == TestElement {}
    extension LazyDropWhileSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyDropWhileSequence: LazySequenceOfTestElement where Element == TestElement {}
    extension LazyDropWhileSequence: LazySequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyDropWhileSequence: SequenceOfTestElement2 where Element == TestElement2 {}
    extension LazyDropWhileSequence: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension LazyDropWhileSequence: LazySequenceOfTestElement2 where Element == TestElement2 {}
    extension LazyDropWhileSequence: LazySequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension LazyDropWhileSequence: SequenceOfTestElement3 where Element == TestElement3 {}
    extension LazyDropWhileSequence: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension LazyDropWhileSequence: LazySequenceOfTestElement3 where Element == TestElement3 {}
    extension LazyDropWhileSequence: LazySequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension LazyDropWhileSequence: SequenceOfTestElement4 where Element == TestElement4 {}
    extension LazyDropWhileSequence: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension LazyDropWhileSequence: LazySequenceOfTestElement4 where Element == TestElement4 {}
    extension LazyDropWhileSequence: LazySequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension LazyFilterSequence: SequenceOfTestElement where Element == TestElement {}
    extension LazyFilterSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyFilterSequence: LazySequenceOfTestElement where Element == TestElement {}
    extension LazyFilterSequence: LazySequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyFilterSequence: SequenceOfTestElement2 where Element == TestElement2 {}
    extension LazyFilterSequence: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension LazyFilterSequence: LazySequenceOfTestElement2 where Element == TestElement2 {}
    extension LazyFilterSequence: LazySequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension LazyFilterSequence: SequenceOfTestElement3 where Element == TestElement3 {}
    extension LazyFilterSequence: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension LazyFilterSequence: LazySequenceOfTestElement3 where Element == TestElement3 {}
    extension LazyFilterSequence: LazySequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension LazyFilterSequence: SequenceOfTestElement4 where Element == TestElement4 {}
    extension LazyFilterSequence: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension LazyFilterSequence: LazySequenceOfTestElement4 where Element == TestElement4 {}
    extension LazyFilterSequence: LazySequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension LazyFilterSequence.Iterator: SequenceOfTestElement where Element == TestElement {}
    extension LazyFilterSequence.Iterator: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyFilterSequence.Iterator: SequenceOfTestElement2 where Element == TestElement2 {}
    extension LazyFilterSequence.Iterator: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension LazyFilterSequence.Iterator: SequenceOfTestElement3 where Element == TestElement3 {}
    extension LazyFilterSequence.Iterator: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension LazyFilterSequence.Iterator: SequenceOfTestElement4 where Element == TestElement4 {}
    extension LazyFilterSequence.Iterator: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension LazyMapSequence: SequenceOfTestElement where Element == TestElement {}
    extension LazyMapSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyMapSequence: LazySequenceOfTestElement where Element == TestElement {}
    extension LazyMapSequence: LazySequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyMapSequence: SequenceOfTestElement2 where Element == TestElement2 {}
    extension LazyMapSequence: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension LazyMapSequence: LazySequenceOfTestElement2 where Element == TestElement2 {}
    extension LazyMapSequence: LazySequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension LazyMapSequence: SequenceOfTestElement3 where Element == TestElement3 {}
    extension LazyMapSequence: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension LazyMapSequence: LazySequenceOfTestElement3 where Element == TestElement3 {}
    extension LazyMapSequence: LazySequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension LazyMapSequence: SequenceOfTestElement4 where Element == TestElement4 {}
    extension LazyMapSequence: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension LazyMapSequence: LazySequenceOfTestElement4 where Element == TestElement4 {}
    extension LazyMapSequence: LazySequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension LazyMapSequence.Iterator: SequenceOfTestElement where Element == TestElement {}
    extension LazyMapSequence.Iterator: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyMapSequence.Iterator: SequenceOfTestElement2 where Element == TestElement2 {}
    extension LazyMapSequence.Iterator: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension LazyMapSequence.Iterator: SequenceOfTestElement3 where Element == TestElement3 {}
    extension LazyMapSequence.Iterator: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension LazyMapSequence.Iterator: SequenceOfTestElement4 where Element == TestElement4 {}
    extension LazyMapSequence.Iterator: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension LazyPrefixWhileSequence: SequenceOfTestElement where Element == TestElement {}
    extension LazyPrefixWhileSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyPrefixWhileSequence: LazySequenceOfTestElement where Element == TestElement {}
    extension LazyPrefixWhileSequence: LazySequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyPrefixWhileSequence: SequenceOfTestElement2 where Element == TestElement2 {}
    extension LazyPrefixWhileSequence: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension LazyPrefixWhileSequence: LazySequenceOfTestElement2 where Element == TestElement2 {}
    extension LazyPrefixWhileSequence: LazySequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension LazyPrefixWhileSequence: SequenceOfTestElement3 where Element == TestElement3 {}
    extension LazyPrefixWhileSequence: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension LazyPrefixWhileSequence: LazySequenceOfTestElement3 where Element == TestElement3 {}
    extension LazyPrefixWhileSequence: LazySequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension LazyPrefixWhileSequence: SequenceOfTestElement4 where Element == TestElement4 {}
    extension LazyPrefixWhileSequence: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension LazyPrefixWhileSequence: LazySequenceOfTestElement4 where Element == TestElement4 {}
    extension LazyPrefixWhileSequence: LazySequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension LazyPrefixWhileSequence.Iterator: SequenceOfTestElement where Element == TestElement {}
    extension LazyPrefixWhileSequence.Iterator: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazyPrefixWhileSequence.Iterator: SequenceOfTestElement2 where Element == TestElement2 {}
    extension LazyPrefixWhileSequence.Iterator: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension LazyPrefixWhileSequence.Iterator: SequenceOfTestElement3 where Element == TestElement3 {}
    extension LazyPrefixWhileSequence.Iterator: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension LazyPrefixWhileSequence.Iterator: SequenceOfTestElement4 where Element == TestElement4 {}
    extension LazyPrefixWhileSequence.Iterator: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension LazySequence: SequenceOfTestElement where Element == TestElement {}
    extension LazySequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazySequence: LazySequenceOfTestElement where Element == TestElement {}
    extension LazySequence: LazySequenceOfOptionalTestElement where Element == TestElement? {}
    extension LazySequence: SequenceOfTestElement2 where Element == TestElement2 {}
    extension LazySequence: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension LazySequence: LazySequenceOfTestElement2 where Element == TestElement2 {}
    extension LazySequence: LazySequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension LazySequence: SequenceOfTestElement3 where Element == TestElement3 {}
    extension LazySequence: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    extension LazySequence: LazySequenceOfTestElement3 where Element == TestElement3 {}
    extension LazySequence: LazySequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension LazySequence: SequenceOfTestElement4 where Element == TestElement4 {}
    extension LazySequence: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    extension LazySequence: LazySequenceOfTestElement4 where Element == TestElement4 {}
    extension LazySequence: LazySequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension PrefixSequence: SequenceOfTestElement where Element == TestElement {}
    extension PrefixSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension PrefixSequence: SequenceOfTestElement2 where Element == TestElement2 {}
    extension PrefixSequence: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension PrefixSequence: SequenceOfTestElement3 where Element == TestElement3 {}
    extension PrefixSequence: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension PrefixSequence: SequenceOfTestElement4 where Element == TestElement4 {}
    extension PrefixSequence: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension Range: SequenceOfTestElement2 where Bound == TestElement2 {}

    extension ReversedCollection.Iterator: SequenceOfTestElement where Element == TestElement {}
    extension ReversedCollection.Iterator: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension ReversedCollection.Iterator: SequenceOfTestElement2 where Element == TestElement2 {}
    extension ReversedCollection.Iterator: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension ReversedCollection.Iterator: SequenceOfTestElement3 where Element == TestElement3 {}
    extension ReversedCollection.Iterator: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension ReversedCollection.Iterator: SequenceOfTestElement4 where Element == TestElement4 {}
    extension ReversedCollection.Iterator: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

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
    extension TestSequence: SequenceOfTestElement2 where Element == TestElement2 {}
    extension TestSequence: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension TestSequence: SequenceOfTestElement3 where Element == TestElement3 {}
    extension TestSequence: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension TestSequence: SequenceOfTestElement4 where Element == TestElement4 {}
    extension TestSequence: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif
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

    extension TestSequence2: SequenceOfBool where Element == Bool {}
    extension TestSequence2: SequenceOfOptionalBool where Element == Bool? {}
    extension TestSequence2: SequenceOfInt where Element == Int {}
    extension TestSequence2: SequenceOfOptionalInt where Element == Int? {}

    extension TestSequence3: SequenceOfBool where Element == Bool {}
    extension TestSequence3: SequenceOfOptionalBool where Element == Bool? {}
    extension TestSequence3: SequenceOfCharacter where Element == Character {}
    extension TestSequence3: SequenceOfOptionalCharacter where Element == Character? {}
    extension TestSequence3: SequenceOfDouble where Element == Double {}
    extension TestSequence3: SequenceOfOptionalDouble where Element == Double? {}
    extension TestSequence3: SequenceOfFloat where Element == Float {}
    extension TestSequence3: SequenceOfOptionalFloat where Element == Float? {}
    #if os(macOS)
    extension TestSequence3: SequenceOfFloat80 where Element == Float80 {}
    extension TestSequence3: SequenceOfOptionalFloat80 where Element == Float80? {}
    #endif
    extension TestSequence3: SequenceOfInt where Element == Int {}
    extension TestSequence3: SequenceOfOptionalInt where Element == Int? {}
    extension TestSequence3: SequenceOfInt16 where Element == Int16 {}
    extension TestSequence3: SequenceOfOptionalInt16 where Element == Int16? {}
    extension TestSequence3: SequenceOfInt32 where Element == Int32 {}
    extension TestSequence3: SequenceOfOptionalInt32 where Element == Int32? {}
    extension TestSequence3: SequenceOfInt64 where Element == Int64 {}
    extension TestSequence3: SequenceOfOptionalInt64 where Element == Int64? {}
    extension TestSequence3: SequenceOfInt8 where Element == Int8 {}
    extension TestSequence3: SequenceOfOptionalInt8 where Element == Int8? {}
    extension TestSequence3: SequenceOfStringUTF16ViewElement where Element == String.UTF16View.Element {}
    extension TestSequence3: SequenceOfOptionalStringUTF16ViewElement where Element == String.UTF16View.Element? {}
    extension TestSequence3: SequenceOfSubstring where Element == Substring {}
    extension TestSequence3: SequenceOfOptionalSubstring where Element == Substring? {}
    extension TestSequence3: SequenceOfTestElement where Element == TestElement {}
    extension TestSequence3: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension TestSequence3: SequenceOfTestElement2 where Element == TestElement2 {}
    extension TestSequence3: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension TestSequence3: SequenceOfTestElement3 where Element == TestElement3 {}
    extension TestSequence3: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension TestSequence3: SequenceOfTestElement4 where Element == TestElement4 {}
    extension TestSequence3: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif
    extension TestSequence3: SequenceOfUInt where Element == UInt {}
    extension TestSequence3: SequenceOfOptionalUInt where Element == UInt? {}
    extension TestSequence3: SequenceOfUInt16 where Element == UInt16 {}
    extension TestSequence3: SequenceOfOptionalUInt16 where Element == UInt16? {}
    extension TestSequence3: SequenceOfUInt32 where Element == UInt32 {}
    extension TestSequence3: SequenceOfOptionalUInt32 where Element == UInt32? {}
    extension TestSequence3: SequenceOfUInt64 where Element == UInt64 {}
    extension TestSequence3: SequenceOfOptionalUInt64 where Element == UInt64? {}
    extension TestSequence3: SequenceOfUInt8 where Element == UInt8 {}
    extension TestSequence3: SequenceOfOptionalUInt8 where Element == UInt8? {}
    extension TestSequence3: SequenceOfUTF16CodeUnit where Element == UTF16.CodeUnit {}
    extension TestSequence3: SequenceOfOptionalUTF16CodeUnit where Element == UTF16.CodeUnit? {}
    extension TestSequence3: SequenceOfUTF8CodeUnit where Element == UTF8.CodeUnit {}
    extension TestSequence3: SequenceOfOptionalUTF8CodeUnit where Element == UTF8.CodeUnit? {}
    extension TestSequence3: SequenceOfUnicodeScalar where Element == Unicode.Scalar {}
    extension TestSequence3: SequenceOfOptionalUnicodeScalar where Element == Unicode.Scalar? {}

    extension UnfoldSequence: SequenceOfTestElement where Element == TestElement {}
    extension UnfoldSequence: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension UnfoldSequence: SequenceOfTestElement2 where Element == TestElement2 {}
    extension UnfoldSequence: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension UnfoldSequence: SequenceOfTestElement3 where Element == TestElement3 {}
    extension UnfoldSequence: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension UnfoldSequence: SequenceOfTestElement4 where Element == TestElement4 {}
    extension UnfoldSequence: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif

    extension UnsafeBufferPointer: SequenceOfTestElement where Element == TestElement {}
    extension UnsafeBufferPointer: SequenceOfOptionalTestElement where Element == TestElement? {}
    extension UnsafeBufferPointer: SequenceOfTestElement2 where Element == TestElement2 {}
    extension UnsafeBufferPointer: SequenceOfOptionalTestElement2 where Element == TestElement2? {}
    extension UnsafeBufferPointer: SequenceOfTestElement3 where Element == TestElement3 {}
    extension UnsafeBufferPointer: SequenceOfOptionalTestElement3 where Element == TestElement3? {}
    #if os(iOS)
    extension UnsafeBufferPointer: SequenceOfTestElement4 where Element == TestElement4 {}
    extension UnsafeBufferPointer: SequenceOfOptionalTestElement4 where Element == TestElement4? {}
    #endif
    """
}
