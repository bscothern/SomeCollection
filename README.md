# SomeCollection

[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/Carthage/Carthage/master/LICENSE.md)[![SPM](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager)

A Swift Package to simplify working with Opaque Collections and Sequences.

## Why Use SomeCollection
When working with a PATs (protocol with assoicatedtype) as an opaque type the `assoicatedtype` informantion is lost and becomes opaque as well.
This means that if you are wanting to reutrn `some Sequence` or `some Collection` or `some LazySequenceProtocol` or `some LazyCollectionProtocol` the `Element` type will be lost.

SomeCollection has been created to be able to help make it easy to return the `Sequence`/`Collection` PATs as the opaque type without losing what `Element` is.
This is accomplished by providing protocols and conformances to these protocols such as: `CollectionOfInt` which ensures you are getting a `Collection` where the `Element` type is `Int`.
This is essentially the same as if you could say: `some Collection<Int>`.

## Swift Package Manager
Update your `Package.swift` or Xcode 11+ to include this package as a dependency:
```swift
.package(url: "https://github.com/bscothern/SomeCollection.git", from: "1.0.0")
```

## Usage
```swift
import SomeCollection

func foo() -> some CollectionOfInt {
    [1, 2, 3, 4]
}

print(foo().map({ $0 * 2 }))
// [2, 4, 6, 8]

```

## Supported Sequences and Collections
Here is a list of the common sequence and collection types supported.
More are supported but they are less common and not listed here.

* Array
* Set
* Range Types
* Dictionary.Values
* Dictionary.Keys
* Unsafe[Mutable][Raw][Buffer]Pointer
* LazySequence Types

## Supported Element Types
Here is a list the common element types supported.
More are supported but they are less common and not listed here.
* Int
* Int8
* Int16
* Int32
* Int64
* UInt
* UInt8
* UInt16
* UInt32
* UInt64
* Double
* Float
* Bool
* Error
* String
* Substring
* Character

## Supporting Custom Types
SomeCollection has been designed from the start to support custom types.
`MakeSomeCollectionLib` is the engine used to generate the `SomeCollection` library.
It has been setup so users can depend on it to have their own `MakeSomeCollectionOfYourOrgName` to generate their own additional conformances to `Sequence`, `Collection`, or `Element` types.

You can do this by creating your swift package and having it depend on this package.
Create an executable and target along the lines of `MakeSomeCollectionOfYourOrgName` that makes sense for you and have its target depend on `MakeSomeCollectionLib`.

It is recommended that your library of generated code be called: `SomeCollectionofYourOrgName`

You then need to modify the target's `main.swift` to be similar to this:
```swift
import MakeSomeCollectionLib

// YourOrg's Custom Sequences
let sequences: Set<SequenceType> = [
    "CustomSequence1",
    "CustomSequence2",
]

// YourOrg's Custom Collections
let collections: Set<CollectionType> = [
    "CustomCollection1",
    "CustomCollection2",
]

// YourOrg's Elements
let elements: Set<ElementType> = [
    "Element1",
    "Element2",
]

// The matrix of new elements to generate conformances for.
let matrix = GenerationMatrix(
sequenceTypes: sequences.union(StandardLibrarySequenceType.values),
    collectionTypes: collections.union(StandardLibraryCollectionType.values),
    elementTypes: elements.union(StandardLibraryElementType.values)
)

let generator = Generator(matrix: matrix)
try! generator.generate(
    name: "SomeCollectionOfYourOrgLibrary",
    into: "Sources/SomeCollectionOfYourOrg",
    imports: ["YourOrgLibrary"]
)
```

When doing this it is recommended but not required to have the `union()` calls with the types defined in `MakeSomeCollectionLib`.
These sets contain all of the types used to generate `SomeCollection`.
By providing the standard library types they will have conformances added to support any new protocols generated through your `Element` types and your `Sequence` and `Collection` types will get conformances to the protocols that already exist in `SomeCollection`.
If the standard library types are provided or not your `Sequence` and `Collection` types will get conformances to support the new protocols generated from your `Element` types.

`SeqeunceType`, `CollectionType`, and `ElementType` all support customization to limit the platforms and/or other types they work with.
These can be accessed thorugh calling the initializer directly instead of just specifying the name as a `String` as shown in the example above.
The customization points have been documented so it is easy to work with as you support your own types.
If you want a more complex example look at `makeTestOutput()` in `MakeSomeCollectionLibTests.swift` which is very similar to what a `main.swift` would need to be to use `MakeSomeCollectionLib`.

All generated code is stable in its ordering as long as it is given the same inputs.
This helps to cut down on conflicts and identifying what changes.

## A Sequence/Collection/Element Type is Missing!?
I have almost certainly missed types and new ones can be added to the standard library each release.
In this case you can either open an issue or PR.
* If you open an issue please specify what the type is and I will add support for it if it is in the standard library.
* If you want to submit a PR you will need to update `Sources/MakeSomeCollectionLib/StandardLibraryTypes` files to know about the new type. Once you have updated the type lists use `swift run` to have the `SomeCollection` library rebuild.

### What about Foundation?
I am planning on adding support for Foundation types right away and should have them very soon.
They will likely be a part of this same package but in a different library which will likely be named: `SomeCollectionOfFoundation`.

## Some Other Bug/Feature Request
Open up an issue on github.
