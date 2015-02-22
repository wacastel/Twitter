//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by William Castellano on 2/20/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reply", style: UIBarButtonItemStyle.Plain, target: self, action: "reply")
        self.title = "Tweet"
        println("tweet details - real name: \(tweet!.user!.name)")
        println("tweet details - screen name: \(tweet!.user!.screenname)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reply() {
        println("reply to the tweet!")
    }
    
    func retweet() {
        println("retweet the tweet!")
    }
    
    func favorite() {
        println("favorite the tweet!")
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
