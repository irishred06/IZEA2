//
//  LoginViewController.swift
//  TwitterFeed
//
//  Created by Lauren Jarrard on 12/13/16.
//  Copyright © 2016 Lauren Jarrard. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    @IBOutlet var loginButton:UIButton?
    @IBOutlet var label:UILabel?
    
    var session:TWTRSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.isHidden = true
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                print("signed in as \(session!.userName)");
                
                self.session = session
                self.performSegue(withIdentifier: "loginSuccess", sender: self)
            } else {
                print("error: \(error!.localizedDescription)");
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSuccess" {
            let timelineVC = segue.destination as! TimelineViewController
            timelineVC.session = session
        }
    }
}

