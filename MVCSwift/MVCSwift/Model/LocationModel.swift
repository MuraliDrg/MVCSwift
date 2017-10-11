//
//  LocationModel.swift
//  MVCSwift
//
//  Created by Sanginadam, Muralimohan on 11/10/17.
//  Copyright © 2017 DRG. All rights reserved.
//

import Foundation

struct LocationModel {
  let longName:String?
    
//    init() {
//        
//    }
    
    init(longName: String? = nil) {
        self.longName = longName
    }
    
    func saveLocationData(data:AnyObject?) -> [LocationModel]? {
        
        guard let data = data else {
            return nil
        }
        
        let longLocationNameArray:NSMutableArray = NSMutableArray()
        
        if let jsonResult:NSDictionary = data as? NSDictionary {
            
            let resultsArray:NSArray = jsonResult.object(forKey: "results") as! NSArray
            
            for addressDict in resultsArray {
                let addressArray:NSArray = (addressDict as! NSDictionary).object(forKey: "address_components") as! NSArray
                
                for actualAddressDict in addressArray {
                    let longLocationName:String? = (actualAddressDict as! NSDictionary).object(forKey: "long_name") as? String
                    
                    let locationModel:LocationModel = LocationModel(longName: longLocationName)
                    
                    longLocationNameArray.add(locationModel)
                }
            }
        }
        
        return longLocationNameArray as? [LocationModel]
    }
    
}
