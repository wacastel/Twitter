//
//  TweetCell.swift
//  Twitter
//
//  Created by William Castellano on 2/20/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

protocol TweetCellDelegate {
    func didReplyToTweet(cell: TweetCell)
    func didRetweetTweet(cell: TweetCell)
    func didFavoriteTweet(cell: TweetCell)
}

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!
    var delegate: TweetCellDelegate?
    var retweeted: Bool!
    var favorited: Bool!
    let favoriteOffImage = UIImage(named: "favorite.png")
    let favoriteOnImage = UIImage(named: "favorite_on.png")
    let retweetOffImage = UIImage(named: "retweet.png")
    let retweetOnImage = UIImage(named: "retweet_on.png")
    let replyImage = UIImage(named: "reply.png")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tweetTextLabel.preferredMaxLayoutWidth = self.tweetTextLabel.frame.size.width
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTweet(inputTweet: Tweet) {
        self.tweet = inputTweet
        if let profileImage = self.tweet.user?.profileImageUrl {
            self.profileImageView.setImageWithURL(NSURL(string: profileImage))
        }
        self.userNameLabel.text = self.tweet.user!.name
        self.screenNameLabel.text = "@" + self.tweet.user!.screenname!
        var formatter = NSDateFormatter()
        var timeInterval = -(self.tweet.createdAt!.timeIntervalSinceNow)
        if timeInterval < (24 * 60 * 60) {
            var hours = Int(round((timeInterval) / 3600))
            if hours < 1 {
                hours = 1
            }
            self.timeStampLabel.text = String(hours) + "h"
        } else {
            formatter.dateFormat = "MM/dd/yy"
            self.timeStampLabel.text = formatter.stringFromDate(self.tweet.createdAt!)
        }
        self.tweetTextLabel.text = self.tweet.text
        
        // Set button images
        self.replyButton.setImage(replyImage, forState: UIControlState.Normal)
        if self.tweet.favorited! == 0 {
            self.favoriteButton.setImage(favoriteOffImage, forState: UIControlState.Normal)
            self.favorited = false
        } else {
            self.favoriteButton.setImage(favoriteOnImage, forState: UIControlState.Normal)
            self.favorited = true
        }
        
        if self.tweet.retweeted! == 0 {
            self.retweetButton.setImage(retweetOffImage, forState: UIControlState.Normal)
            self.retweeted = false
        } else {
            self.retweetButton.setImage(retweetOnImage, forState: UIControlState.Normal)
            self.retweeted = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tweetTextLabel.preferredMaxLayoutWidth = self.tweetTextLabel.frame.size.width
    }
    
    @IBAction func onReply(sender: AnyObject) {
        self.delegate?.didReplyToTweet(self)
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        self.delegate?.didRetweetTweet(self)
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        self.delegate?.didFavoriteTweet(self)
    }
    @IBAction func onTestButton(sender: AnyObject) {
        println("test button clicked!")
    }
}
