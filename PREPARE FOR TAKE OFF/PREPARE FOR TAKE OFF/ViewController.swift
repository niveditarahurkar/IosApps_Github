//
//  ViewController.swift
//  PREPARE FOR TAKE OFF
//
//  Created by nirahurk on 7/25/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var warpLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func enablePhotons(_ sender: Any) {
        let photonSwitch = sender as! UISwitch
        if(photonSwitch.isOn){
            self.view.backgroundColor = UIColor.red
        }else{
            self.view.backgroundColor=UIColor.yellow
        }
    }
    
    
    @IBAction func enableDampners(_ sender: UISwitch) {
        if(sender.isOn){
            self.view.backgroundColor = UIColor.brown
        }else{
            self.view.backgroundColor=UIColor.blue
        }
    }

    @IBOutlet weak var specialMsgLabel: UILabel!
    
    @IBAction func enableShields(_ sender: UISwitch) {
        if(sender.isOn){
            self.view.backgroundColor = UIColor.green
        }else{
            self.view.backgroundColor=UIColor.orange
        }
    }
    
    
    @IBAction func changeWarp(_ mySpeed: UISlider) {
        //print("Value: \(mySpeed.value)")
        warpLabel.text = "Warp Speed: \(mySpeed.value)"
        if mySpeed.value > 9.02 {
            specialMsgLabel.text="She's gonna blow!!"
            self.view.backgroundColor = UIColor.red
        }
        if mySpeed.value > 7.02 {
            specialMsgLabel.text="Warning!!! "
            self.view.backgroundColor = UIColor.yellow
        }
        else{
            self.view.backgroundColor = UIColor.white
            specialMsgLabel.text="Steady as she goes..."
        }
        
    }
    
    

    @IBAction func engage(_ sender: Any) {
        let engageAlert = UIAlertController(title: "Enagaged", message: "We boldly go..", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK cool", style: UIAlertActionStyle.cancel, handler:nil)
        engageAlert.addAction(okAction)
        present(engageAlert,animated: true,completion: nil)
        self.view.backgroundColor = .black
    }
        
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

