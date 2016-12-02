# Reflection-Extensions

## Install

Add this package to your `Package.swift`:

```swift
import PackageDescription

let package = Package(
    name: "MyPackage",
    dependencies: [
        .Package(url: "https://github.com/Evertt/Reflection-Extensions.git", majorVersion: 0),
    ]
)
```

## Features

This is an extension to [Zewo's Reflection package](https://github.com/Zewo/Reflection)
and I hope to delete this repository if brad is willing to incorporate these features in his repo.

So this extension offers a different format in which to receive the properties of an instance or a type.
When you use the `properties` method of Zewo's reflection you get an array of [Zewo's `Property` type](https://github.com/Zewo/Reflection/blob/master/Sources/Reflection/Properties.swift#L15).
That type offers you only two data-points about the property, namely its name (which is a `String`) and its value (which is an `Any`).

If you would want to know more about the property, like for example if it's an optional or not, Zewo doesn't help you with that.
So that's what this package does for you. So here are a few things you can do with this package:

```swift
import ReflectionExtensions

struct Foo {
    let required: Int  = 1
    let optional: Int? = 2
    
    lazy var lazyRequired: Int  = 3
    lazy var lazyOptional: Int? = 4
}

let foo = Foo()
let fooProps = properties(foo)

for (key, property) in fooProps where property.isLazy {
    print(key, property.value)
    // that prints the key of all lazy properties and their values
    // which at this point are nil, because they haven't been initialized yet
}

foo.lazyOptional // this initializes the property

for (key, property) in fooProps where property.isLazy && property.isInitialized {
    print(key, property.value)
    // that prints only the key and value of lazyOptional
}

for (key, property) in fooProps where !property.isOptional {
    print(key, property.value)
    // that prints the key of `required` and `lazyRequired` and their values or nil
}

// finally, you can also access the properties as an enum, because that's what they actually are.

for (key, property) in fooProps {
    switch property {
    case let .normal(normal):
        switch normal {
        case let .required(value):
            print(value)
        case let .optional(optionalValue):
            print(optionalValue)
        }
    case let .lazy(lazy):
        switch lazy {
        case let .initialized(normal):
            switch normal {
            case let .required(value):
                print(value)
            case let .optional(optionalValue):
                print(optionalValue)
            }
        case let .uninitialized(propertyType):
            switch propertyType {
            case let .required(type):
                print("required:", type)
            case let .optional(type):
                print("optional:", type)
            }
        }
    }
}
```
