//
//  ViewController.swift
//  City Finder
//
//  Created by nirahurk on 7/27/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var citiesTextview: UITextView!
    
    @IBOutlet weak var countryNameTF: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var XMLResponseString = ""
    var webServiceData: NSMutableData?
    var citiesArray = [String]()
    var targetElementFound = false
    var allCitiesString = ""
    var myXMLParser = XMLParser()
    //xmlparser delegate:
    var foundACity = false
    var cityName = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Activity indicator set up
        spinner.isHidden = true
        spinner.activityIndicatorViewStyle = .whiteLarge
        spinner.color = UIColor.red
        spinner.hidesWhenStopped = true
    }
    
    
    
    @IBAction func getCitiesXML(_ sender: Any) {
        self.view.endEditing(true)
        spinner.isHidden = false
        spinner.startAnimating()
        
        XMLResponseString = ""
        citiesTextview.text = ""
        citiesArray.removeAll()
        
        //var soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope
        //xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"xmlns:xsd=\"http://
       //www.w3.org/2001/XMLSchema\"xmlns:soap=\"http://schemas.xmlsoap.org/soap/
        //envelope/\"> <soap:Body><GetCitiesByCountry xmlns=\"http://
        //www.webserviceX.NET\"<CountryName>\<(countryNameTF.text!)</CountryName></
        //GetCitiesByCounty></soap:Body></soap:Envelope>"
        
        var soapMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope
        xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"xmlns:xsd=\"http://
        www.w3.org/2001/XMLSchema\"xmlns:soap=\"http://schemas.xmlsoap.org/soap/
        envelope/\"> <soap:Body><GetCitiesByCountry xmlns=\"http://
        www.webserviceX.NET\"<CountryName>France</CountryName></
        GetCitiesByCounty></soap:Body></soap:Envelope>"
        
        print("\n\nSending out: '\(soapMessage)'\n")
        
        //creating a url object
        let theURL = URL(string: "http://www.webserviceX.NET/globalweather.asmx")
        //create a urlRequest object and configure it:
        var theRequest = URLRequest(url: theURL!)
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.addValue("\(soapMessage.characters.count)", forHTTPHeaderField: "Content-Length")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false)
        
        //URLSession set up:
        let defaultConfigObject = URLSessionConfiguration.default
        //Create a url session and start ("resume") it:
        let defaultSession = Foundation.URLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: OperationQueue.main)
        let dataTask = defaultSession.dataTask(with: theRequest)
        dataTask.resume()
        
        
    }
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void){
        print("SESSION didReceiveResponse")
        completionHandler(Foundation.URLSession.ResponseDisposition.allow)
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data){
        let incomingXMLString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
        print("\n \n SESSION 'didReceive data', incomingXMLString = '\(incomingXMLString)'\n\n")
        
        XMLResponseString += incomingXMLString
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didCompletionWithError error: Error?){
        print("\n \n URLSESSION -- didCompletionWithError")
        if error == nil {
           print("\nThe Download task was completed without errors!")
            print("\n \n DONE -- Received Bytes = \(XMLResponseString.data(using: String.Encoding.utf8)!.count)")
            
            //Replace "&lt;" and "&gt;" eith "<"  and ">":
            var mynewXML = XMLResponseString.replacingOccurrences(of: "&lt;", with: "<")
            mynewXML = mynewXML.replacingOccurrences(of: "&gt;", with: ">")
            myXMLParser = XMLParser(data: mynewXML.data(using: <#T##String.Encoding#>.utf8)!)
            print("mynewXML = '\(mynewXML)'")
            
            myXMLParser.delegate = self
            myXMLParser.shouldResolveExternalEntities = true
            myXMLParser.parse()
            
        }
        else{
            print("\n Download Error: \(error!.userInfo)")
        }
        
    }
    
    func parser(_ parser: XMLParser, didStartEement elementName: String, namespaceURI:String?, qualifiedName qName: String?, attributes attributeDict : [String: string]){
        if elementName == "City" {
            print("\nfound the following element: \(elementName)")
            foundACity = true
            
        }
    }
    
    func parser(_ parser: XMLParser, didEndEement elementName: String, namespaceURI:String?, qualifiedName qName: String?){
        if foundACity == true {
            print("\n New City: '\(cityName)'")
            citiesArray.append(cityName)
            foundACity = false
            cityName = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        if foundACity == true {
            print("\n Found characters.. ")
            cityName += string

        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser){
        
        for (cityIndex, tempCity) in citiesArray.enumerated(){
            allCitiesString = allCitiesString + "\(cityIndex). \(tempCity)\n"
        }
        citiesTextview.text = allCitiesString
        allCitiesString = ""
        XMLResponseString = ""
        spinner.stopAnimating()
        spinner.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

