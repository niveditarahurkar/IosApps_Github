//
//  PhotoSelectViewController.swift
//  PhotoEditingApp
//
//  Created by nirahurk on 11/14/17.
//  Copyright © 2017 nirahurkIOS. All rights reserved.
//

import Foundation
import UIKit

class PhotoSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var filteredImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var photoFromLibraryButton: UIButton!
    
    var CIFilterNames = [
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CISepiaTone"]
    //Image filter variables
    //var context: CIContext = CIContext(options: nil)
    var appliedFilter: CIFilter!
    var name: String?
    
    @IBOutlet var imageView: UIImageView!
    let picker = UIImagePickerController()
    //set default image
    var theImagePassed = UIImage()
    var myFlag = true
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        //imageView.image = theImagePassed
        print("PhotoSelectViewController:inside viewDidLoad")
        //hide filter screens
        if self.myFlag == true {
            print("PhotoSelectViewController:inside viewDidLoad if")
            modifyFilterScreen(value: true)
        }
    else {
            print("PhotoSelectViewController:inside viewDidLoad else")
           showFilterScreen()
       }
        //using gpu
        let openGLContext = EAGLContext(api: .openGLES2)
        let context = CIContext(eaglContext: openGLContext!)
    
        
    }
    override func viewWillAppear(_ animated: Bool) {
      /*
        print("PhotoSelectViewController:inside viewWillAppear")
        if self.myFlag == true {
            print("PhotoSelectViewController:inside viewWillAppear if")
            modifyFilterScreen(value: true)
        }
        else {
            print("PhotoSelectViewController:inside viewWillAppear else")
            showFilterScreen()
        }*/
    }
    func modifyFilterScreen(value : Bool){
         self.navigationController?.isNavigationBarHidden = value
        scrollView?.isHidden = value
        saveButton?.isHidden = value
        cancelButton?.isHidden = value
        scrollView?.isHidden = value
        filteredImageView?.isHidden = value
        filterButton?.isHidden = true
    }
    func modifyOriginalScreen(value:Bool)  {
        imageView?.isHidden = value
        takePhotoButton?.isHidden = value
        photoFromLibraryButton?.isHidden = value
        filterButton?.isHidden = true
    }
    func showFilterScreen() {
        var value = false
        self.navigationController?.isNavigationBarHidden = value
        scrollView?.isHidden = value
        saveButton?.isHidden = value
        cancelButton?.isHidden = value
        scrollView?.isHidden = value
        filteredImageView?.isHidden = value
        //filterButton?.isHidden = true
        modifyOriginalScreen(value: true)
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true, completion: nil)
        }else{
            noCamera()
        }
    }
    func takePhotoFromCamera(){
        print("takePhotoFromCamera:")
        applyImageToScrollView(image: theImagePassed)
        filteredImageView.image = theImagePassed
        showFilterScreen()
    }
    
    override func viewDidAppear(_ animated : Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func photoFromLibrary(_ sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        //picker.modalPresentationStyle = .popover
        present(picker,animated: true, completion: nil)
        //picker.popoverPresentationController?.butt = sender as! UIBarButtonItem
    }
    //Open popup for filters type

   
    @IBAction func actionCancel(_ sender: UIButton) {
        //self.loadView()
        self.myFlag = true
        self.modifyOriginalScreen(value: false)
        self.modifyFilterScreen(value: true)
        /////
        /*
        let actionSheet = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: handleFilterSelection))
        actionSheet.addAction(UIAlertAction(title: "CIVignetteEffect", style: .default, handler: handleFilterSelection))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
 */
    }
    @IBAction func filterButtonTapped(sender: UIButton) {
        let button = sender as UIButton
        
        filteredImageView.image = button.backgroundImage(for:UIControlState.normal)
    }
    /*func handleFilterSelection(action: UIAlertAction!) {
        appliedFilter = CIFilter(name: action.title!)
        
        let beginImage = CIImage(image: filteredImageView.image!)
        appliedFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyFilter()
    }
 
    func applyFilter() {
        let inputKeys = appliedFilter.inputKeys
        let intensity = 0.5
        if inputKeys.contains(kCIInputIntensityKey) {
            appliedFilter.setValue(intensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            appliedFilter.setValue(intensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            appliedFilter.setValue(intensity * 10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputCenterKey) {
            appliedFilter.setValue(CIVector(x: imageView.image!.size.width / 2, y: imageView.image!.size.height / 2), forKey: kCIInputCenterKey)
        }
        let cgImage = context.createCGImage(appliedFilter.outputImage!, from: appliedFilter.outputImage!.extent)
        let filteredImage = UIImage(cgImage: cgImage!)
        self.imageView.image = filteredImage
    }
     */
    @IBAction func onSaveButton(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(filteredImageView.image!, nil, nil, nil)
        let alert = UIAlertView(title: "Filters",
                                message: "Your image has been saved to Photo Library",
                                delegate: nil,
                                cancelButtonTitle: "OK")
        alert.show()
        self.myFlag = true
        self.modifyOriginalScreen(value: false)
        self.modifyFilterScreen(value: true)
        
    }
    
    func applyImageToScrollView(image: UIImage){
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 70
        let buttonHeight: CGFloat = 70
        let gapBetweenButtons: CGFloat = 5
        
        var itemCount = 0
        
        for i in 0..<CIFilterNames.count {
            itemCount = i
            
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = itemCount
            filterButton.addTarget(self, action: #selector(PhotoSelectViewController.filterButtonTapped(sender:)), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            
            // Create filters for each button
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: image)
            let filter = CIFilter(name: "\(CIFilterNames[i])" )
            filter!.setDefaults()
            filter!.setValue(coreImage, forKey: kCIInputImageKey)
            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
            let imageForButton = UIImage(cgImage: filteredImageRef!);
            // Assign filtered image to the button
            filterButton.setBackgroundImage(imageForButton, for: .normal)
            // Add Buttons in the Scroll View
            xCoord +=  buttonWidth + gapBetweenButtons
            scrollView.addSubview(filterButton)
        } // END FOR LOOP
        
        // Resize Scroll View
        scrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount+2), height:yCoord)
    }
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        filteredImageView.contentMode = .scaleAspectFit //3
        filteredImageView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
        applyImageToScrollView(image: chosenImage)
        showFilterScreen()

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
