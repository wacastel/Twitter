//
//  MenuViewController.swift
//  Twitter
//
//  Created by William Castellano on 2/26/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

protocol MenuViewDelegate {
    func didSelectProfileBtn()
    func didSelectHomeTimelineBtn()
    func didSelectMentionBtn()
}

class MenuViewController: UIViewController {

    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var homeTimelineBtn: UIButton!
    @IBOutlet weak var mentionsBtn: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    var delegate: MenuViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("MenuViewController - viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onProfileBtn(sender: UIButton) {
        println("go to my profile!")
        self.delegate?.didSelectProfileBtn()
    }

    @IBAction func onHomeTimelineBtn(sender: UIButton) {
        println("go to home timeline view!")
        self.delegate?.didSelectHomeTimelineBtn()
    }
    
    @IBAction func onMentionBtn(sender: UIButton) {
        println("go to mentions view!")
        self.delegate?.didSelectMentionBtn()
    }
    
    @IBAction func onLogoutBtn(sender: UIButton) {
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
