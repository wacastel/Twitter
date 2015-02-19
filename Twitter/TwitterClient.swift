//
//  TwitterClient.swift
//  Twitter
//
//  Created by William Castellano on 2/18/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

let twitterConsumerKey = "eAlhb1LdTz0WyPuzI83gjVFlP"
let twitterConsumerSecret = "pZ90InluWVYrNVGPfvdeuNIRjfmkjVOhlieKm0nxEQ4X6S1iBn"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
