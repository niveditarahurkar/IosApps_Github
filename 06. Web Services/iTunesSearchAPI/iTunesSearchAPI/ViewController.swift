//
//  ViewController.swift
//  iTunesSearchAPI
//
//  Created by nirahurk on 7/26/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var artistNameTF: UITextField!
    
    @IBOutlet weak var resultsTV: UITextView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var albumsFoundArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    // activity indicator setup
    activityIndicator.isHidden = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.color = UIColor.red
        activityIndicator.hidesWhenStopped = true
    }
    
    
    @IBAction func searchiTunesDB(_ sender: Any) {
        self.view.endEditing(true)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        resultsTV .text = ""
        albumsFoundArray.removeAll(keepingCapacity: false)
        let artistNameFixed = artistNameTF.text!.replacingOccurrences(of: " ", with: "+")
        let urlSearchString:String = "http://itunes.apple.com/search?term=\(artistNameFixed)&media=music"
        print("urlSearchString = \(urlSearchString)")
        let iTunesSearchURL = URL(string: urlSearchString)
        
        //start a url session
        let myWebServiceSession = URLSession.shared
        let dataTask = myWebServiceSession.dataTask(with: iTunesSearchURL!, completionHandler: {(webServiceData, respnse, error) in do{
            let searchResultJSON = try JSONSerialization.jsonObject(with: webServiceData!, options: []) as! [String:AnyObject]
            //print("Received JSON = \(searchResultJSON)")
            
            //Parse the json dictionary as [key: String: value: AnyObject]
            let searchResultsArray = searchResultJSON["results"] as! [AnyObject]
            var outputString = ""
            for counter in 0..<searchResultsArray.count {
                if let tempDict = searchResultsArray[counter] as? [String: AnyObject] {
                    print("tempDict = \(tempDict)\n\n")
                    if let foundAlbumName = tempDict["collectionName"]{
                        let theAlbum = foundAlbumName as! String
                        if !self.albumsFoundArray.contains(theAlbum) {
                            self.albumsFoundArray.append(theAlbum)
                            outputString += ". "+theAlbum + "\n"
                            
                        }
                    }
                    else{
                        print("===>>'collectionName' NOT FOUND")
                    }
                    
                }
                
                
            }
            DispatchQueue.main.async {
                self.resultsTV.text = "\(outputString)"
                self.activityIndicator.stopAnimating()
            }
        }catch{
            print("json error: \(error)")
            }})
        dataTask.resume()
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

