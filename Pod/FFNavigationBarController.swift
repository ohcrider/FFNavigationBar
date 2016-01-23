//
//  FFNavigationBarController.swift
//  Pods
//
//  Created by fewspider on 16/1/23.
//
//

import UIKit

public class FFNavigationBarController: UIViewController, UIScrollViewDelegate {

    var navigationScrollView: UIScrollView!
    var contentScrollView: UIScrollView!

    private let screenWidth = UIScreen.mainScreen().bounds.size.width
    private let screenHeight = UIScreen.mainScreen().bounds.size.height

    private var screenNavMaxNumber = 4
    private var navTitles: [String] = []
    private var navWidth: CGFloat = 0

    private var navs: [UIButton] = []
    private var cursorView: UIView!

    private var beginDraggingResult: CGFloat! = 0
    private var beginTouchResult: CGFloat! = 0

    private var navIndexItems: [Int] = []

    public var config:FFNavaigationBarConfig!

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        setupUI()
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        let config = FFNavaigationBarConfig()
        self.config = config
    }

    // MARK: - Setup UI

    public func setupUI() {
        self.screenNavMaxNumber = config.screenNavMaxNumber
        self.navTitles = config.navTitles
        navIndexItems = (0..<screenNavMaxNumber).map({return $0})

        setupBaseScrollView()
        setupNavigationScrollView()
        setupContentScrollView()
        setupChildViewControllers()
    }


    func setupBaseScrollView() {
        let navigationBarHeight:CGFloat = 66

        navigationScrollView = UIScrollView(frame: CGRect(x: 0,y: navigationBarHeight,width: screenWidth,height: config.navigationScrollViewHeight))
        contentScrollView = UIScrollView(frame: CGRect(x: 0,y: navigationBarHeight + config.navigationScrollViewHeight,width: screenWidth,height: screenHeight - config.navigationScrollViewHeight - config.navigationScrollViewHeight))

        navigationScrollView.delegate = self
        contentScrollView.delegate = self

        navigationScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false

        self.view.addSubview(navigationScrollView)
        self.view.addSubview(contentScrollView)
    }

    func setupNavigationScrollView() {

        navWidth = screenWidth / CGFloat(screenNavMaxNumber)

        cursorView = UIView(frame: CGRect(x: 0, y: config.navigationScrollViewHeight - config.cursorViewHeight, width: navWidth, height: config.cursorViewHeight))
        cursorView.backgroundColor = config.cursorViewColor

        navigationScrollView.addSubview(cursorView)

        for (i, x) in navTitles.enumerate() {
            let button = UIButton(frame: CGRect(x: navWidth * CGFloat(i), y: 0, width: navWidth, height: 44))
            button.titleLabel?.font = UIFont(name:  (button.titleLabel?.font?.fontName)!, size: 14)
            button.setTitle(x, forState: UIControlState.Normal)
            button.setTitleColor(config.navButtonNormalFontColor, forState: .Normal)

            button.addTarget(self, action: "switchNav:", forControlEvents: .TouchUpInside)

            navs.append(button)
            navigationScrollView.addSubview(button)

            if i == 0 {
                button.setTitleColor(config.navButtonHightlightFontColor, forState: .Normal)
            }
        }

        navigationScrollView.contentSize.width = navWidth * CGFloat(navs.count)
    }

    func setupContentScrollView() {
        contentScrollView.contentSize.width = screenWidth * CGFloat(navs.count)
    }

    // MARK: - Setup Child ViewContollers

    func setupChildViewControllers() {
        for i in 0..<navTitles.count {
            let identifier = "\(FFSetChildViewSegue.segueIdentifier)\(i)"
            self.performSegueWithIdentifier(identifier, sender: self)
        }
    }

    // MARK: - Navigation Scroll Update

    func switchNav(sender: UIButton!) {
        let title = sender.currentTitle!
        let index = navTitles.indexOf(title)!

        updateNavButtons(index)
        updateContentScrollView(index)
        updateNavigationScrollView(index)
    }

    func updateNavButtons(index: Int) {
        _ = navs.enumerate().map({
            if $0 != index {
                $1.setTitleColor(config.navButtonNormalFontColor, forState: .Normal)
            } else {
                $1.setTitleColor(config.navButtonHightlightFontColor, forState: .Normal)
            }
        })

        UIView.animateWithDuration(config.animateDuration, animations: { () -> Void in
            self.cursorView.frame.origin.x = CGFloat(index) * self.navWidth
            }) { (Bool) -> Void in
        }
    }

    func updateContentScrollView(index: Int) {
        let offset = CGPoint(x: CGFloat(index) * self.screenWidth, y: 0)

        UIView.animateWithDuration(config.animateDuration, animations: { () -> Void in
            self.contentScrollView.contentOffset.x = offset.x
            }) { (Bool) -> Void in
                self.updateNavButtons(index)
        }
    }

    func updateNavigationScrollView(index: Int) {
        
        if index > navIndexItems.maxElement() {
            navIndexItems.removeFirst()
            navIndexItems.append(index)
        }

        if index < navIndexItems.minElement() {
            navIndexItems.removeLast()
            navIndexItems.insert(index, atIndex: 0)
        }

        if self.navigationScrollView.contentOffset.x != self.navWidth * CGFloat(self.navIndexItems.minElement()!) {
            UIView.animateWithDuration(config.animateDuration, animations: { () -> Void in
                self.navigationScrollView.contentOffset.x = self.navWidth * CGFloat(self.navIndexItems.minElement()!)
                }) { (Bool) -> Void in
            }
        }
    }

    // MARK: - ScrollView Delegate

    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if (scrollView == self.contentScrollView) {
            let offsetX = contentScrollView.contentOffset.x
            let result = round(offsetX / screenWidth)
            beginDraggingResult = result
        }
    }

    public func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (scrollView == self.contentScrollView) {
            var result = round(targetContentOffset.memory.x / screenWidth)

            if (abs(beginDraggingResult - result) > 1) {
                if beginDraggingResult - result <= 0 {
                    result = beginDraggingResult + 1
                } else {
                    result = beginDraggingResult - 1
                }

            }

            let offset = CGPoint(x: CGFloat(result) * self.screenWidth, y: 0)
            targetContentOffset.memory.x = offset.x

            updateContentScrollView(Int(result))
            updateNavigationScrollView(Int(result))
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
