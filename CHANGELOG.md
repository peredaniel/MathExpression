### 1.3.0

* Bumped minimum Xcode version to 13.0+.
* Bumped Swift version to 5.0 in `Package.swift`.
* Bumped target platform minimum version to 12.0+ (iOS and tvOS) and 10.14 (macOS).
* Improved errors thrown when validation fails due to invalid consecutive operators (on some cases the error was thrown but was of different type).
* Improved tests implementation to check for correct error being thrown.
* Removed Travis CI integration due to Open Source projects support being dropped.

#### Breaking changes

* `MathExpression.ValidationError.consecutiveMultiplicativeOperators(String)` has been renamed to `MathExpression.ValidationError.invalidConsecutiveOperators(String)`.

### 1.2.0

* Added support for [Swift Package Manager](https://swift.org/package-manager/).
* Added example app.
* Improved documentation.

### 1.1.1

* Fixed issue in operation priority.
* Added further tests.

### 1.1.0

* Added support for tvOS 10 or higher.
* Addes support for macOS 10.10 or higher.
* Improved CI setup.

### 1.0.1

* Improved parentheses validation algorithm (validation between 20% and 80% faster).
* Improved parentheses decomposition algorithm (evaluation between 15% and 85% faster).
* Added stress performance tests.

### 1.0.0

Initial Stable Release - Xcode 10.0+, Swift 4.2+, iOS 10+
