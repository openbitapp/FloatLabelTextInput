# FloatLabelTextInput

[![CI Status](https://img.shields.io/travis/openbitapp/FloatLabelTextInput.svg?style=flat)](https://travis-ci.org/openbitapp/FloatLabelTextInput)
[![Version](https://img.shields.io/cocoapods/v/FloatLabelTextInput.svg?style=flat)](https://cocoapods.org/pods/FloatLabelTextInput)
[![License](https://img.shields.io/badge/license-Apache_2.0-green.svg?style=flat)](https://raw.githubusercontent.com/openbitapp/FloatLabelTextInput/master/LICENSE)
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://cocoapods.org/pods/FloatLabelTextInput)
[![Swift 4.2](https://img.shields.io/badge/swift-4.2-orange.svg?style=flat)](https://developer.apple.com/swift)


By [bitApp SRL](https://bitapp.it).


## Introduction

An Eureka row that shows a float label, using expandable text view or standard text field. Inspired by FloatLabelRow

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* iOS 10.0+
* Xcode 10.0+
* Eureka 4.2+

## Installation

FloatLabelTextInput is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FloatLabelTextInput'
```

## Usage

```swift
import Eureka
import FloatLabelTextInput


class ExampleViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section()
            <<< TextFloatLabelRow() {
                $0.title = "Text Field"
                $0.value = "Placeholder"
            }
            <<< IntFloatLabelRow() {
                $0.title = "Int field"
                $0.value = 2017
            }
            <<< PasswordFloatLabelRow() {
                $0.title = "Password field"
                $0.value = "password"
            }
            +++ Section()
            <<< DecimalFloatLabelRow() {
                $0.title = "Scientific style"
                $0.value = 2017
                let formatter = NumberFormatter()
                formatter.locale = .current
                formatter.numberStyle = .scientific
                $0.formatter = formatter
            }
            <<< IntFloatLabelRow() {
                $0.title = "Spell out style"
                $0.value = 2017
                let formatter = NumberFormatter()
                formatter.locale = .current
                formatter.numberStyle = .spellOut
                $0.formatter = formatter
        	}
        	<<< FloatLabelTextViewRow() {
                $0.title = "Text Field"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 100)
            }
    }

}
```

## Author

Roberto Casula @[bitApp SRL](https://bitapp.it)

## License

FloatLabelTextInput is available under the Apache License 2.0 license. See the LICENSE file for more info

