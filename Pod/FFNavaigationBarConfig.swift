//
//  FFNavaigationBarConfig.swift
//  Pods
//
//  Created by fewspider on 16/1/23.
//
//

import Foundation

public struct FFNavaigationBarConfig {
    public var navButtonHightlightFontColor = UIColor(red:0.4, green:0.71, blue:0.91, alpha:1)
    public var navButtonNormalFontColor = UIColor(red:0.56, green:0.56, blue:0.56, alpha:1)
    public var cursorViewColor = UIColor(red:0.4, green:0.71, blue:0.91, alpha:1)

    public var screenNavMaxNumber = 4
    public var navTitles = ["Demo0", "Demo1", "Demo2", "Demo3", "Demo4", "Demo5", "Demo6", "Demo7", "Demo8", "Demo9", "Demo10"]

    public var navigationScrollViewHeight:CGFloat = 44
    public var cursorViewHeight:CGFloat = 3

    public var animateDuration: NSTimeInterval = 0.3

    public init() { }
}