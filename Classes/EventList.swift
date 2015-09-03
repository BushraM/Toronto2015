//
//  EventList.swift
//  Toronto2015
//
//  Created by Bushra Mohamed on 2015-04-05.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import UIKit
import CoreData

class EventList: UITableViewController, NSFetchedResultsControllerDelegate, EditItemDelegate {
    
    // MARK: - Private properties
    
    var frc: NSFetchedResultsController!
    
    // MARK: - Properties
    
    // Passed in by the app delegate during app initialization
    var model: Model!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 55.0
        
        // Configure and load the fetched results controller (frc)
        frc = model.frc_event
        
        // This controller will be the frc delegate
        frc.delegate = self
        
        // No predicate (which means the results will NOT be filtered)
        frc.fetchRequest.predicate = nil
        
        // Create an error object
        var error: NSError? = nil
        
        // Perform fetch, and if there's an error, log it
        if !frc.performFetch(&error) { println(error?.description) }
    }
    
    // MARK: - Table view methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.frc.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = self.frc.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        let item = frc.objectAtIndexPath(indexPath) as Event
        cell.textLabel!.text = item.title
        
        // Create new event logo
        let newSize = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        let image = UIImage(data: item.photo)
        image?.drawInRect(CGRect(origin: CGPointZero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        cell.imageView?.image = newImage
    }
    
    // Method to configure a section title
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sectionInfo = self.frc.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.name
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toEventDetail" {
            
            let vc = segue.destinationViewController as EventDetail
            
            // From the data source (the fetched results controller)...
            // Get a reference to the object for the tapped/selected table view row
            let item = frc.objectAtIndexPath(self.tableView.indexPathForSelectedRow()!) as Event
            
            vc.detailItem = item
            
            vc.title = item.title
        }
        
        if segue.identifier == "toAddEvent" {
            let nav = segue.destinationViewController as UINavigationController
            let vc = nav.topViewController as AddEvent
            vc.delegate = self
            vc.model = self.model
        }
    
    }
    
    func editItemController(controller: AnyObject, didEditItem item: AnyObject?) {
        self.model.saveChanges()
        
        // Dismiss the modal 'add item' controller
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}

