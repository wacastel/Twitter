//
//  ParentViewController.swift
//  Twitter
//
//  Created by William Castellano on 2/26/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    
    var tweetsViewController: TweetsViewController?
    var menuViewController: MenuViewController?
    var panGestureRecognizer: UIPanGestureRecognizer?
    var trayOriginalCenter: CGPoint!
    var startX:CGFloat = 0.0
    var menuFrame: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("ParentViewController - viewDidLoad")
        tweetsViewController = TweetsViewController(nibName: "TweetsViewController", bundle: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: "toggleMenu")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.Plain, target: self, action: "composeTweet")
        self.title = "Home"
        self.navigationItem.titleView?.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        addTweetsView()
        //self.menuFrame = self.view.frame
    }
    
    func addTweetsView() {
        self.view.addSubview(tweetsViewController!.view)
        self.addChildViewController(tweetsViewController!)
        tweetsViewController!.didMoveToParentViewController(self)
        tweetsViewController!.view.addGestureRecognizer(panGestureRecognizer!)
        self.menuFrame = self.navigationController?.view.frame
    }
    
    func toggleMenu() {
        if (menuViewController == nil) {
            menuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
            self.view.insertSubview(menuViewController!.view, atIndex: 0)
            self.addChildViewController(menuViewController!)
            menuViewController?.didMoveToParentViewController(self)
            menuViewController!.view.frame = self.menuFrame!
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.tweetsViewController!.view.frame.origin.x = self.tweetsViewController!.view.frame.width - 50
                }, completion: nil)
        } else {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.tweetsViewController!.view.frame.origin.x = 0
                }, completion: {
                    finished in
                    self.menuViewController!.view.removeFromSuperview()
                    self.menuViewController!.removeFromParentViewController()
                    self.menuViewController = nil
            })
        }
    }
    
    func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            trayOriginalCenter = self.tweetsViewController!.view.center
            startX = point.x
            //self.menuFrame = tweetsViewController!.view.frame
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("Gesture changed at: \(point)")
            self.tweetsViewController!.view.center = CGPoint(x: trayOriginalCenter.x + point.x - startX, y: trayOriginalCenter.y)
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
            toggleMenu()
        }
    }
    
    func logoutUser() {
        println("ParentViewController - logoutUser")
        User.currentUser?.logout()
    }
    
    func composeTweet() {
        println("ParentViewController - composeTweet")
        let vc = ComposeViewController(nibName: "ComposeViewController", bundle: nil)
        vc.user = User.currentUser
        vc.replyMode = false
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
