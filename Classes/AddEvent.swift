//
//  EventEdit.swift
//  Toronto2015
//
//  Created by Bushra Mohamed on 2015-04-05.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import UIKit
import CoreLocation

class AddEvent: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pic: UIImage?
    
    var delegate: EditItemDelegate?
    
    var model: Model!
  
    var locationManger = CLLocationManager()
    
    //displays the image to the user before saving
    @IBOutlet weak var currentPicture: UIImageView!
    
    // The value for these properties will come from the current location of the user
    var latitude: Double!
    var longitude: Double!
    
    //UI
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteText: UITextView!
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        delegate?.editItemController(self, didEditItem: nil)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        var todaysDate:NSDate = NSDate()
        
        let newItem = model.addNew("Event") as Event
        newItem.title = noteTitle.text
        newItem.text = noteText.text
        newItem.dateAdded = todaysDate
        
        newItem.latitude = latitude
        newItem.longitude = longitude
        
        //Saving the image
        
        //convert the image to NSData
        let pngData: NSData = UIImagePNGRepresentation(currentPicture.image)
        newItem.photo = pngData
    
        delegate?.editItemController(self, didEditItem: newItem)
    }
    
    //Taking photo methods
    @IBAction func chooseFromCamer(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        //Device has camera
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            picker.sourceType = .Camera
        }else{
            //Uses photo library instead of the camera
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
       
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    //Delegate method
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        // Get the image that was selected
        let selectedImage: UIImage = (info as NSDictionary).objectForKey("UIImagePickerControllerOriginalImage") as UIImage
        
        let imgRef: CGImageRef = selectedImage.CGImage
        let w: UInt = CGImageGetWidth(imgRef)
        let h: UInt = CGImageGetHeight(imgRef)
        let orient: UIImageOrientation = selectedImage.imageOrientation
        
        // If the image is too big, scale it smaller
        
        var image: UIImage? = nil
        
        // Save the image to a property of this class
        // Which can then be used by the 'save' method
        
        self.pic = selectedImage
        
        currentPicture.image = selectedImage
        
        // Dismiss the view controller
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Making the note body look better
        noteText.layer.borderWidth = 1.0
        noteText.layer.cornerRadius = 8.0
        var newColor = UIColor.lightGrayColor().CGColor
        noteText.layer.backgroundColor = newColor
        
        //Making the title textfield look better
        noteTitle.layer.backgroundColor = newColor
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
    }
    
    //Methods for getting current location
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Error")
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        //Get the first result 
        var userLocation: CLLocation = locations[0] as CLLocation
        
        locationManger.stopUpdatingLocation()
        
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        
    }
    
}

protocol EditItemDelegate {
    func editItemController(controller: AnyObject, didEditItem item: AnyObject?)
}

