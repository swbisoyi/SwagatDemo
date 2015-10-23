//
//  LoginViewController.swift
//  PlacesLookup
//
//  Created by Swagat Kumar Bisoyi on 10/22/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var appDelegate : AppDelegate = AppDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnLoginTapped(sender: AnyObject) {
        appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let containerViewController = ContainerViewController()

        appDelegate.window!.rootViewController = containerViewController
        appDelegate.window!.makeKeyAndVisible()
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
