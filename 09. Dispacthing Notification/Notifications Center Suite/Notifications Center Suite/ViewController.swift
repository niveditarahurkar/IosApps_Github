//
//  ViewController.swift
//  Notifications Center Suite
//
//  Created by nirahurk on 7/27/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var broadcastMessageTF: UITextField!
    
    
    @IBAction func broadcast(_ sender: Any) {
        print("\n will broadcast the following Message '\(broadcastMessageTF.text!)'\n")
        //hide the keboard:
        self.view.endEditing(true)
        //create a random UIColor object
        
        var randomColor = UIColor()
        let x = arc4random_uniform(5)
        switch x {
        case 0:
            randomColor = UIColor.blue
        case 1:
            randomColor = UIColor.red
        case 2:
            randomColor = UIColor.yellow
        case 3:
            randomColor = UIColor.green
            
        default:
            randomColor = UIColor.white
        }
        
        //create a payload dictionary
        let payloadDict = ["Message":"\(broadcastMessageTF.text!)","Color":randomColor] as [String: Any]
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Notification.Name(rawValue: "User Specs Notification"), object: payloadDict)
        self.navigationController!.popToRootViewController(animated: true)

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Access the notification center:
        let notificationCenter = NotificationCenter.default
        //Register to observe any Device-Orientation change notifications:
        notificationCenter.addObserver(self,selector: #selector(ViewController.displayCurrentOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object:nil )
        notificationCenter.addObserver(self, selector: #selector(ViewController.respondToKeyBoardUp),name: NSNotification.Name.UIKeyboardDidShow, object: nil )
    }
    
    //function to fire whenever an Orientation- change notification arrives
    
    func displayCurrentOrientation(){
        var deviceOrientationString = ""
        switch UIDevice.current.orientation {
        case .landscapeLeft:
            deviceOrientationString = "LANDSCAPE LEFT!"
        case .landscapeRight:
            deviceOrientationString = "LANDSCAPE RIGHT!"
        case .portraitUpsideDown:
            deviceOrientationString = "UPSIDE DOWN!"
        default:
            deviceOrientationString = "POTRAIT!"
        }
        print("Orientation changed to: \(deviceOrientationString)")
        
    }

    func respondToKeyBoardUp(){
        print("Keyboard is up!")
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

