//
//  EncashPaymentViewController.swift
//  PlacesLookup
//
//  Created by Swagat Kumar Bisoyi on 10/22/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit

class EncashPaymentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnEncashTapped(sender: AnyObject) {
        
        
        
        
        
        
        
        let requestURL = NSURL(string:"http://192.168.1.15:8080/dishaapiserver/rest/account/balance/encash?accountid=7829564947&points=100")!
        
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "PUT"
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request)

//        let task = session.dataTaskWithURL(requestURL) { (data, response, error) -> Void in
//            let feedback = (NSString(data: data!, encoding: NSUTF8StringEncoding))
//            print(data)
//            print(feedback)
//        }
        task.resume()
    }
    @IBAction func transactionTapped(sender: AnyObject) {
        
        let transactionVC : TransactionViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TransactionViewController") as! TransactionViewController
        self.presentViewController(transactionVC, animated: false, completion: nil)
        
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
