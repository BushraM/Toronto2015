//
//  NewsDetail.swift
//  Toronto2015
//
//  Created by Bushra Mohamed on 2015-04-04.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import UIKit

class NewsDetail: UIViewController {

    
    // MARK: - Class members
    
    var model: Model!
    var item: MWFeedItem!
    
    // MARK: - User interface
    
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDate: UILabel!
    @IBOutlet weak var itemSummary: UIWebView!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the user interface
        
        itemTitle.text = item.title
        
        // Format the date
        
        let df = NSDateFormatter();
        df.dateStyle = .LongStyle
        df.timeStyle = .MediumStyle
        itemDate.text = df.stringFromDate(item.date)
        

        let styledItemSummary = "<div style=\"font-family: sans-serif;\">\(item.summary)</div>"
        itemSummary.loadHTMLString(styledItemSummary, baseURL: nil)
    }


}
