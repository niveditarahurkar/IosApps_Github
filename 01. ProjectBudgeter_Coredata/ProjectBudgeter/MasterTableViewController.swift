//
//  MasterTableViewController.swift
//  ProjectBudgeter
//
//  Created by nirahurk on 7/25/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import UIKit
import CoreData

class MasterTableViewController: UITableViewController {
    
    var projectItemsArray = [ProjectItem]()
    var runningTotal:Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated : Bool) {
        super.viewDidAppear(animated)
        let theAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let manObjContext = theAppDelegate.persistentContainer.viewContext
        let myFetchReq:NSFetchRequest<ProjectItem> = ProjectItem.fetchRequest()
        //create a predicate/filter for search request
        //let searchFilter = NSPredicate(format: "price > 2.00")
        //myFetchReq.predicate = searchFilter
        let sortDesc = NSSortDescriptor(key: "price", ascending: false)
        let sortArray = [sortDesc]
        myFetchReq.sortDescriptors = sortArray
        
        projectItemsArray = try! manObjContext.fetch(myFetchReq)
        
        self.tableView.reloadData()
        self.calculateTotal()

    }
    
    func calculateTotal(){
        runningTotal = 0
        for tempItem in projectItemsArray{
            let itemPrice :Float = tempItem.price
            let itemQty:Int =  Int(tempItem.quantity)
            runningTotal += (itemPrice * Float(itemQty))
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return projectItemsArray.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectItemCell", for: indexPath)

        // Configure the cell...
        let currentProjectItem = projectItemsArray[indexPath.row]
        cell.textLabel!.text = currentProjectItem.name
        cell.textLabel!.textColor = .blue
        cell.detailTextLabel!.text = "$\(currentProjectItem.price), Quantity: \(currentProjectItem.quantity)"
        cell .detailTextLabel!.textColor = UIColor.red
        cell.detailTextLabel?.font = UIFont(name: "Arial", size:16)

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Running Total: $\(runningTotal)"
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let theAppDelegate = UIApplication.shared.delegate as! AppDelegate
            let manObjContext = theAppDelegate.persistentContainer.viewContext
            manObjContext.delete(projectItemsArray[indexPath.row])
            projectItemsArray.remove(at: indexPath.row)
            
            // Delete the row from the data source

            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try manObjContext.save()
            } catch {
                print("Couldn't delete")
            }
        }
        self.tableView.reloadData()
        self.calculateTotal()
        if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailsSegue" {
            let selectedItemIndexPath = self.tableView.indexPathForSelectedRow
            let selectedProjectItem = projectItemsArray[selectedItemIndexPath!.row]
            let detailsScreen = segue.destination as! DetailsViewController
            detailsScreen.featuredItem = selectedProjectItem
        }
    }
 

}
