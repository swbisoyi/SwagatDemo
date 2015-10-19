//
//  FeedbackViewController.swift
//  
//
//  Created by Swagat Kumar Bisoyi on 10/19/15.
//
//

import UIKit

class FeedbackViewController: UIViewController {

    var delegate: CenterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = containerVC.feedbackViewController.delegate
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnMenuTapped(sender: AnyObject) {
        //        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
        print(delegate)
        delegate?.toggleLeftPanel()
        
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
