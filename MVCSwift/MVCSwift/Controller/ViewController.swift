//
//  ViewController.swift
//  MVCSwift
//
//  Created by Sanginadam, Muralimohan on 11/10/17.
//  Copyright © 2017 DRG. All rights reserved.
//

import UIKit

let testEndPoint = "https://maps.googleapis.com/maps/api/geocode/json?latlng=44.4647452,7.3553838&sensor=true"

class ViewController: UIViewController,NetWorkingMethods {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func startContentDownloadButtonPress(_ sender: Any) {
        self.performRequestWithPath(path: testEndPoint, httpMethod: .GET, needsAuth: true, params: nil) { (responseModel) in
            
            print(responseModel.data ?? "no data")
            
            let locationModel:LocationModel = LocationModel()
            
            if let locationModelArray:[LocationModel] = locationModel.saveLocationData(data:responseModel.data) {
                DispatchQueue.main.async(execute: {
                    let popUp:MVCPopUp = Bundle.main.loadNibNamed("MVCPopUp", owner: self, options: nil)?.first as! MVCPopUp
                    popUp.popUpArray = locationModelArray;
                    popUp.frame = CGRect(x:0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    
                    popUp.layoutIfNeeded()
                    self.view.addSubview(popUp)
                    popUp.alpha = 0.0
                    UIView.animate(withDuration: 1.0, animations: {
                        popUp.alpha = 1.0
                    })
                })
                
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

