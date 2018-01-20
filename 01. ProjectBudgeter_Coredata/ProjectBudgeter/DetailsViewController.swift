//
//  ViewController.swift
//  ProjectBudgeter
//
//  Created by nirahurk on 7/25/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {


    @IBOutlet weak var ITF: UITextField!
    
    
    @IBOutlet weak var priceTF: UITextField!
    
    
    @IBOutlet weak var qtyTF: UITextField!
    
    var featuredItem: ProjectItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(featuredItem != nil){
            ITF.text = featuredItem!.name
            priceTF.text = "\(featuredItem!.price)"
            qtyTF.text = "\(featuredItem!.quantity)"
        }
        self.navigationItem.leftBarButtonItem = self.editButtonItem

    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController!.popToRootViewController(animated: true)
    }
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let theAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = theAppDelegate.persistentContainer.viewContext
        
        //check if we are working with existing item
        
        if featuredItem != nil {
            featuredItem!.name = ITF.text
            featuredItem!.price = Float(priceTF.text!)!
            featuredItem!.quantity = Int32(qtyTF.text!)!
        }
        
        else{
            let newProjectItem = ProjectItem(context: managedObjectContext)
            newProjectItem.name = ITF.text!
            newProjectItem.price = Float(priceTF.text!)!
            newProjectItem.quantity = Int32(qtyTF.text!)!
            
            // verify creation:
            print("Value of new Object: \(newProjectItem.description)")
            
        }
        
        //save the context
        do{
            try managedObjectContext.save()
        }catch let theError as NSError{
            print("Error: \(theError)")
        }
        
        self.navigationController!.popToRootViewController(animated: true)
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

