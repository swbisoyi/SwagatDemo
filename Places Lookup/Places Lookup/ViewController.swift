//
//  ViewController.swift
//  Places Lookup
//
//  Created by Swagat Kumar Bisoyi on 10/10/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController,UISearchBarDelegate, LocateOnTheMap {

    var searchResultController:SearchResultsController!
    var resultsArray = [String]()
    var googleMapsView:GMSMapView!
    
    var delegate: CenterViewControllerDelegate?

    @IBOutlet var mapViewContainer: UIView!
    
    @IBAction func showSearchController(sender: AnyObject) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        self.presentViewController(searchController, animated: true, completion: nil)
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.googleMapsView =  GMSMapView(frame: self.mapViewContainer.frame)
        self.view.addSubview(self.googleMapsView)
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        self.delegate = containerVC.viewController.delegate
        self.navigationController?.setNavigationBarHidden(true, animated: false)


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locateWithLongitude(lon: Double, andLatitude lat: Double, andTitle title: String) {
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera  = GMSCameraPosition.cameraWithLatitude(lat, longitude: lon, zoom: 10)
            self.googleMapsView.camera = camera
            
            marker.title = title
            marker.map = self.googleMapsView
        }
    }
    
    func searchBar(searchBar: UISearchBar,textDidChange searchText: String){
            
            let placesClient = GMSPlacesClient()
            placesClient.autocompleteQuery(searchText, bounds: nil, filter: nil) { (results, error:NSError?) -> Void in
                self.resultsArray.removeAll()
                if results == nil {
                    return
                }
                for result in results!{
                    if let result = result as? GMSAutocompletePrediction{
                        self.resultsArray.append(result.attributedFullText.string)
                    }
                }
                self.searchResultController.reloadDataWithArray(self.resultsArray)
            }
    }
    @IBAction func btnMenuTapped(sender: AnyObject) {
//        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
        print(delegate)
        delegate?.toggleLeftPanel()

    }

    
}

