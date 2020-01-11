//
// SomeCollectionProtocols.swift
//
// Auto Generated
// MakeSomeCollectionLib 0.1.0
// 2020-01-11
//

public protocol SequenceOfBool: Sequence where Element == Bool {}
public protocol CollectionOfBool: Collection, SequenceOfBool {}
public protocol SequenceOfOptionalBool: Sequence where Element == Bool? {}
public protocol CollectionOfOptionalBool: Collection, SequenceOfOptionalBool {}

public protocol SequenceOfDouble: Sequence where Element == Double {}
public protocol CollectionOfDouble: Collection, SequenceOfDouble {}
public protocol SequenceOfOptionalDouble: Sequence where Element == Double? {}
public protocol CollectionOfOptionalDouble: Collection, SequenceOfOptionalDouble {}

public protocol SequenceOfError: Sequence where Element == Error {}
public protocol CollectionOfError: Collection, SequenceOfError {}
public protocol SequenceOfOptionalError: Sequence where Element == Error? {}
public protocol CollectionOfOptionalError: Collection, SequenceOfOptionalError {}

public protocol SequenceOfFloat: Sequence where Element == Float {}
public protocol CollectionOfFloat: Collection, SequenceOfFloat {}
public protocol SequenceOfOptionalFloat: Sequence where Element == Float? {}
public protocol CollectionOfOptionalFloat: Collection, SequenceOfOptionalFloat {}

#if os(macOS)
public protocol SequenceOfFloat80: Sequence where Element == Float80 {}
public protocol CollectionOfFloat80: Collection, SequenceOfFloat80 {}
public protocol SequenceOfOptionalFloat80: Sequence where Element == Float80? {}
public protocol CollectionOfOptionalFloat80: Collection, SequenceOfOptionalFloat80 {}
#endif

public protocol SequenceOfInt: Sequence where Element == Int {}
public protocol CollectionOfInt: Collection, SequenceOfInt {}
public protocol SequenceOfOptionalInt: Sequence where Element == Int? {}
public protocol CollectionOfOptionalInt: Collection, SequenceOfOptionalInt {}

public protocol SequenceOfInt16: Sequence where Element == Int16 {}
public protocol CollectionOfInt16: Collection, SequenceOfInt16 {}
public protocol SequenceOfOptionalInt16: Sequence where Element == Int16? {}
public protocol CollectionOfOptionalInt16: Collection, SequenceOfOptionalInt16 {}

public protocol SequenceOfInt32: Sequence where Element == Int32 {}
public protocol CollectionOfInt32: Collection, SequenceOfInt32 {}
public protocol SequenceOfOptionalInt32: Sequence where Element == Int32? {}
public protocol CollectionOfOptionalInt32: Collection, SequenceOfOptionalInt32 {}

public protocol SequenceOfInt64: Sequence where Element == Int64 {}
public protocol CollectionOfInt64: Collection, SequenceOfInt64 {}
public protocol SequenceOfOptionalInt64: Sequence where Element == Int64? {}
public protocol CollectionOfOptionalInt64: Collection, SequenceOfOptionalInt64 {}

public protocol SequenceOfInt8: Sequence where Element == Int8 {}
public protocol CollectionOfInt8: Collection, SequenceOfInt8 {}
public protocol SequenceOfOptionalInt8: Sequence where Element == Int8? {}
public protocol CollectionOfOptionalInt8: Collection, SequenceOfOptionalInt8 {}

public protocol SequenceOfString: Sequence where Element == String {}
public protocol CollectionOfString: Collection, SequenceOfString {}
public protocol SequenceOfOptionalString: Sequence where Element == String? {}
public protocol CollectionOfOptionalString: Collection, SequenceOfOptionalString {}

public protocol SequenceOfSubstring: Sequence where Element == Substring {}
public protocol CollectionOfSubstring: Collection, SequenceOfSubstring {}
public protocol SequenceOfOptionalSubstring: Sequence where Element == Substring? {}
public protocol CollectionOfOptionalSubstring: Collection, SequenceOfOptionalSubstring {}

public protocol SequenceOfUInt: Sequence where Element == UInt {}
public protocol CollectionOfUInt: Collection, SequenceOfUInt {}
public protocol SequenceOfOptionalUInt: Sequence where Element == UInt? {}
public protocol CollectionOfOptionalUInt: Collection, SequenceOfOptionalUInt {}

public protocol SequenceOfUInt16: Sequence where Element == UInt16 {}
public protocol CollectionOfUInt16: Collection, SequenceOfUInt16 {}
public protocol SequenceOfOptionalUInt16: Sequence where Element == UInt16? {}
public protocol CollectionOfOptionalUInt16: Collection, SequenceOfOptionalUInt16 {}

public protocol SequenceOfUInt32: Sequence where Element == UInt32 {}
public protocol CollectionOfUInt32: Collection, SequenceOfUInt32 {}
public protocol SequenceOfOptionalUInt32: Sequence where Element == UInt32? {}
public protocol CollectionOfOptionalUInt32: Collection, SequenceOfOptionalUInt32 {}

public protocol SequenceOfUInt64: Sequence where Element == UInt64 {}
public protocol CollectionOfUInt64: Collection, SequenceOfUInt64 {}
public protocol SequenceOfOptionalUInt64: Sequence where Element == UInt64? {}
public protocol CollectionOfOptionalUInt64: Collection, SequenceOfOptionalUInt64 {}

public protocol SequenceOfUInt8: Sequence where Element == UInt8 {}
public protocol CollectionOfUInt8: Collection, SequenceOfUInt8 {}
public protocol SequenceOfOptionalUInt8: Sequence where Element == UInt8? {}
public protocol CollectionOfOptionalUInt8: Collection, SequenceOfOptionalUInt8 {}
