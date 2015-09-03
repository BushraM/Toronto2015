//
//  EventDetail.swift
//  Toronto2015
//
//  Created by Bushra Mohamed on 2015-04-05.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import UIKit
import MapKit

class EventDetail: UIViewController {
    
    @IBOutlet weak var dateAdded: UILabel!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var eventPicture: UIImageView!
    
    //Displays the users current location and the location of the venue
    @IBOutlet weak var eventMap: MKMapView!
  
    
    
    var detailItem:Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Formats the date
        let date = NSDateFormatter.localizedStringFromDate(detailItem.dateAdded, dateStyle: NSDateFormatterStyle.LongStyle, timeStyle: NSDateFormatterStyle.NoStyle)
        dateAdded.text = String(format: "Added: \(date)")
        
        text.text = "\(detailItem.text)"
        
        eventPicture.contentMode = UIViewContentMode.ScaleAspectFit
        eventPicture.image = UIImage(data: detailItem.photo)
        
        
        //Setting the map
        let latitude = detailItem.latitude as Double
        let longitude = detailItem.longitude as Double
    
        
        var location = CLLocationCoordinate2DMake(latitude, longitude)
        
        var span = MKCoordinateSpanMake(0.002, 0.002)
        
        var region = MKCoordinateRegion(center: location, span: span)
        
        eventMap.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = detailItem.title
        
        eventMap.addAnnotation(annotation)
        
    }
    
    
}

