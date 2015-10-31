//
//  RestApiManager.swift
//  devdactic-rest
//
//  Created by Simon Reimler on 16/03/15.
//  Copyright (c) 2015 Devdactic. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()

//    let baseURL = "http://api.randomuser.me/"
//    let baseURL = "https://zoomcar.0x10.info/api/zoomcar?type=json&query=list_cars"
    
    let baseURL = "http://192.168.1.15:8080/dishaapiserver/rest/account/transactions?accountid=7829564947"
//    let baseURL = "https://devapi.olacabs.com/v1/products?pickup_lat=12.9491416&pickup_lng=77.64298"
//    let baseURL = "http://api.geonames.org/citiesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&lang=de&username=demo"
    func getRandomUser(onCompletion: (JSON) -> Void) {
        let route = baseURL
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }

    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)

        let session = NSURLSession.sharedSession()

        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            print(json)
            onCompletion(json, error)
        })
        task.resume()
    }

    //MARK: Perform a POST Request
//    func makeHTTPPostRequest(path: String, body: [String: AnyObject], onCompletion: ServiceResponse) {
//        var err: NSError?
//        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
//
//        // Set the method to POST
//        request.HTTPMethod = "POST"
//
//        // Set the POST body for the request
//        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body, options: nil, error: &err)
//        let session = NSURLSession.sharedSession()
//
//        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            let json:JSON = JSON(data: data)
//            onCompletion(json, err)
//        })
//        task.resume()
//    }

}