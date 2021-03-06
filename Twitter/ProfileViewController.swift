//
//  ProfileViewController.swift
//  Twitter
//
//  Created by William Castellano on 2/27/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User?
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userRealName: UILabel!
    @IBOutlet weak var userScreenName: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        println("ProfileViewController - viewDidLoad")
        if let profileImage = self.user?.profileImageUrl {
            self.profileImageView.setImageWithURL(NSURL(string: profileImage))
        }
        self.userRealName.text = self.user!.name!
        self.userScreenName.text = self.user!.screenname!
        self.tweetsCount.text = String(self.user!.tweetsCount!) + " TWEETS"
        self.followingCount.text = String(self.user!.followingCount!) + " FOLLOWING"
        self.followersCount.text = String(self.user!.followersCount!) + " FOLLOWERS"
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
