//
//  ViewController.swift
//  ScrollFun
//
//  Created by Jim Stewart on 10/13/15.
//  Copyright © 2015 mutualmobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private weak var scrollView: UIScrollView?
    private weak var contentView: UIView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.grayColor()
        addScrollView()
        addContentView()
        addLabelToContentView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private final func addScrollView() {
        let sView = UIScrollView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sView)
        pinLeadingTrailingOfView(sView, toView: self.view)
//        pinToTopBottomLayoutGuides(sView)             // masks status bar
        pinTopBottomOfView(sView, toView: self.view)
        matchWidthOfView(sView, toView: self.view)
        scrollView = sView
    }
    
    private final func addContentView() {
        let cView = UIView()
        cView.backgroundColor = UIColor.whiteColor()
        cView.translatesAutoresizingMaskIntoConstraints = false
        scrollView?.addSubview(cView)
        pinLeadingTrailingOfView(cView, toView: self.scrollView!)
        pinTopBottomOfView(cView, toView: self.scrollView!)
        matchWidthOfView(cView, toView: self.view)
        matchHeightOfView(cView, toView: self.view, multiplier: 2.5)
        contentView = cView
    }
    
    private final func addLabelToContentView() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ContentView"
        contentView?.addSubview(label)
        centerView(label, inView: contentView!)
    }
    
    // MARK:- Constraint helpers
    
    private final func pinLeadingTrailingOfView(view: UIView, toView: UIView) {
        toView.addConstraint(NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: toView, attribute: .Leading, multiplier: 1.0, constant: 0))
        toView.addConstraint(NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: toView, attribute: .Trailing, multiplier: 1.0, constant: 0))

    }
    
    private final func pinTopBottomOfView(view: UIView, toView: UIView) {
        toView.addConstraint(NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: toView, attribute: .Top, multiplier: 1.0, constant: 0))
        toView.addConstraint(NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: toView, attribute: .Bottom, multiplier: 1.0, constant: 0))
    }
    
    private final func pinToTopBottomLayoutGuides(view: UIView) {
        self.view.addConstraint(NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: self.bottomLayoutGuide, attribute: .Top, multiplier: 1.0, constant: 0))
    }

    
    private final func matchWidthOfView(view: UIView, toView: UIView) {
        toView.addConstraint(NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: toView, attribute: .Width, multiplier: 1.0, constant: 0))
    }
    
    private final func matchHeightOfView(view: UIView, toView: UIView, multiplier: CGFloat) {
        toView.addConstraint(NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: toView, attribute: .Height, multiplier: multiplier, constant: 0))
    }

    
    private final func centerView(view: UIView, inView: UIView) {
        inView.addConstraint(NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: inView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        inView.addConstraint(NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: inView, attribute: .CenterY, multiplier: 1.0, constant: 0))
    }

}

