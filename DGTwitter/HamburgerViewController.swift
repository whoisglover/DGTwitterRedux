//
//  HamburgerViewController.swift
//  DGTwitter
//
//  Created by Danny Glover on 4/20/17.
//  Copyright © 2017 Danny Glover. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    
    var originalLeftMargin: CGFloat!
    
    var menuViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            menuView.addSubview(menuViewController.view)
        
        }
    }
    
    var contentViewController: UIViewController! {
        didSet(oldContentViewController) {
            view.layoutIfNeeded()
            
            if oldContentViewController != nil {
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            
            //calls will appear
            contentViewController.willMove(toParentViewController: self)
            contentView.addSubview(contentViewController.view)
            //calls did appear
            contentViewController.didMove(toParentViewController: self)
            
            closeMenu()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalLeftMargin = leftMarginConstraint.constant
        } else if sender.state == UIGestureRecognizerState.changed {
            leftMarginConstraint.constant = originalLeftMargin + translation.x
        } else if sender.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 0.3, animations: { 
                if velocity.x > 0 {
                    self.leftMarginConstraint.constant = 200
                } else {
                    self.leftMarginConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func closeMenu() {
        UIView.animate(withDuration: 0.3) {
            self.leftMarginConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
}
