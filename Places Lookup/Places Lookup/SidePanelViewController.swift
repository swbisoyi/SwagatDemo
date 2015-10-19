//
//  LeftViewController.swift
//  Places Lookup
//
//  Created by Swagat Kumar Bisoyi on 10/10/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit


protocol SidePanelViewControllerDelegate {
    func presentViewControl(indexPassed: NSIndexPath)
}

class SidePanelViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var delegate: SidePanelViewControllerDelegate?

  var arrayMenu = ["New Ride","My Rides","My Rewards","Share & Earn","Feedback","Logout"]
  struct TableView {
    struct CellIdentifiers {
      static let MenuCell = "Cell"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.reloadData()
  }
  
}

// MARK: Table View Data Source

extension SidePanelViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayMenu.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(TableView.CellIdentifiers.MenuCell, forIndexPath: indexPath) as! MenuTableViewCell
    cell.lblTabTitle.text = arrayMenu[indexPath.row]
    return cell
  }
  
}

// Mark: Table View Delegate

extension SidePanelViewController: UITableViewDelegate {

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    delegate?.presentViewControl(indexPath)
  }
  
}

