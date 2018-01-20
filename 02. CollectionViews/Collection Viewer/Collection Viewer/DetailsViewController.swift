//
//  DetailsViewController.swift
//  Collection Viewer
//
//  Created by nirahurk on 7/25/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {


        @IBOutlet weak var posterImageView: UIImageView!
        @IBOutlet weak var movieNameLabel: UILabel!
        var movieKey = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            print("moviekey: \(movieKey)")
            posterImageView.image = UIImage(named: movieKey)
            movieNameLabel.text = movieKey.replacingOccurrences(of: "_", with: " ")
            
            // Do any additional setup after loading the view.
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
