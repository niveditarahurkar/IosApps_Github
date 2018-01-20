//
//  MainMenuViewController.swift
//  Notifications Center Suite
//
//  Created by nirahurk on 7/27/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(MainMenuViewController.customNotificationHandler(_:)), name: NSNotification.Name(rawValue: "User Specs Notification"), object: nil)
        
    }
    
    var payload = [String:Any]()
    
    func customNotificationHandler(_ incomingNotification: Notification){
        print("hey")
        
        //grab the object from the notification
        let payloadObject = incomingNotification.object as AnyObject?
        let payloaddict = payloadObject as! NSDictionary
        //parse the text
        if let theMessage:String = payloaddict["Message"]! as? String {
            messageLabel.text = "Message: \(theMessage)"
            payload ["Message"] = theMessage
        }
        else{
            messageLabel.text = "<no message>"
        }
        //parse the color object
        if let theColor:UIColor = payloaddict["Color"]! as? UIColor{
            self.view.backgroundColor = theColor
        }
        else{
            self.view.backgroundColor = .black
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
