//
//  Event.swift
//  Toronto2015
//
//  Created by Bushra Mohamed on 2015-04-05.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import Foundation
import CoreData

class Event: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var text: String
    @NSManaged var photo: NSData
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var dateAdded: NSDate

}
