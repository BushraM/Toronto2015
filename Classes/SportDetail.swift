//
//  SportDetail.swift
//  Toronto2015
//
//  Created by Bushra Mohamed on 2015-03-10.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import UIKit

class SportDetail: UIViewController {

    @IBOutlet weak var hostId: UILabel!
    @IBOutlet weak var sportName: UILabel!
    @IBOutlet weak var sportDesc: UITextView!
    @IBOutlet weak var howItWorks: UITextView!
    @IBOutlet weak var history: UITextView!
    @IBOutlet weak var venues: UILabel!
    @IBOutlet weak var myScrollView: UIScrollView!
    
    
    // Data object, passed in by the parent view controller in the segue method
    var detailItem: Sport!
    
    @IBOutlet weak var sportPhoto: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        sportPhoto.contentMode = UIViewContentMode.ScaleAspectFit
        sportPhoto.image = UIImage(data: detailItem.photo)
        
        var venueLists = ""
        
        for vn in detailItem.venues {
            
            let venue = vn as Venue
            venueLists += ("\(venue.venueName)"+",")
        }

        
        sportName.text = "Sport Name: \(detailItem.sportName)"
        hostId.text = "Host Id: \(detailItem.hostId)"
        
        
        sportDesc.text = "\(detailItem.sportDescription)"
        howItWorks.text = "\(detailItem.howItWorks)"
        
        history.text = "\(detailItem.history)"
        
        venues.text = "\(venueLists)"
        
        
    }

}
