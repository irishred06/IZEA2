//
//  LoginViewController.swift
//  TwitterFeed
//
//  Created by Lauren Jarrard on 12/13/16.
//  Copyright © 2016 Lauren Jarrard. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, OAuthIODelegate {
    @IBOutlet var loginButton:UIButton?
    @IBOutlet var label:UILabel?
    
    var oAuthModal:OAuthIOModal?
    var credentials:Dictionary<AnyHashable, Any>?
    var request:OAuthIORequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.isHidden = true
        let key = "n7fJUgomqUKafaWxtsU803AuRn0";
        oAuthModal = OAuthIOModal(key: key, delegate: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func didReceiveOAuthIOResponse(_ request: OAuthIORequest!) {
        self.credentials = request.getCredentials()
        self.label?.text = "Logged in with Twitter"
        self.request = request
        
        self.performSegue(withIdentifier: "loginSuccess", sender: self)
    }
    
    public func didReceiveOAuthIOCode(_ code: String!) {
    }
    
    public func didAuthenticateServerSide(_ body: String!, andResponse response: URLResponse!) {
    }
    
    public func didFail(withOAuthIOError error: Error!) {
        self.label?.text = "Error logging in to Twitter"
    }
    
    public func didFailAuthenticationServerSide(_ body: String!, andResponse response: URLResponse!, andError error: Error!) {
    }
    
    @IBAction func loginButtonPressed(button: UIButton) {
        self.label?.text = ""
        oAuthModal?.show(withProvider:"twitter")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSuccess" {
            let timelineVC = segue.destination as! TimelineViewController
            timelineVC.credentials = self.credentials!
            timelineVC.request = self.request!
        }
    }
}

