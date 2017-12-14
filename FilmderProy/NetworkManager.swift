//
//  NetworkManager.swift
//  FilmderProy
//
//  Created by Italo Contreraz on 11/19/17.
//  Copyright © 2017 Italo Contreras. All rights reserved.
//

import Foundation
import Alamofire
import SystemConfiguration
import ReachabilitySwift

typealias CompletionBlock = (Bool, Dictionary<String,AnyObject>) -> Void

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    class func isConnectedToNetwork() -> Bool {
        let reachability: Reachability = Reachability.init()!
        
        if(reachability.currentReachabilityStatus == .notReachable){
            return false
        }else{
            return true
        }
    }
    
    func callUrlWithCompletion(url : String!, params : [String: AnyObject]?, completion : @escaping CompletionBlock, method: HTTPMethod) {
        
        let urlString = url
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "TokenHeader" : ""
        ]
        
        Alamofire.request(urlString!, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if(response.response?.statusCode == 200){
                completion(true, response.result.value as! Dictionary)
            }else{
                completion(false, Dictionary<String,AnyObject>())
            }
        }
    }
}
