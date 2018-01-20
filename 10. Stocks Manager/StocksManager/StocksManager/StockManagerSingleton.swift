//
//  File.swift
//  StocksManager
//
//  Created by nirahurk on 8/15/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import Foundation
class StockManagerSingleton  {
    //Singleton intialization
    static let instance:StockManagerSingleton = StockManagerSingleton()
    private init(){
        print("StockManagerSingleton");
    }
    
    func printTest() {
        NSLog("TEST OK :)")
    }
    
    
    /*!
     * @discussion Function that given an array of symbols, get their stock prizes from yahoo and send them inside a NSNotification UserInfo
     * @param stocks An Array of tuples with the symbols in position 0 of each tuple
     */
    func updateListOfSymbols(stocks:Array<(String,Double)>) ->() {
        
        //1: YAHOO Finance API: Request for a list of symbols example:
        //http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.quotes where symbol IN ("AAPL","GOOG","FB")&format=json&env=http://datatables.org/alltables.env
        //https://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20yahoo.finance.oquote%20WHERE%20symbol%20IN%20(%22AAPL%22,%22FB%22,%22GOOG%22)&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys
        //2: Build the URL as above with our array of symbols
        var stringQuotes = "(";
        
        for quoteTuple in stocks {
            stringQuotes = stringQuotes+"\""+quoteTuple.0+"\","
        }
        stringQuotes = stringQuotes.substring(to: stringQuotes.index(before: stringQuotes.endIndex))
       // stringQuotes = stringQuotes.substringToIndex(stringQuotes.endIndex.predecessor())
        stringQuotes = stringQuotes + ")"
        
        let urlString:String = ("https://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.oquote where symbol IN "+stringQuotes+"&diagnostics=true&env=store").addingPercentEscapes(using: String.Encoding.utf8)!
        var newStr:String = (""+urlString + "%3A%2F%2Fdatatables.org%2Falltableswithkeys")
        
       
        let url = URL(string: newStr)
        //print(url?.absoluteString)
        let request = URLRequest(url: url!)
        print("request: ")
        print(request)
        //let config = URLSessionConfiguration.default
        //let session = URLSession(configuration: config)
        
        //3: Completion block/Clousure for the URLSessionDataTask
        
        /*let task : URLSessionDataTask = session.dataTask(with:request, completionHandler: {data, response, error -> Void in
            
            if((error) != nil) {
                print(error?.localizedDescription)
            }
            else {
                var err: NSError?
                //4: JSON process
                var json = JSONSerialization.jsonObject(with: data, options: JSONSerialization.mutableCopy())
                var jsonDict = JSONSerialization.JSONObjectWithData(data, options: JSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                if(err != nil) {
                    print("JSON Error \(err!.localizedDescription)")
                }
                else {
                    //5: Extract the Quotes and Values and send them inside a NSNotification
                    var quotes:NSArray = ((jsonDict.objectForKey("query") as NSDictionary).objectForKey("results") as NSDictionary).objectForKey("quote") as NSArray
                    dispatch_async(dispatch_get_main_queue(), {
                        NSNotificationCenter.defaultCenter().postNotificationName(kNotificationStocksUpdated, object: nil, userInfo: [kNotificationStocksUpdated:quotes])
                    })
                }
            }
        })
        */
        
        
        //start a url session
        let myWebServiceSession = URLSession.shared
        let task = myWebServiceSession.dataTask(with: request, completionHandler: {(webServiceData, response, error) in do
        {print("in do")
            //let searchResultJSON = try JSONSerialization.jsonObject(with: webServiceData!, options: []) as! [String:AnyObject]
            //print("Received JSON = \(searchResultJSON)")
            
            //4: JSON process
            var err: NSError?
            print("webServiceData:  \(webServiceData)")
            var jsonDict = try JSONSerialization.jsonObject(with: webServiceData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            print("JSON dict:  \(jsonDict)")
            //var jsonDict = JSONSerialization.JSONObjectWithData(webServiceData, options: JSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            else {
                //5: Extract the Quotes and Values and send them inside a NSNotification
                var quotes:NSArray = (((jsonDict as AnyObject).object(forKey:"query") as! NSDictionary).object(forKey:"results") as! NSDictionary).object(forKey: "quote") as! NSArray
                DispatchQueue.main.async(execute: {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: kNotificationStocksUpdated), object: nil, userInfo: [kNotificationStocksUpdated:quotes])
                })
            }
            
            
        }catch{
            print("json error: \(error)")
            }})
        //6:  LAUNCH the URLSessionDataTask!!!!!!
        task.resume()
    }
    
    
}
