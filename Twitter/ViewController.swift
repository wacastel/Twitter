//
//  ViewController.swift
//  Twitter
//
//  Created by William Castellano on 2/18/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() { (user: User?, error: NSError?) in
            if user != nil {
                // perform segue
                //self.performSegueWithIdentifier("loginSegue", sender: self)
                //let vc = TweetsViewController(nibName: "TweetsViewController", bundle: nil)
                let vc = ParentViewController(nibName: "ParentViewController", bundle: nil)
                let nvc = UINavigationController(rootViewController: vc)
                self.presentViewController(nvc, animated: true, completion: nil)
            } else {
                // handle login error
            }
        }
    }

}

