//
//  ComposeViewController.swift
//  Twitter
//
//  Created by William Castellano on 2/20/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    var user: User?
    @IBOutlet weak var composeTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tweet", style: UIBarButtonItemStyle.Plain, target: self, action: "sendTweet")
        // Do any additional setup after loading the view.
        if let profileImage = self.user?.profileImageUrl {
            self.profileImageView.setImageWithURL(NSURL(string: profileImage))
        }
        println("compose view - real name: \(self.user!.name)")
        println("compose view - screen name: \(self.user!.screenname)")
        self.realNameLabel.text = self.user!.name
        self.screenNameLabel.text = self.user!.screenname
        composeTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendTweet() {
        var text = composeTextView.text
        println(text)
        var params = ["status": text]
        TwitterClient.sharedInstance.updateStatus(params)
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
