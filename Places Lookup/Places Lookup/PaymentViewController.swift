//
//  PaymentViewController.swift
//  PlacesLookup
//
//  Created by Swagat Kumar Bisoyi on 10/22/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var encashView: UIView!
    
    var swipeRecognizerLeft: UISwipeGestureRecognizer!
    var swipeRecognizerRight: UISwipeGestureRecognizer!
    var delegate: CenterViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.delegate = containerVC.feedbackViewController.delegate

        encashView.hidden = true
        swipeRecognizerLeft = UISwipeGestureRecognizer(target: self,action: "handleSwipes:")
        swipeRecognizerRight = UISwipeGestureRecognizer(target: self,action: "handleSwipes:")

        /* Swipes that are performed from right to
        left are to be detected */
        swipeRecognizerLeft.direction = .Left
        swipeRecognizerRight.direction = .Right
        
        /* Just one finger needed */
        swipeRecognizerLeft.numberOfTouchesRequired = 1
        swipeRecognizerRight.numberOfTouchesRequired = 1
        
        /* Add it to the view */
        view.addGestureRecognizer(swipeRecognizerLeft)
        view.addGestureRecognizer(swipeRecognizerRight)

        // Do any additional setup after loading the view.
    }

    @IBAction func segmentControlSelected(sender: AnyObject) {
        if segmentControl.selectedSegmentIndex == 0
        {
            accountView.hidden = false
            encashView.hidden = true
        }
        else
        {
            accountView.hidden = true
            encashView.hidden = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleSwipes(sender: UISwipeGestureRecognizer){
        
        if sender.direction == .Left{
            print("Swiped Left")

            segmentControl.selectedSegmentIndex = 1
            accountView.hidden = true
            encashView.hidden = false
            
        }
        if sender.direction == .Right{
            print("Swiped Right")
            segmentControl.selectedSegmentIndex = 0
            accountView.hidden = false
            encashView.hidden = true

        }
        
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
