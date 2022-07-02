# MathExpression framework

[![Coverage Status](https://coveralls.io/repos/github/peredaniel/MathExpression/badge.svg?branch=master)](https://coveralls.io/github/peredaniel/MathExpression?branch=master)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/MathExpression.svg?style=flat)](http://cocoapods.org/pods/MathExpression)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://swift.org/package-manager/)
[![License](https://img.shields.io/github/license/peredaniel/MathExpression)](https://github.com/peredaniel/MathExpression/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/MathExpression.svg?style=flat)](http://cocoapods.org/pods/MathExpression)
[![Language: Swift 5.0](https://img.shields.io/badge/Swift-5.0-green.svg)](https://swift.org/)

MathExpression is a Swift library that provides an API to parse and evaluate arithmetic mathematical expressions given by a `String` instance. It is compatible with iOS, tvOS and macOS.

Furthermore, the initializer admits an additional optional parameter called `transformation`, which is a block taking a `String` instance and returning a `Double`. This provides a great deal of flexibility when creating custom expression, since we can pass in non-numerical strings that can be evaluated using the transformation.

## Requirements

| Version         | Requirements                                                     |
|:----------------|:-----------------------------------------------------------------|
| 1.3.0 or higher | Xcode 13.0+<br>Swift 5.0+<br>iOS 12.0+, tvOS 12.0+, macOS 10.14+ |
| 1.1.0 - 1.2.0   | Xcode 10.0+<br>Swift 4.2+<br>iOS 10.0+, tvOS 10.0+, macOS 10.10+ |
| 1.0.0 and 1.0.1 | Xcode 10.0+<br>Swift 4.2+<br>iOS 10.0+                           |

Starting on version 1.3.0 we bumped the IDE, Swift and platforms requirements to the above. Note that although it's specified Xcode 13.0 as a minimum, there is nothing specific to that Xcode version being used. Therefore, the package should be compatible in projects which are unable to use Xcode 13.

## Installation

You may install the framework either manually, or through a dependency manager.

### Using CocoaPods

To use CocoaPods, first make sure you have installed it and updated it to the latest version by following their instructions on [cocoapods.org](https://cocoapods.org). Then, you should complete the following steps

1. Add MathExpression to your `Podfile`:

```ruby
pod 'MathExpression', '~>1.3.0'
```

2. Update your pod sources and install the new pod by executing the following command in command line:

```
$ pod install --repo-update
```

### Using Carthage

To use Carthage, first make sure you have installed it and updated it to the latest version by following their instructions on [their repo](https://github.com/Carthage/Carthage).

1. Add MathExpression to your `Cartfile`:

```ruby
github "peredaniel/MathExpression" ~> 1.3.0
```

2. Install the new framework by running Carthage:

```
$ carthage update
```

### Using Swift Package Manager

To install using Swift Package Manager, add this to the `dependencies` section in your `Package.swift` file:

```swift
.package(url: "https://github.com/peredaniel/MathExpression.git", .upToNextMinor(from: "1.3.0")),
```

### Manual installation

We encourage using a dependency manager to install your dependencies, but in case you can't use any you may install the framework manually as follows:

1. Clone or download this repository.
2. Drag the folder `Source` contained within the `MathExpression` folder into your project.

### Detailed instructions

Still having problems with the installation? Take a look at our [step-by-step installation guide](Documentation/INSTALLATION_GUIDE.md)!

## Getting started

After installing the framework by any means of the above described, you can import the module by adding the following line in the "header" of any of your swift files:
```swift
import MathExpression
```

Then, you may initialize an instance of `MathExpression` (let's say, with the expression `(3 + 4) * 9`) at any point using the following code:
```swift
let expression = try MathExpression("(3 + 4) * 9")
```

Then, you may use the following code to obtain the computed value of the expression:
```swift
let value = expression.evaluate() // 63.0
```

### Built-in operators

There are several operators that are already built-in in the framework, and therefore they are considered **reserved characters** when creating a new instance of a `MathExpression`. The list of operators already implemented is the following:
* **Sum**, with reserved character `+`.
* **Subtraction**, with reserved character `-`.
* **Product**, with reserved character `*`.
* **Division**, with reserved character `/`.
* **Negative**, with reserved character `_` (only used internally during the parsing process).

We refer to these as *operators*, and we distinguish between *additive operators* (sum and subtraction) and *multiplicative operators* (product and division).

In addition, opening `(` and closing `)` parentheses are also reserved characters.

### Validation process

You may have noticed that the `MathExpression` initializer may throw an error. Indeed, the initializer runs a validation process through the given String instance to ensure that it is computable, and throws an error if the validation fails.

An expression is considered to be invalid if any of the following conditions is fulfilled:

* **Empty string**: The string is empty, that is, you try to initialize `MathExpression("")`.
* **Misplaced brackets**: There are misplaced brackets, that is, there is a closing bracket before an opening bracket, an opening bracket followed by a multiplicative operator, or any operator followed by a closing bracket. As examples, `(a + b +)`, `(/ x * y)` or `) x + (y * 3` are non-valid expression.
* **Uneven number of opening/closing brackets**: There are more opening/closing brackets than their closing/opening counterpart. For example, `(a + b))`
* **Consecutive operators**: The are combinations of operators that simply don't make sense. More particularly, an expression will be considered invalid if it contains one or more of the following: `* *`, `* /`, `/ *`, `/ /`, `+ *`, `+ /`, `- *`, `- /`. Any other combination is valid: `+ +`, `+ -`, `- +` and `- -` will be converted to `+`, `-`, `-` and `+`, respectively, and the remaining ones `* +`, `/ +`, `* -`, `/ -` will be parsed with the second operator being a part of the number (or the result after evaluation) that follows the multiplicative operator, due to the order in which the parsing takes place.
* **Starts with non-additive operator**: Any non-additive operator at the beginning of the expression will throw an error. That is, expressions starting with either `*` or `/`.
* **Ends with operator:** Any expression whose latest character is an operator will throw an error.

As a general tip, the expression should make sense for a human.

### Operations order

The MathExpression parser does perform the operations in the following strict order:

1. Evaluate if the expression is a number by trying to initialize a `Double` instance with it, and return its value if so.
2. Evaluate if the expression starts with an additive operator (sum or subtraction).
3. Evaluate every expression between parentheses, from inside out and left to right, if possible.
4. Evaluate multiplicative operators (first product, then division).
5. Evaluate additive operators (first sum, then subtraction).
6. Apply transformation to the remaining string if none of the above is fulfilled, and return the `Double` value obtained.

### Transformations

Transformations provide a great deal of flexibility in typing in your String instances to evaluate mathematical expressions. In essence, a `transformation` is just a block of the form
```swift
(String) -> Double
```
that is, any function taking a String instance to return a Double value. This transformation is passed to the `MathExpression` initializer as an optional parameter with default value `nil`. If no transformation is provided, or `nil` is explicitly passed, the `MathExpression` will initialize itself with the following block:
```swift
{ Double($0) ?? 0.0 }
```

There are several things to point out here:
* The transformation return value is a non-optional instance of `Double` in purpose: you **must** provide either a non-failing code or a default value. This is to prevent the parser from looping infinitely trying to parse a String instance with no real mathematical operators.
* Transformations are **the last operation** to be executed, and only if the String instance is not a numeric value already. This implies that, depending on your transformation, you may have restrictions. In particular, if your transformation is a mathematical function you may obtain faulty results due to the order in which operations are done. See, for instance, the section below on the exponential function.
* Transformations are still blocks, so be mindful on preventing retain cycles.
* Although theoretically you could pass a transformation that executes asynchronous code (for instance, fetching a model in a remote database and making computations to obtain a number), we never developed the framework with this idea in mind, and hence we can't ensure the expression will be evaluated correctly.

#### Example: the exponential function

Let's consider the following block of code:

```swift
let transformation: (String) -> Double = { string in
    let splitString = string.split(separator: "^").map { String($0) }
    guard splitString.count == 2,
        let base = try? MathExpression(splitString.first ?? ""),
        let exponent = try? MathExpression(splitString.last ?? "") else { return 0.0 }
    return pow(base.evaluate(), exponent.evaluate())
}
```

This transformation essentially defines the `^` symbol as the exponential operator. If you take a look at the file `ExponentialTransformationTests.swift`, you'll notice that the transformation only returns the correct result when one of the following conditions is met:
* Both the base and the exponent are non-negative.
* The base is negative and the exponent is a non-negative odd number.

In particular, even exponents do not remove the `-` sign, since the algorithm parses and evaluates the subtraction operator **before** the exponential, wheres in pure arithmetic the exponential must take precedence since it's a multiplicative operator.

### Algorithm performance

Both the validation and evaluation algorithms follow a *divide and conquer* approach, and are implemented recursively. That is, both algorithms split the given String intance into smaller instances until either a single numeric value or a non-mathematical expression are obtained (in the latter, the transformation returns the corresponding value). In addition, the validation algorithm iterates once over the whole String instance to ensure that no invalid consecutive operators are present.

Therefore, if the String instance with the mathematical expression has length `n`, the complexity of both algorithms is the following:
* Validation: `O(1) + O(n) + O(n * log(n)) = O(n * log(n))`
* Evaluation: `O(n * log(n))`

Bear in mind that this analysis **does not** take into account the transformation that may be passed as a parameter. A complex transformation may increase the complexity of the evaluation algorithm.

The project includes a `performance` version of every unit test (excep for the `ExponentialTransformationTests`, whose purpose is different) which can be run independently by running the scheme `PerformanceTests`. In addition, there exists a class `StressPerformanceTests` to catch any performance edge cases in both the validation and evaluation algorithms. At the present time, this class includes the following stress tests:
* A mathematical expression consisting of 500 concatenated parentheses pairs with a single value at the center. Result is less than 0.4 seconds in average to validate and evaluate.
* A mathematical expression involving a concatenation of 501 expressions of the type `(a + b * c)`, where `c` is another expression of the type `(a + b * c)`, and so on. Taking 3 expressions, the final result would be `(a + b * (c + d * (e + f * (g + h))))`. Result is around 1.1 seconds in average to validate and evaluate.
* A randomly generated mathematical expression constructed combining 500 random expressions from a pre-selected subset of the `Formulae` enum. Result is around 5 seconds in average to validate and evaluate.

## Example app

This repository includes an example app with a couple of use cases for this framework.

### Calculator

The first (and more obvious) use case for this framework is a calculator app, similar to the iOS or macOS calculator app in non-scientific display. The input is restricted to the operations already built-in in the framework (namely sum, subtraction, product and division), with the option to add parentheses and change the sign of the input. Additionally, the calculator displays the complete operation on top of the current input whenever a new operation or the `=` button is tapped.

### Evaluator

The second (obvious) use case for this framework is to evaluate an expression given by a `String`. The `Evaluator` enables us to do so. The input is provided using a couple of `UITextField`. The first one is the expression under evaluation, whilst the second enables to select a `transformation` to use in the evaluation process. The `transformation` is selected using a `UIPickerView` from the following set:
* **Default**: tries to convert the `String` into a `Double`, returns `0.0` if not possible.
* **Count**: returns the value of the `count` property of the `String` instance.
* **Factorial**: evaluates expressions of the type `n!` as the factorial of `n` (that is: `n * (n - 1) * (n - 2) * ... * 2 * 1`, where `n` must be a non-negative **integer**. If `n < 1`, then `n!` returns `1`. If `n` is not an integer, then `n!` returns `0.0`. Be mindful when using this transformation: the factorial function has a nearly exponential growth and can easily overflow if used on large numbers.

Further transformations may be added in future releases.

## Contributing

This framework has been developed to cover the needs of another project in which we needed to evaluate a mathematical expression with non-numerical identifiers that fetch a model in CoreData. Therefore, we stopped once the needs were covered (adding appropriate tests and documentation). If you have any idea on how to improve it, we'll be happy to hear/read it. Just open a new issue to discuss it further, or open a pull request with your idea.

### Code styling guide and formatter

We follow the [Ray Wenderlich Swift Style Guide](https://github.com/raywenderlich/swift-style-guide), except for the [Spacing](https://github.com/raywenderlich/swift-style-guide#spacing) section: we use **4 spaces** instead of 2 to indent.

To enforce the guidelines in the aforementioned code style guide, we use [SwiftFormat](https://github.com/nicklockwood/SwiftFormat). The set of rules is checked into this repository in the file `.swiftformat`. Before pushing any code, please follow the instructions in [How do I install it?](https://github.com/nicklockwood/SwiftFormat/#how-do-i-install-it) of the aforementioned repository to install `SwiftFormat` and execute the following command in the root directory of the project:
```
swiftformat . --config .swiftformat --swiftversion 5.0 --exclude Package.swift
```

This will re-format every `*.swift` file inside the project folder to follow the guidelines, except the `Package.swift` manifest file.

### Roadmap

Although the current implementation does provide what we need, there are several ideas in our minds that we are willing to implement when time allows it. In particular:
* Add a `priority` property to operators (public, non-modifiable) and transformations (modifiable), so that they are executed in the order that we really need.
* Add some additional mathematical operators, such as `^` (for exponentiation), and maybe some functions such as trigonometric functions.

## Acknowledgments

* [@hiangeel](https://github.com/hiangeel) for pointing out improvements in the installation documentation.
* [@gbreen12](https://github.com/gbreen12) for taking the time to fork and open a PR to improve the package.

## Similar frameworks

If this framework doesn't suit your needs, and you don't have the time to contribute to it, there are several outstanding alternatives in GitHub which are currently being maintained. Before developing this framework, we gave a try to the following:
* [Expression](https://github.com/nicklockwood/Expression) by [Nick Lockwood](https://github.com/nicklockwood)
* [MathParser](https://github.com/jrosen081/MathParser) by [Jack Rosen](https://github.com/jrosen081)
* [DDMathParser](https://github.com/davedelong/DDMathParser) by [Dave DeLong](https://github.com/davedelong)
