//
//  FeedbackViewController.swift
//  PlacesLookup
//
//  Created by Swagat Kumar Bisoyi on 10/22/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    var delegate: CenterViewControllerDelegate?

    @IBOutlet var btnStars: [UIButton]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = containerVC.feedbackViewController.delegate
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        for i in 0...btnStars.count-1
        {
            btnStars[i].setBackgroundImage(UIImage(named: "starblank"), forState: UIControlState.Normal)
        }

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

    @IBAction func btnRateTapped(sender: AnyObject) {
        for i in 0...btnStars.count-1
        {
            if sender.tag < i
            {
                btnStars[i].setBackgroundImage(UIImage(named: "starblank"), forState: UIControlState.Normal)
            }
            else
            {
                btnStars[i].setBackgroundImage(UIImage(named: "starfilled"), forState: UIControlState.Normal)
            }
        }

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
