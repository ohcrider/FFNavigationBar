//
//  FFSetChildViewSegue.swift
//  Pods
//
//  Created by fewspider on 16/1/23.
//
//

import UIKit

public class FFSetChildViewSegue: UIStoryboardSegue {

    private let screenWidth = UIScreen.mainScreen().bounds.size.width

    // MARK: - Segue Identifier
    static let segueIdentifier = "setChild"

    override public func perform() {
        let navigationBarHeight:CGFloat = 66

        let firstVC = self.sourceViewController as! FFNavigationBarController
        let secondVC = self.destinationViewController

        firstVC.addChildViewController(secondVC)

        let childCount = firstVC.childViewControllers.count - 1

        secondVC.view.frame = CGRect(x: CGFloat(childCount) * screenWidth,y: -navigationBarHeight,width: screenWidth,height: firstVC.contentScrollView.frame.height)

        firstVC.contentScrollView.addSubview(secondVC.view)
        secondVC.didMoveToParentViewController(firstVC)
    }
}
