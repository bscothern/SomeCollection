//
// SomeCollectionProtocols.swift
//
// Auto Generated
// MakeSomeCollectionLib 0.1.0
// 2020-01-11
//

public protocol SequenceOfDouble: Sequence where Element == Double {}
public protocol CollectionOfDouble: Collection, SequenceOfDouble {}

public protocol SequenceOfFloat: Sequence where Element == Float {}
public protocol CollectionOfFloat: Collection, SequenceOfFloat {}

#if os(macOS)
public protocol SequenceOfFloat80: Sequence where Element == Float80 {}
public protocol CollectionOfFloat80: Collection, SequenceOfFloat80 {}
#endif

public protocol SequenceOfInt: Sequence where Element == Int {}
public protocol CollectionOfInt: Collection, SequenceOfInt {}

public protocol SequenceOfInt16: Sequence where Element == Int16 {}
public protocol CollectionOfInt16: Collection, SequenceOfInt16 {}

public protocol SequenceOfInt32: Sequence where Element == Int32 {}
public protocol CollectionOfInt32: Collection, SequenceOfInt32 {}

public protocol SequenceOfInt64: Sequence where Element == Int64 {}
public protocol CollectionOfInt64: Collection, SequenceOfInt64 {}

public protocol SequenceOfInt8: Sequence where Element == Int8 {}
public protocol CollectionOfInt8: Collection, SequenceOfInt8 {}
