//
//  TransactionViewController.swift
//  PlacesLookup
//
//  Created by Swagat Kumar Bisoyi on 10/25/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var arrayPoints = ["69","100"]
    var arrayDate = ["03 Oct 15","03 Oct 15"]
    var arrayDetails = ["Earned from ride offered to Knm Rao","Bonus points from QuickRide"]
    var arrayTime = ["04:24 PM","04:05PM"]
    var arrayID = ["92616","92605"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPoints.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : TransactionsTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TransactionsTableViewCell
        cell.lblPoints.text = arrayPoints[indexPath.row]
        cell.lblDate.text = arrayDate[indexPath.row]
        cell.lblTime.text = "at " + arrayTime[indexPath.row]
        cell.lblDetail.text = arrayDetails[indexPath.row]
        cell.lblID.text = "ID : " + arrayID[indexPath.row]
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
