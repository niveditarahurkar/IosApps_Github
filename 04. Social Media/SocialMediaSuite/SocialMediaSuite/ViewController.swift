//
//  ViewController.swift
//  SocialMediaSuite
//
//  Created by nirahurk on 7/26/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func postToFb(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
            let fbPostForm = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            fbPostForm?.setInitialText("Posting to Facebook from my iOS App!")
            fbPostForm?.add(UIImage(named: "map-nyc1"))
            fbPostForm?.add(URL(string: "http://nyc.com"))
            //handler code
            var postResultString = ""
            fbPostForm?.completionHandler = {result -> Void in
                let postresult = result as SLComposeViewControllerResult
                switch (postresult.rawValue) {
                case SLComposeViewControllerResult.cancelled.rawValue:
                    postResultString = "Cancelled!"
                case SLComposeViewControllerResult.done.rawValue:
                    postResultString = "Post completed Successfully! :)"
                default:
                    postResultString = "Error Occurred :("
                }
                self.dismiss(animated: true, completion: nil)
                let postResultAlert = UIAlertController(title: "Post Result:", message: postResultString, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                postResultAlert.addAction(okAction)
                self.present(postResultAlert, animated: true, completion: nil)
            }
            self.present(fbPostForm!, animated: true, completion: nil)
            
        }else{
            let noFacebookAlert =  UIAlertController(title: "ERROR!!", message: "Facebook Account not configured", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            noFacebookAlert.addAction(okAction)
            self.present(noFacebookAlert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func postToTwitter(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            let twitterPostForm = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterPostForm?.setInitialText("Here are 140 characters of wisdom!")
            self.present(twitterPostForm!, animated:  true, completion: nil)
            
        }
        else{
            let noTwitterAlert =  UIAlertController(title: "ERROR!!", message: "Twitter Account not configured", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            noTwitterAlert.addAction(okAction)
            self.present(noTwitterAlert, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

