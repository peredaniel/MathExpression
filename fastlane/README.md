fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
### build
```
fastlane build
```
Builds the framework for the specified platform (either 'iOS', 'tvOS' or 'macOS').

This lane is to make sure that all platforms build correctly and there are no breaking changes. No tests are executed.

Usage example: fastlane ios test device:'iPhone 8'

----

## iOS
### ios test
```
fastlane ios test
```
Runs framework's unit tests in the specified device.

Usage example: fastlane ios test device:'iPhone 8'
### ios test_performance
```
fastlane ios test_performance
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
