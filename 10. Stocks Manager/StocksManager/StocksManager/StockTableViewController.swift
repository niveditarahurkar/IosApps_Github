//
//  ViewController.swift
//  StocksManager
//
//  Created by nirahurk on 8/12/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import UIKit


class StockTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    //private let stocks = ["AAPL","FB","GOOG"]
    private var stocks: [(String,Double)] = [("AAPL",+1.5),("FB",+2.33),("GOOG",-4.3)]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //2
        NotificationCenter.default.addObserver(self, selector: #selector(StockTableViewController.stocksUpdated(_:)), name: NSNotification.Name(rawValue: kNotificationStocksUpdated), object: nil)
        self.updateStocks()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cellId")
        cell.textLabel!.text = stocks[indexPath.row].0 //position 0 of the tuple: The Symbol "AAPL"
        cell.detailTextLabel!.text = "\(stocks[indexPath.row].1)" + "%" //position 1 of the tuple: The value "1.5" into String
        return cell
    }
    
    //UITableViewDelegate
    func tableView(_ tableView: UITableView!, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //Customize the cell
    func tableView(_ tableView: UITableView!, willDisplay cell: UITableViewCell!, forRowAt indexPath: IndexPath) {
        switch stocks[indexPath.row].1 {
        case let x where x < 0.0:
            cell.backgroundColor = UIColor(red: 255.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1.0)
        case let x where x > 0.0:
            cell.backgroundColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        case let x:
            cell.backgroundColor = UIColor(red: 44.0/255.0, green: 186.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        }
        
        cell.textLabel!.textColor = UIColor.white
        cell.detailTextLabel!.textColor = UIColor.white
        cell.textLabel!.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 48)
        cell.detailTextLabel!.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 48)
        cell.textLabel!.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        cell.textLabel!.shadowOffset = CGSize(width: 0, height: 1)
        cell.detailTextLabel!.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        cell.detailTextLabel!.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    //Customize the height of the cell
    func tableView(_ tableView: UITableView!, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //Stock updates
    //3
    func updateStocks() {
        let stockManager:StockManagerSingleton = StockManagerSingleton.sharedInstance
        stockManager.updateListOfSymbols(stocks)
        
        //Repeat this method after 15 secs. (For simplicity of the tutorial we are not cancelling it never)
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(15 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: {
                self.updateStocks()
        }
        )
    }
    
    //4
    func stocksUpdated(_ notification: Notification) {
        let values = (notification.userInfo as! Dictionary<String,NSArray>)
        let stocksReceived:NSArray = values[kNotificationStocksUpdated]!
        stocks.removeAll(keepingCapacity: false)
        for quote in stocksReceived {
            let quoteDict:NSDictionary = quote as! NSDictionary
            var changeInPercentString = quoteDict["ChangeinPercent"] as! String
            let changeInPercentStringClean=changeInPercentString.substring(to:changeInPercentString.index(before: changeInPercentString.endIndex))
            var tuple : (String,Double) = (quoteDict["symbol"] as! String,(changeInPercentStringClean as NSString).doubleValue)
            stocks.append(tuple)
        }
        tableView.reloadData()
        NSLog("Symbols Values updated :)")
    }
}

