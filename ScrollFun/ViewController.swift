//
//  ViewController.swift
//  ScrollFun
//
//  Created by Jim Stewart on 10/13/15.
//  Copyright © 2015 mutualmobile. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, UIScrollViewDelegate {
    private weak var scrollView: UIScrollView?
    private weak var contentView: UIView?
    
    // Need access to the constants from these 3 constraints
    private weak var scrollViewTopConstraint: NSLayoutConstraint?
    private weak var topViewTopConstraint: NSLayoutConstraint?
    private weak var contentViewTopConstraint: NSLayoutConstraint?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        addScrollView()
        addContentView()
        addLabelToContentView()
        addTopFloatingView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private  func addScrollView() {
        let sView = UIScrollView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.delegate = self
        view.addSubview(sView)
        pinLeadingTrailingOfView(sView, toView: self.view)
        matchWidthOfView(sView, toView: self.view)
        let sViewTopConstraint = constraintPinAttribute(.Top, ofView: sView, toAttribute: .Bottom, toView: self.topLayoutGuide, withOffset: 0)
        self.view.addConstraint(sViewTopConstraint)
        scrollViewTopConstraint = sViewTopConstraint
        self.view.addConstraint(constraintPinBottomOfView(sView, toBottomOfView: self.view, withOffset: 0))
        scrollView = sView
    }
    
    private  func addContentView() {
        let cView = UIView()
        cView.backgroundColor = UIColor.grayColor()
        cView.translatesAutoresizingMaskIntoConstraints = false
        scrollView?.addSubview(cView)
        
        pinLeadingTrailingOfView(cView, toView: self.scrollView!)
        
        let cViewTopConstraint = constraintPinTopOfView(cView, toTopOfView: self.scrollView!, withOffset: 0)
        self.scrollView?.addConstraint(cViewTopConstraint)
        self.contentViewTopConstraint = cViewTopConstraint
        
        self.scrollView?.addConstraint(constraintPinBottomOfView(cView, toBottomOfView: self.scrollView!, withOffset: 0))

        matchWidthOfView(cView, toView: self.view)
        matchHeightOfView(cView, toView: self.view, multiplier: 1.5)
        contentView = cView
    }
    
    private  func addLabelToContentView() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ContentView"
        contentView?.addSubview(label)
        
        centerXView(label, inView: contentView!)
        contentView?.addConstraint(constraintPinTopOfView(label, toTopOfView: contentView!, withOffset: 200.0))
    }
    
    private let kTopHeight = CGFloat(80)
    private let kTopVOffset = CGFloat(100)
    
    private func addTopFloatingView() {
        let top = UIView()
        top.translatesAutoresizingMaskIntoConstraints = false
        top.backgroundColor = UIColor.blueColor()
        self.view.addSubview(top)
        pinLeadingTrailingOfView(top, toView: self.view)
        let topTopConstraint = constraintPinAttribute(.Top, ofView: top, toAttribute: .Bottom, toView: self.topLayoutGuide, withOffset: kTopVOffset)
        // ? or pin to top of contentView with <= constraint???
        self.view.addConstraint(topTopConstraint)
        self.topViewTopConstraint = topTopConstraint
        self.view.addConstraint(NSLayoutConstraint(item: top, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute , multiplier: 1.0, constant: kTopHeight))
    }
    
    // MARK:- UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        print("\(scrollView.contentOffset.y)")
        let contentOffset = (scrollView.contentOffset.y)
        switch contentOffset {
        case let (offset) where offset < kTopVOffset:  // don't pin topView to top, let topView scroll with scrollView
            // scroll topView with the scrollView
            self.topViewTopConstraint?.constant = kTopVOffset - scrollView.contentOffset.y
            // zero out offsets
            self.scrollViewTopConstraint?.constant = 0.0
            self.contentViewTopConstraint?.constant = 0.0
            break;
        case let (offset) where offset >= kTopVOffset:  // pin topView to top
            // pin topView to the top of the vc view.
            self.topViewTopConstraint?.constant = 0.0
            // adjust the top of the scrollview to account for the height of the topView
            self.scrollViewTopConstraint?.constant = kTopHeight
            // adjust to top of the contentView within the scrollView to counteract the jump
            self.contentViewTopConstraint?.constant = -kTopHeight
        default:
            break
        }
        self.view.setNeedsUpdateConstraints()
    }
    
    // MARK:- Constraint helpers
    
    private  func pinLeadingTrailingOfView(view: UIView, toView: UIView) {
        toView.addConstraint(NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: toView, attribute: .Leading, multiplier: 1.0, constant: 0))
        toView.addConstraint(NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: toView, attribute: .Trailing, multiplier: 1.0, constant: 0))
    }
    
    private  func pinTopAndBottomOfView(view: UIView, toView: UIView) {
        toView.addConstraint(constraintPinTopOfView(view, toTopOfView: toView, withOffset: 0))
        toView.addConstraint(constraintPinBottomOfView(view, toBottomOfView: toView, withOffset: 0))
    }
    
    private func pinToTopBottomLayoutGuides(view: UIView) {
        self.view.addConstraint(constraintPinAttribute(.Top, ofView: view, toAttribute: .Bottom, toView: self.topLayoutGuide, withOffset: 0))
        self.view.addConstraint(NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: self.bottomLayoutGuide, attribute: .Top, multiplier: 1.0, constant: 0))
    }
    
    private func matchWidthOfView(view: UIView, toView: UIView) {
        toView.addConstraint(NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: toView, attribute: .Width, multiplier: 1.0, constant: 0))
    }
    
    private func matchHeightOfView(view: UIView, toView: UIView, multiplier: CGFloat) {
        toView.addConstraint(NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: toView, attribute: .Height, multiplier: multiplier, constant: 0))
    }
    
    private func centerView(view: UIView, inView: UIView) {
        centerXView(view, inView: inView)
        centerYView(view, inView: inView)
    }
    
    private func centerXView(view: UIView, inView: UIView) {
        inView.addConstraint(NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: inView, attribute: .CenterX, multiplier: 1.0, constant: 0))
    }
    
    private func centerYView(view: UIView, inView: UIView) {
        inView.addConstraint(NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: inView, attribute: .CenterY, multiplier: 1.0, constant: 0))
    }
    
    private func constraintPinBottomOfView(view: UIView, toBottomOfView: UIView, withOffset: CGFloat) -> NSLayoutConstraint {
        return constraintPinAttribute(.Bottom, ofView: view, toAttribute: .Bottom, toView: toBottomOfView, withOffset: withOffset)
    }
    
    private func constraintPinTopOfView(view: UIView, toTopOfView: UIView, withOffset: CGFloat) -> NSLayoutConstraint {
        return constraintPinAttribute(.Top, ofView: view, toAttribute: .Top, toView: toTopOfView, withOffset: withOffset)
    }
    
    private func constraintPinLeadingOfView(view: UIView, toLeadingOfView: UIView, withOffset: CGFloat) -> NSLayoutConstraint {
        return constraintPinAttribute(.Leading, ofView: view, toAttribute: .Leading, toView: toLeadingOfView, withOffset: withOffset)
    }
    
    private func constraintPinTrailingOfView(view: UIView, toTrailingOfView: UIView, withOffset: CGFloat) -> NSLayoutConstraint {
        return constraintPinAttribute(.Trailing, ofView: view, toAttribute: .Trailing, toView: toTrailingOfView, withOffset: withOffset)
    }
    
    private func constraintPinAttribute(attribute: NSLayoutAttribute, ofView: AnyObject, toAttribute: NSLayoutAttribute, toView: AnyObject, withOffset: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: ofView, attribute: attribute, relatedBy: .Equal, toItem: toView, attribute: toAttribute, multiplier: 1.0, constant: withOffset)
    }
}

