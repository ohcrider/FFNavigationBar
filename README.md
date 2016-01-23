# FFNavigationBar

[![CI Status](http://img.shields.io/travis/fewspider/FFNavigationBar.svg?style=flat)](https://travis-ci.org/fewspider/FFNavigationBar)
[![Version](https://img.shields.io/cocoapods/v/FFNavigationBar.svg?style=flat)](http://cocoapods.org/pods/FFNavigationBar)
[![License](https://img.shields.io/cocoapods/l/FFNavigationBar.svg?style=flat)](http://cocoapods.org/pods/FFNavigationBar)
[![Platform](https://img.shields.io/cocoapods/p/FFNavigationBar.svg?style=flat)](http://cocoapods.org/pods/FFNavigationBar)

## About
It can display multiple view and quick to jump to another view.

## Demo
To run the example project, clone the repo, and run `pod install` from the Example directory first.
![demo](https://c2.staticflickr.com/2/1660/23932804183_1f2aa8f37a_o.gif)

## Features
more powerful and code is more easy to understand.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

You can custom it,just override the method awakeFromNib.

```swift
    override func awakeFromNib() {
        super.awakeFromNib()

        var config = FFNavaigationBarConfig()
        config.screenNavMaxNumber = 3
        config.cursorViewHeight = 5
        config.navTitles = ["Custom0",
                            "Custom1",
                            "Custom2",
                            "Custom3",
                            "Custom4",
                            "Custom5",
                            "Custom6",
                            "Custom7",
                            "Custom8",
                            "Custom9",
                            "Custom10"]
        config.navigationScrollViewHeight = 55
        config.navButtonHightlightFontColor = UIColor.redColor()
        config.navButtonNormalFontColor = UIColor.purpleColor()
        config.cursorViewColor = UIColor.redColor()

        config.animateDuration = 0.6
        
        self.config = config
    }
```

## Installation

FFNavigationBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FFNavigationBar"
```

## Author

fewspider, fewspider@gmail.com

## License

FFNavigationBar is available under the MIT license. See the LICENSE file for more info.
