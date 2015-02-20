//
//  TweetsViewController.swift
//  Twitter
//
//  Created by William Castellano on 2/19/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    var tweets: [Tweet]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            
            for tweet in tweets! {
                println("text: \(tweet.text), created: \(tweet.createdAt)")
            }
            
            // reload table view here
            
            // Can do "tweet.favorite()" here to do a POST (as opposed to a GET)
            // Add a favorite() function in TwitterClient.swift to implement the 'favorite' API call, etc
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
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
