//
// SomeCollectionProtocols.swift
//
// Auto Generated
// MakeSomeCollectionLib 0.2.0
// 2020-01-11
//

public protocol SequenceOfBool: Sequence where Element == Bool {}
public protocol CollectionOfBool: Collection, SequenceOfBool {}
public protocol SequenceOfOptionalBool: Sequence where Element == Bool? {}
public protocol CollectionOfOptionalBool: Collection, SequenceOfOptionalBool {}
public protocol LazySequenceOfBool: LazySequenceProtocol, SequenceOfBool {}
public protocol LazyCollectionOfBool: LazyCollectionProtocol, CollectionOfBool {}
public protocol LazySequenceOfOptionalBool: LazySequenceProtocol, SequenceOfOptionalBool {}
public protocol LazyCollectionOfOptionalBool: LazyCollectionProtocol, CollectionOfOptionalBool {}

public protocol SequenceOfCharacter: Sequence where Element == Character {}
public protocol CollectionOfCharacter: Collection, SequenceOfCharacter {}
public protocol SequenceOfOptionalCharacter: Sequence where Element == Character? {}
public protocol CollectionOfOptionalCharacter: Collection, SequenceOfOptionalCharacter {}
public protocol LazySequenceOfCharacter: LazySequenceProtocol, SequenceOfCharacter {}
public protocol LazyCollectionOfCharacter: LazyCollectionProtocol, CollectionOfCharacter {}
public protocol LazySequenceOfOptionalCharacter: LazySequenceProtocol, SequenceOfOptionalCharacter {}
public protocol LazyCollectionOfOptionalCharacter: LazyCollectionProtocol, CollectionOfOptionalCharacter {}

public protocol SequenceOfDouble: Sequence where Element == Double {}
public protocol CollectionOfDouble: Collection, SequenceOfDouble {}
public protocol SequenceOfOptionalDouble: Sequence where Element == Double? {}
public protocol CollectionOfOptionalDouble: Collection, SequenceOfOptionalDouble {}
public protocol LazySequenceOfDouble: LazySequenceProtocol, SequenceOfDouble {}
public protocol LazyCollectionOfDouble: LazyCollectionProtocol, CollectionOfDouble {}
public protocol LazySequenceOfOptionalDouble: LazySequenceProtocol, SequenceOfOptionalDouble {}
public protocol LazyCollectionOfOptionalDouble: LazyCollectionProtocol, CollectionOfOptionalDouble {}

public protocol SequenceOfError: Sequence where Element == Error {}
public protocol CollectionOfError: Collection, SequenceOfError {}
public protocol SequenceOfOptionalError: Sequence where Element == Error? {}
public protocol CollectionOfOptionalError: Collection, SequenceOfOptionalError {}
public protocol LazySequenceOfError: LazySequenceProtocol, SequenceOfError {}
public protocol LazyCollectionOfError: LazyCollectionProtocol, CollectionOfError {}
public protocol LazySequenceOfOptionalError: LazySequenceProtocol, SequenceOfOptionalError {}
public protocol LazyCollectionOfOptionalError: LazyCollectionProtocol, CollectionOfOptionalError {}

public protocol SequenceOfFloat: Sequence where Element == Float {}
public protocol CollectionOfFloat: Collection, SequenceOfFloat {}
public protocol SequenceOfOptionalFloat: Sequence where Element == Float? {}
public protocol CollectionOfOptionalFloat: Collection, SequenceOfOptionalFloat {}
public protocol LazySequenceOfFloat: LazySequenceProtocol, SequenceOfFloat {}
public protocol LazyCollectionOfFloat: LazyCollectionProtocol, CollectionOfFloat {}
public protocol LazySequenceOfOptionalFloat: LazySequenceProtocol, SequenceOfOptionalFloat {}
public protocol LazyCollectionOfOptionalFloat: LazyCollectionProtocol, CollectionOfOptionalFloat {}

#if os(macOS)
public protocol SequenceOfFloat80: Sequence where Element == Float80 {}
public protocol CollectionOfFloat80: Collection, SequenceOfFloat80 {}
public protocol SequenceOfOptionalFloat80: Sequence where Element == Float80? {}
public protocol CollectionOfOptionalFloat80: Collection, SequenceOfOptionalFloat80 {}
public protocol LazySequenceOfFloat80: LazySequenceProtocol, SequenceOfFloat80 {}
public protocol LazyCollectionOfFloat80: LazyCollectionProtocol, CollectionOfFloat80 {}
public protocol LazySequenceOfOptionalFloat80: LazySequenceProtocol, SequenceOfOptionalFloat80 {}
public protocol LazyCollectionOfOptionalFloat80: LazyCollectionProtocol, CollectionOfOptionalFloat80 {}
#endif

public protocol SequenceOfInt: Sequence where Element == Int {}
public protocol CollectionOfInt: Collection, SequenceOfInt {}
public protocol SequenceOfOptionalInt: Sequence where Element == Int? {}
public protocol CollectionOfOptionalInt: Collection, SequenceOfOptionalInt {}
public protocol LazySequenceOfInt: LazySequenceProtocol, SequenceOfInt {}
public protocol LazyCollectionOfInt: LazyCollectionProtocol, CollectionOfInt {}
public protocol LazySequenceOfOptionalInt: LazySequenceProtocol, SequenceOfOptionalInt {}
public protocol LazyCollectionOfOptionalInt: LazyCollectionProtocol, CollectionOfOptionalInt {}

public protocol SequenceOfInt16: Sequence where Element == Int16 {}
public protocol CollectionOfInt16: Collection, SequenceOfInt16 {}
public protocol SequenceOfOptionalInt16: Sequence where Element == Int16? {}
public protocol CollectionOfOptionalInt16: Collection, SequenceOfOptionalInt16 {}
public protocol LazySequenceOfInt16: LazySequenceProtocol, SequenceOfInt16 {}
public protocol LazyCollectionOfInt16: LazyCollectionProtocol, CollectionOfInt16 {}
public protocol LazySequenceOfOptionalInt16: LazySequenceProtocol, SequenceOfOptionalInt16 {}
public protocol LazyCollectionOfOptionalInt16: LazyCollectionProtocol, CollectionOfOptionalInt16 {}

public protocol SequenceOfInt32: Sequence where Element == Int32 {}
public protocol CollectionOfInt32: Collection, SequenceOfInt32 {}
public protocol SequenceOfOptionalInt32: Sequence where Element == Int32? {}
public protocol CollectionOfOptionalInt32: Collection, SequenceOfOptionalInt32 {}
public protocol LazySequenceOfInt32: LazySequenceProtocol, SequenceOfInt32 {}
public protocol LazyCollectionOfInt32: LazyCollectionProtocol, CollectionOfInt32 {}
public protocol LazySequenceOfOptionalInt32: LazySequenceProtocol, SequenceOfOptionalInt32 {}
public protocol LazyCollectionOfOptionalInt32: LazyCollectionProtocol, CollectionOfOptionalInt32 {}

public protocol SequenceOfInt64: Sequence where Element == Int64 {}
public protocol CollectionOfInt64: Collection, SequenceOfInt64 {}
public protocol SequenceOfOptionalInt64: Sequence where Element == Int64? {}
public protocol CollectionOfOptionalInt64: Collection, SequenceOfOptionalInt64 {}
public protocol LazySequenceOfInt64: LazySequenceProtocol, SequenceOfInt64 {}
public protocol LazyCollectionOfInt64: LazyCollectionProtocol, CollectionOfInt64 {}
public protocol LazySequenceOfOptionalInt64: LazySequenceProtocol, SequenceOfOptionalInt64 {}
public protocol LazyCollectionOfOptionalInt64: LazyCollectionProtocol, CollectionOfOptionalInt64 {}

public protocol SequenceOfInt8: Sequence where Element == Int8 {}
public protocol CollectionOfInt8: Collection, SequenceOfInt8 {}
public protocol SequenceOfOptionalInt8: Sequence where Element == Int8? {}
public protocol CollectionOfOptionalInt8: Collection, SequenceOfOptionalInt8 {}
public protocol LazySequenceOfInt8: LazySequenceProtocol, SequenceOfInt8 {}
public protocol LazyCollectionOfInt8: LazyCollectionProtocol, CollectionOfInt8 {}
public protocol LazySequenceOfOptionalInt8: LazySequenceProtocol, SequenceOfOptionalInt8 {}
public protocol LazyCollectionOfOptionalInt8: LazyCollectionProtocol, CollectionOfOptionalInt8 {}

public protocol SequenceOfString: Sequence where Element == String {}
public protocol CollectionOfString: Collection, SequenceOfString {}
public protocol SequenceOfOptionalString: Sequence where Element == String? {}
public protocol CollectionOfOptionalString: Collection, SequenceOfOptionalString {}
public protocol LazySequenceOfString: LazySequenceProtocol, SequenceOfString {}
public protocol LazyCollectionOfString: LazyCollectionProtocol, CollectionOfString {}
public protocol LazySequenceOfOptionalString: LazySequenceProtocol, SequenceOfOptionalString {}
public protocol LazyCollectionOfOptionalString: LazyCollectionProtocol, CollectionOfOptionalString {}

public protocol SequenceOfStringUTF16ViewElement: Sequence where Element == String.UTF16View.Element {}
public protocol CollectionOfStringUTF16ViewElement: Collection, SequenceOfStringUTF16ViewElement {}
public protocol SequenceOfOptionalStringUTF16ViewElement: Sequence where Element == String.UTF16View.Element? {}
public protocol CollectionOfOptionalStringUTF16ViewElement: Collection, SequenceOfOptionalStringUTF16ViewElement {}
public protocol LazySequenceOfStringUTF16ViewElement: LazySequenceProtocol, SequenceOfStringUTF16ViewElement {}
public protocol LazyCollectionOfStringUTF16ViewElement: LazyCollectionProtocol, CollectionOfStringUTF16ViewElement {}
public protocol LazySequenceOfOptionalStringUTF16ViewElement: LazySequenceProtocol, SequenceOfOptionalStringUTF16ViewElement {}
public protocol LazyCollectionOfOptionalStringUTF16ViewElement: LazyCollectionProtocol, CollectionOfOptionalStringUTF16ViewElement {}

public protocol SequenceOfSubstring: Sequence where Element == Substring {}
public protocol CollectionOfSubstring: Collection, SequenceOfSubstring {}
public protocol SequenceOfOptionalSubstring: Sequence where Element == Substring? {}
public protocol CollectionOfOptionalSubstring: Collection, SequenceOfOptionalSubstring {}
public protocol LazySequenceOfSubstring: LazySequenceProtocol, SequenceOfSubstring {}
public protocol LazyCollectionOfSubstring: LazyCollectionProtocol, CollectionOfSubstring {}
public protocol LazySequenceOfOptionalSubstring: LazySequenceProtocol, SequenceOfOptionalSubstring {}
public protocol LazyCollectionOfOptionalSubstring: LazyCollectionProtocol, CollectionOfOptionalSubstring {}

public protocol SequenceOfUInt: Sequence where Element == UInt {}
public protocol CollectionOfUInt: Collection, SequenceOfUInt {}
public protocol SequenceOfOptionalUInt: Sequence where Element == UInt? {}
public protocol CollectionOfOptionalUInt: Collection, SequenceOfOptionalUInt {}
public protocol LazySequenceOfUInt: LazySequenceProtocol, SequenceOfUInt {}
public protocol LazyCollectionOfUInt: LazyCollectionProtocol, CollectionOfUInt {}
public protocol LazySequenceOfOptionalUInt: LazySequenceProtocol, SequenceOfOptionalUInt {}
public protocol LazyCollectionOfOptionalUInt: LazyCollectionProtocol, CollectionOfOptionalUInt {}

public protocol SequenceOfUInt16: Sequence where Element == UInt16 {}
public protocol CollectionOfUInt16: Collection, SequenceOfUInt16 {}
public protocol SequenceOfOptionalUInt16: Sequence where Element == UInt16? {}
public protocol CollectionOfOptionalUInt16: Collection, SequenceOfOptionalUInt16 {}
public protocol LazySequenceOfUInt16: LazySequenceProtocol, SequenceOfUInt16 {}
public protocol LazyCollectionOfUInt16: LazyCollectionProtocol, CollectionOfUInt16 {}
public protocol LazySequenceOfOptionalUInt16: LazySequenceProtocol, SequenceOfOptionalUInt16 {}
public protocol LazyCollectionOfOptionalUInt16: LazyCollectionProtocol, CollectionOfOptionalUInt16 {}

public protocol SequenceOfUInt32: Sequence where Element == UInt32 {}
public protocol CollectionOfUInt32: Collection, SequenceOfUInt32 {}
public protocol SequenceOfOptionalUInt32: Sequence where Element == UInt32? {}
public protocol CollectionOfOptionalUInt32: Collection, SequenceOfOptionalUInt32 {}
public protocol LazySequenceOfUInt32: LazySequenceProtocol, SequenceOfUInt32 {}
public protocol LazyCollectionOfUInt32: LazyCollectionProtocol, CollectionOfUInt32 {}
public protocol LazySequenceOfOptionalUInt32: LazySequenceProtocol, SequenceOfOptionalUInt32 {}
public protocol LazyCollectionOfOptionalUInt32: LazyCollectionProtocol, CollectionOfOptionalUInt32 {}

public protocol SequenceOfUInt64: Sequence where Element == UInt64 {}
public protocol CollectionOfUInt64: Collection, SequenceOfUInt64 {}
public protocol SequenceOfOptionalUInt64: Sequence where Element == UInt64? {}
public protocol CollectionOfOptionalUInt64: Collection, SequenceOfOptionalUInt64 {}
public protocol LazySequenceOfUInt64: LazySequenceProtocol, SequenceOfUInt64 {}
public protocol LazyCollectionOfUInt64: LazyCollectionProtocol, CollectionOfUInt64 {}
public protocol LazySequenceOfOptionalUInt64: LazySequenceProtocol, SequenceOfOptionalUInt64 {}
public protocol LazyCollectionOfOptionalUInt64: LazyCollectionProtocol, CollectionOfOptionalUInt64 {}

public protocol SequenceOfUInt8: Sequence where Element == UInt8 {}
public protocol CollectionOfUInt8: Collection, SequenceOfUInt8 {}
public protocol SequenceOfOptionalUInt8: Sequence where Element == UInt8? {}
public protocol CollectionOfOptionalUInt8: Collection, SequenceOfOptionalUInt8 {}
public protocol LazySequenceOfUInt8: LazySequenceProtocol, SequenceOfUInt8 {}
public protocol LazyCollectionOfUInt8: LazyCollectionProtocol, CollectionOfUInt8 {}
public protocol LazySequenceOfOptionalUInt8: LazySequenceProtocol, SequenceOfOptionalUInt8 {}
public protocol LazyCollectionOfOptionalUInt8: LazyCollectionProtocol, CollectionOfOptionalUInt8 {}

public protocol SequenceOfUTF16CodeUnit: Sequence where Element == UTF16.CodeUnit {}
public protocol CollectionOfUTF16CodeUnit: Collection, SequenceOfUTF16CodeUnit {}
public protocol SequenceOfOptionalUTF16CodeUnit: Sequence where Element == UTF16.CodeUnit? {}
public protocol CollectionOfOptionalUTF16CodeUnit: Collection, SequenceOfOptionalUTF16CodeUnit {}
public protocol LazySequenceOfUTF16CodeUnit: LazySequenceProtocol, SequenceOfUTF16CodeUnit {}
public protocol LazyCollectionOfUTF16CodeUnit: LazyCollectionProtocol, CollectionOfUTF16CodeUnit {}
public protocol LazySequenceOfOptionalUTF16CodeUnit: LazySequenceProtocol, SequenceOfOptionalUTF16CodeUnit {}
public protocol LazyCollectionOfOptionalUTF16CodeUnit: LazyCollectionProtocol, CollectionOfOptionalUTF16CodeUnit {}

public protocol SequenceOfUTF8CodeUnit: Sequence where Element == UTF8.CodeUnit {}
public protocol CollectionOfUTF8CodeUnit: Collection, SequenceOfUTF8CodeUnit {}
public protocol SequenceOfOptionalUTF8CodeUnit: Sequence where Element == UTF8.CodeUnit? {}
public protocol CollectionOfOptionalUTF8CodeUnit: Collection, SequenceOfOptionalUTF8CodeUnit {}
public protocol LazySequenceOfUTF8CodeUnit: LazySequenceProtocol, SequenceOfUTF8CodeUnit {}
public protocol LazyCollectionOfUTF8CodeUnit: LazyCollectionProtocol, CollectionOfUTF8CodeUnit {}
public protocol LazySequenceOfOptionalUTF8CodeUnit: LazySequenceProtocol, SequenceOfOptionalUTF8CodeUnit {}
public protocol LazyCollectionOfOptionalUTF8CodeUnit: LazyCollectionProtocol, CollectionOfOptionalUTF8CodeUnit {}

public protocol SequenceOfUnicodeScalar: Sequence where Element == Unicode.Scalar {}
public protocol CollectionOfUnicodeScalar: Collection, SequenceOfUnicodeScalar {}
public protocol SequenceOfOptionalUnicodeScalar: Sequence where Element == Unicode.Scalar? {}
public protocol CollectionOfOptionalUnicodeScalar: Collection, SequenceOfOptionalUnicodeScalar {}
public protocol LazySequenceOfUnicodeScalar: LazySequenceProtocol, SequenceOfUnicodeScalar {}
public protocol LazyCollectionOfUnicodeScalar: LazyCollectionProtocol, CollectionOfUnicodeScalar {}
public protocol LazySequenceOfOptionalUnicodeScalar: LazySequenceProtocol, SequenceOfOptionalUnicodeScalar {}
public protocol LazyCollectionOfOptionalUnicodeScalar: LazyCollectionProtocol, CollectionOfOptionalUnicodeScalar {}
