//
//  AccountPaymentViewController.swift
//  PlacesLookup
//
//  Created by Swagat Kumar Bisoyi on 10/22/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit

class AccountPaymentViewController: UIViewController, PGTransactionDelegate , UICollectionViewDelegate , UICollectionViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var txtFieldAmount: UITextField!
    var priceArray = ["100","200","500","1000"]
    var amount = 0

    var PGTController : PGTransactionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFieldAmount.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getEpoch() -> String
    {
        let todaysDate = NSDate()
        let timestamp = (todaysDate.timeIntervalSince1970 * 1000.0)
        //        var roundedTimeStamp = Int(timestamp)
        let roundedTimeStamp = NSString(format: "%.0f", timestamp)
        
        let epoch : String = roundedTimeStamp as String
        
        return epoch
    }
    
    
    func generateOrderIDWithPrefix (prefix : String) -> String
    {
        
        //        srandom(UInt32(time(nil)))
//        let randomNo = Int(rand()) //just randomizing the number
        let orderID : String = String(format: "%@%@", arguments: [prefix, self.getEpoch()])
        //        var orderID : NSString = [NSString stringWithFormat:"%@%d", prefix, randomNo]
        return orderID
    }

    @IBAction func transactionTapped(sender: AnyObject) {
        
        let transactionVC : TransactionViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TransactionViewController") as! TransactionViewController
        self.presentViewController(transactionVC, animated: false, completion: nil)
        
    }
    
    
    @IBAction func btnPaytmPayTapped(sender: AnyObject) {
        
        if txtFieldAmount.text != "" && Int(txtFieldAmount.text!)! > 0
        {
            let mc : PGMerchantConfiguration = PGMerchantConfiguration.defaultConfiguration()
            
            let storage : NSHTTPCookieStorage  = NSHTTPCookieStorage.sharedHTTPCookieStorage()
            print(storage)
            for cookie in storage.cookies!
            {
                storage.deleteCookie(cookie)
            }
            
            NSUserDefaults.resetStandardUserDefaults()
            NSUserDefaults.standardUserDefaults().synchronize()
            
            
            mc.checksumGenerationURL = "https://pguat.paytm.com/paytmchecksum/paytmCheckSumGenerator.jsp"
            mc.checksumValidationURL = "https://pguat.paytm.com/paytmchecksum/paytmCheckSumVerify.jsp"
            
            
            //        mc.checksumGenerationURL = "http://test.etravelsmart.com/etsAPI/paytmCheckSumGenerator.jsp";
            //        mc.checksumValidationURL = "http://test.etravelsmart.com/etsAPI/paytmCheckSumValidator.jsp";
            
            let orderDict = NSMutableDictionary()
            
            orderDict["MID"] = "WorldP64425807474247";
            orderDict["CHANNEL_ID"] = "WAP";
            orderDict["INDUSTRY_TYPE_ID"] = "Retail";
            orderDict["WEBSITE"] = "worldpressplg";
            //Order configuration in the order object
            
            orderDict["TXN_AMOUNT"] = txtFieldAmount.text
            
            orderDict["ORDER_ID"] = self.generateOrderIDWithPrefix("")
            orderDict["REQUEST_TYPE"] = "DEFAULT";
            orderDict["CUST_ID"] = "1234567890";
            
            let order : PGOrder = PGOrder(params: orderDict as [NSObject : AnyObject])
            
            PGServerEnvironment.selectServerDialog(self.view, completionHandler: { (type) -> Void in
                let txnController = PGTransactionViewController(transactionForOrder: order)
                if type != eServerTypeNone
                {
                    txnController.serverType = type
                    txnController.merchant = mc
                    txnController.delegate = self
                    self.showController(txnController)
                }
            })
        }
        else
        {
            UIAlertView(title: "Sorry", message: "Enter amount", delegate: self, cancelButtonTitle: "OK").show()
        }
        
        
    }

    
    func showController(controller : PGTransactionViewController)
    {
        PGTController = controller
        if self.navigationController != nil
        {
            self.navigationController?.pushViewController(controller, animated: true)
            
            
        }
        else
        {
            self.presentViewController(controller, animated: true, completion: { () -> Void in
                // code
            })
        }
        
    }
    
    func btnBack(sender: AnyObject)
    {
        PGTController.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    func removeController(controller : PGTransactionViewController)
    {
        if self.navigationController != nil
        {
            self.navigationController?.popViewControllerAnimated(true)
        }
        else
        {
            controller.dismissViewControllerAnimated(true, completion: { () -> Void in
                // code
            })
        }
    }
    
    // MARK:- PGTransactionViewController delegate
    
    func didSucceedTransaction(controller: PGTransactionViewController!, response: [NSObject : AnyObject]!) {
        let title : String = String(format: "Your order  was completed successfully. \n %@", arguments: [response])
        UIAlertView(title: title, message: response.description, delegate: self, cancelButtonTitle: "OK").show()
        self.removeController(controller)
    }
    
    func didFailTransaction(controller: PGTransactionViewController!, error: NSError!, response: [NSObject : AnyObject]!) {
        print(error)
        if ((response) != nil)
        {
            UIAlertView(title: error.localizedDescription, message: response.description, delegate: self, cancelButtonTitle: "OK").show()
            
        }
        else if ((error) != nil)
        {
            UIAlertView(title: "Error", message: error.localizedDescription, delegate: self, cancelButtonTitle: "OK").show()
        }
        self.removeController(controller)
    }
    func didCancelTransaction(controller: PGTransactionViewController!, error: NSError!, response: [NSObject : AnyObject]!) {
        var msg : String? = nil
        if !((error) != nil)
        {
            msg = String(format: "Successful", locale: nil)
            //            msg = [NSString stringWithFormat:@"Successful"]
        }
        else
        {
            msg = String(format: "Unsuccessful", locale: nil)
        }
        UIAlertView(title: "Transaction Cancel", message: msg, delegate: self, cancelButtonTitle: "OK").show()
        
        self.removeController(controller)
    }
    
    func didFinishCASTransaction(controller: PGTransactionViewController!, response: [NSObject : AnyObject]!) {
        NSLog("ViewController::didFinishCASTransaction:response = %@", response)
        

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 380, height: 66))
        let buttonBack : UIButton = UIButton(frame: CGRect(x: 20, y: 0, width: 30, height: 66))
        buttonBack.addTarget(self, action: "btnBack:", forControlEvents: UIControlEvents.TouchUpInside)
        navigationBar.addSubview(buttonBack)
        controller.view.addSubview(navigationBar)

        
    }

    
    // MARK:- UICollectionViewDelegate delegate
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return priceArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! PriceCollectionViewCell
        cell.lblPrice.text = "Rs " + priceArray[indexPath.row]
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.txtFieldAmount.endEditing(true)
        
        if txtFieldAmount.text == ""
        {
            txtFieldAmount.text = "0"
        }
        amount = Int(txtFieldAmount.text!)! + Int(priceArray[indexPath.row])!
        txtFieldAmount.text = "\(amount)"
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.txtFieldAmount.endEditing(true)
        return true
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
