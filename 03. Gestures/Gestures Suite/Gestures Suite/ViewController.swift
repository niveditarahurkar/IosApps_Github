//
//  ViewController.swift
//  Gestures Suite
//
//  Created by nirahurk on 7/26/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    
    @IBOutlet weak var amoreImageView: UIImageView!
    
    let pinchGestureRecognizer = UIPinchGestureRecognizer()
    let panGestureRecognizer = UIPanGestureRecognizer()
    let rotationGestureRecognizer = UIRotationGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pinchGestureRecognizer.addTarget(self, action: #selector(ViewController.pinchAction(_ :)))
        panGestureRecognizer.addTarget(self, action: #selector(ViewController.panAction(_ :)))
        rotationGestureRecognizer.addTarget(self, action: #selector(ViewController.rotationAction(_ :)))
        amoreImageView.addGestureRecognizer(pinchGestureRecognizer)
        amoreImageView.addGestureRecognizer(panGestureRecognizer)
        amoreImageView.addGestureRecognizer(rotationGestureRecognizer)
        
    }
    
    func pinchAction(_ imgView:UIPinchGestureRecognizer){
        print("Scale = \(imgView.scale)")
            self.view.bringSubview(toFront:amoreImageView)
            imgView.view!.transform = amoreImageView.transform.scaledBy(x:imgView.scale, y:imgView.scale)
        imgView.scale = 1.0
    }
    
    func panAction(_ thePan:UIPanGestureRecognizer){
        let distanceMoved = thePan.translation(in: self.view)
        thePan.view!.center = CGPoint(x: thePan.view!.center.x + distanceMoved.x, y: thePan.view!.center.y + distanceMoved.y)
        thePan.setTranslation(CGPoint.zero, in: self.view)
        
    }
    
    
    func rotationAction(_ imgView:UIRotationGestureRecognizer){
        imgView.view!.transform = imgView.view!.transform.rotated(by: imgView.rotation)
        imgView.rotation = 0
    
    }
    
    
    
    
    
    @IBOutlet weak var tappingLabel: UILabel!
    
    
    @IBAction func singleTap(_ sender: UITapGestureRecognizer) {
        let tappedView = sender.view as UIView!
        let biggerFrame = CGRect(x: tappedView!.frame.origin.x-10, y:tappedView!.frame.origin.y-10, width:tappedView!.frame.size.width + 20, height: tappedView!.frame.size.height + 20 )
        tappedView!.frame = biggerFrame
    }
   
    
    @IBAction func doubleTap(_ sender: UITapGestureRecognizer) {
        
        print("double!")
        let tappedView = sender.view as UIView!
        let bottomLeftFrame = CGRect(x: 0, y: UIScreen.main.bounds.height-25, width: 100, height: 25)
        tappedView!.frame = bottomLeftFrame
    }
    
    
    @IBOutlet weak var swipeLabel: UILabel!
    
    
    
    @IBAction func swipeAction(_ sender: UISwipeGestureRecognizer) {
        let swipedLabel = sender.view as! UILabel
        swipedLabel.text = "Swiped Left!"
        swipedLabel.textColor = UIColor.green
        swipedLabel.backgroundColor = UIColor.white
        
    }

    
    @IBAction func rightSwipeAction(_ sender: UISwipeGestureRecognizer) {
        let swipedLabel = sender.view as! UILabel
        swipedLabel.text = "Swiped Right!"
        swipedLabel.textColor = UIColor.red
        swipedLabel.backgroundColor = UIColor.white
    }
    
    
    
    @IBOutlet weak var longPressLabel: UILabel!
    
    @IBAction func pressurizer(_ sender: UILongPressGestureRecognizer) {
        let pressedLabel = sender.view! as! UILabel
         UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.5)
        pressedLabel.transform = CGAffineTransform(rotationAngle:CGFloat(M_PI))
        self.view.backgroundColor = UIColor.black
        UIView.commitAnimations()
    }
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

