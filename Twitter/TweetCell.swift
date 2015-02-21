//
//  TweetCell.swift
//  Twitter
//
//  Created by William Castellano on 2/20/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Tweet!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTweet(inputTweet: Tweet) {
        self.tweet = inputTweet
        self.profileImageView.setImageWithURL(NSURL(string: self.tweet.user!.profileImageUrl!))
        self.userNameLabel.text = self.tweet.user!.name
        self.screenNameLabel.text = self.tweet.user!.screenname
        var formatter = NSDateFormatter()
        self.timeStampLabel.text = formatter.stringFromDate(self.tweet.createdAt!)
        self.tweetTextLabel.text = self.tweet.text
    }
    
}
