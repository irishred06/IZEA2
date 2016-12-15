//
//  TimelineViewController.swift
//  TwitterFeed
//
//  Created by Lauren Jarrard on 12/13/16.
//  Copyright © 2016 Lauren Jarrard. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

class TimelineViewController : TWTRTimelineViewController, ComposeViewControllerDelegate {
    
    @IBOutlet var compose:UIBarButtonItem?
    
    var session:TWTRSession?
    var client:NSObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = false
        
        client = TWTRAPIClient(userID: session!.userName)//TWTRAPIClient()
        
        self.dataSource = TWTRUserTimelineDataSource(screenName: session!.userName, apiClient: client! as! TWTRAPIClient)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func composeButtonPressed(button: UIBarButtonItem) {
        let composer = TWTRComposer()
    
        composer.setImage(UIImage(named: "fabric"))
        
        // Called from a UIViewController
        composer.show(from: self) { result in
            if (result == TWTRComposerResult.cancelled) {
                print("Tweet composition cancelled")
            }
            else {
                print("Sending tweet!")
                self.dataSource = TWTRUserTimelineDataSource(screenName: self.session!.userName, apiClient: self.client! as! TWTRAPIClient)
            }
        }
        
        //self.performSegue(withIdentifier: "composePopover", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "composePopover" {
            let nav = segue.destination as! UINavigationController
            let composeVC = nav.visibleViewController as! ComposeViewController
            composeVC.delegate = self
        }
    }
    
    func dismiss() {
        self.dismiss(animated: true) {
        }
    }
}
