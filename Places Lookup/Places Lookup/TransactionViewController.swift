//
//  TransactionViewController.swift
//  PlacesLookup
//
//  Created by Swagat Kumar Bisoyi on 10/25/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var arrayPoints = [String]()
    var arrayDate = [String]()
    var arrayDetails = [String]()
    var arrayTime = [String]()
    var arrayID = [String]()
    var arraytransactiontype = [String]()
    var arraySourceType = [String]()
    var arraysourceRefId = [String]()
    
    @IBOutlet weak var tblTransaction: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addDummyData()
        // Do any additional setup after loading the view.
    }
    
    
    func addDummyData() {
        
        RestApiManager.sharedInstance.getRandomUser { (json: JSON) in
            
            print(json.count)
            
            for i in 0...json.count-1
            {
                var individualEntity = json[i]
                let value = individualEntity["value"]
                self.arrayPoints.append("\(value)")
                let id = individualEntity["id"]
                self.arrayID.append("\(id)")
                let transactiontype = individualEntity["transactiontype"]
                self.arraytransactiontype.append("\(transactiontype)")
                let description = individualEntity["description"]
                self.arrayDetails.append("\(description)")
                
                
                let sourceType = individualEntity["sourceType"]
                self.arraySourceType.append("\(sourceType)")
                let sourceRefId = individualEntity["sourceRefId"]
                self.arraysourceRefId.append("\(sourceRefId)")
                
                let date = individualEntity["date"]
                let dateExpected = NSDate(jsonDate: "/Date(\(date))/")
                print(dateExpected)
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
                let strDate = dateFormatter.stringFromDate(dateExpected!)
                self.arrayDate.append(strDate)
                dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
                dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
                let strTime = dateFormatter.stringFromDate(dateExpected!)
                
                self.arrayTime.append(strTime)
                
                print(strTime)
                print(strDate)
                self.tblTransaction.reloadData()

            }
            self.tblTransaction.reloadData()
        }
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
        
        if arraytransactiontype[indexPath.row] == "Debit"
        {
            cell.lblPoints.textColor = UIColor.redColor()
            cell.lblCr.text = "DR"
            cell.lblPontsField.textColor = UIColor.redColor()
            cell.lblCr.textColor = UIColor.redColor()
        }
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


extension NSDate {
    convenience init?(jsonDate: String) {
        let prefix = "/Date("
        let suffix = ")/"
        let scanner = NSScanner(string: jsonDate)
        
        // Check prefix:
        if scanner.scanString(prefix, intoString: nil) {
            
            // Read milliseconds part:
            var milliseconds : Int64 = 0
            if scanner.scanLongLong(&milliseconds) {
                // Milliseconds to seconds:
                var timeStamp = NSTimeInterval(milliseconds)/1000.0
                
                // Read optional timezone part:
                var timeZoneOffset : Int = 0
                if scanner.scanInteger(&timeZoneOffset) {
                    let hours = timeZoneOffset / 100
                    let minutes = timeZoneOffset % 100
                    // Adjust timestamp according to timezone:
                    timeStamp += NSTimeInterval(3600 * hours + 60 * minutes)
                }
                
                // Check suffix:
                if scanner.scanString(suffix, intoString: nil) {
                    // Success! Create NSDate and return.
                    self.init(timeIntervalSince1970: timeStamp)
                    return
                }
            }
        }
        
        // Wrong format, return nil. (The compiler requires us to
        // do an initialization first.)
        self.init(timeIntervalSince1970: 0)
        return nil
    }
}

