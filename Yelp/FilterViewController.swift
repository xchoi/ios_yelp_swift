//
//  FilterViewController.swift
//  Yelp
//
//  Created by Alex Choi on 9/23/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import Foundation
import UIKit

protocol FilterViewControllerDelegate{
    func filtersSet(controller:FilterViewController, sortBy:Int, radius:Int, deals:Bool)
}

class FilterViewController: UITableViewController {
    
    var delegate:FilterViewControllerDelegate? = nil
 
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    @IBOutlet weak var radiusSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dealsSwitch: UISwitch!
    
    
    @IBAction func doneButtonPushed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, nil)
    }
    
    override func viewDidLoad() {
//        self.sortSegmentedControl.
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        if delegate != nil {
            delegate!.filtersSet(self, sortBy: sortSegmentedControl.selectedSegmentIndex, radius: radiusSegmentedControl.selectedSegmentIndex, deals: dealsSwitch.on)
        }
        super.viewWillDisappear(animated)
    }
    
}