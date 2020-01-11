# SomeCollection

[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/Carthage/Carthage/master/LICENSE.md)[![SPM](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager)

A Swift Package to simplify working with Opaque Collections and Sequences.

## Swift Package Manager
Update your `Package.swift` or Xcode to include this package as a dependency:
```
.package(url: "https://github.com/bscothern/SomeCollection.git", from: "1.0.0")
```

## Usage
```
import SomeCollection

func foo() -> some CollectionOfInt {
    [1, 2, 3, 4]
}

print(foo().map({ $0 * 2 })
// [2, 4, 6, 8]

```
