//
//  ViewController.swift
//  Collection Viewer
//
//  Created by nirahurk on 7/25/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{
   

    @IBOutlet weak var DVDCollectionView: UICollectionView!
    
    let DVDTitlesArray = ["A_Beautiful_Mind", "American_Beauty", "Rounders", "American_Hustle"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DVDTitlesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : movieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as! movieCollectionViewCell
        let movieTitle =  DVDTitlesArray[indexPath.row]
        cell.cellLabelView.text = movieTitle.replacingOccurrences(of: "_", with: " ")
        cell.cellImageView.image = UIImage(named: DVDTitlesArray[indexPath.row])
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsScreen = segue.destination as! DetailsViewController
        let selectedMovieIndex = self.DVDCollectionView.indexPath(for: sender as! movieCollectionViewCell)
        detailsScreen.movieKey = DVDTitlesArray[selectedMovieIndex!.row]
    }

}

