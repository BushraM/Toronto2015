//
//  VenueDetail.swift
//  Toronto2015
//
//  Created by Bushra Mohamed on 2015-03-10.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import UIKit
import MapKit

class VenueDetail: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var hostId: UILabel!
    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var location: UITextView!
    @IBOutlet weak var venueDescritpion: UITextView!
    @IBOutlet weak var sport: UITextView!
    @IBOutlet weak var venuePhoto: UIImageView!
    @IBOutlet weak var mapLocation: MKMapView!
   
    var locationManger = CLLocationManager()
    
    // Data object, passed in by the parent view controller in the segue method
    var detailItem: Venue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        venuePhoto.contentMode = UIViewContentMode.ScaleAspectFit
        venuePhoto.image = UIImage(data: detailItem.photo)
        
        hostId.text = ("Host Id: \(detailItem.hostId)")
        
        venueName.text = ("Venue Name: \(detailItem.venueName)")
        
        location.text = ("\(detailItem.location)")
        
        venueDescritpion.text = ("\(detailItem.venueDescription)")
        
        var sportList = ""
        for vn in detailItem.sports {
            
            let sport = vn as Sport
            sportList += ("\(sport.sportName)"+",")
        }
        
        sport.text = "\(sportList)"
        
        //Gets the venue location and place it on the map
        putVenueLocationOnMap()
        
        //Gets the user's current location
        configureLocationObjects()
        
    }
    
    //translates the location string to a location in a map
    func putVenueLocationOnMap(){
        
        var venueAddress = location.text
        
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(venueAddress, {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark {
                self.mapLocation.addAnnotation(MKPlacemark(placemark: placemark))
            }
        })
    }
    
    private func configureLocationObjects() {
        
        // Configure the location manager
        
        locationManger.delegate = self
        
        // Change these values to affect the update frequency
        locationManger.distanceFilter = 100
        locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // Set location to run only when the app is in the foreground
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
    }

    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Error")
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {

        //Get the first result
        var userLocation: CLLocation = locations[0] as CLLocation
        locationManger.stopUpdatingLocation()
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        
        //Displaying the map using the current coordinates
        var location = CLLocationCoordinate2DMake(latitude, longitude)
        var span = MKCoordinateSpanMake(0.2, 0.2)
        var region = MKCoordinateRegion(center: location, span: span)
        
        mapLocation.setRegion(region, animated: true)
        
        //Adding the pin on the map and adding a title to the pin
        var annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "Your Current Location"
        
        mapLocation.addAnnotation(annotation)
        
    }
    
    

}
