//
//  MoneyCheckViewController.swift
//  FinalProject
//
//  Created by User12 on 2019/1/9.
//  Copyright © 2019 com.alverson_22. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON



class MoneyCheckViewController: UITableViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var americamoney: UILabel!
    
    @IBOutlet weak var taiwanMoney: UILabel!
    @IBAction func startCount(_ sender: Any) {
   
    let headers = [
        "accept": "application/json, text/plain, */*",
        "accept-encoding": "gzip, deflate, br",
        "accept-language": "zh-TW,zh;q=0.8,en-US;q=0.6,en;q=0.4",
        "authorization": "Basic c3VwZXJyaWNoVGg6aFRoY2lycmVwdXM=",
        "connection": "keep-alive",
        "content-type": "application/json",
        "host": "www.superrichthailand.com",
        "referer": "https://www.superrichthailand.com/",
        "x-access-token": "null",
        ]
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://www.superrichthailand.com/web/api/v1/rates")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (dataa, response, error) -> Void in
        if (error != nil) {
            
            print("error")
            
        } else {
           
            
            do {
                let json =  try JSON(data: dataa!)
                let buyingUSDHead = json["data"]["exchangeRate"][0]["rate"][0]["cBuying"].floatValue
                let buyingTWDHead = json["data"]["exchangeRate"][13]["rate"][0]["cBuying"].floatValue
                self.americamoney.text = String(buyingUSDHead)
                self.taiwanMoney.text = String(buyingTWDHead)
            }
            catch{
                NSLog("got an error creating the request: \(error)")
            }
        
    
        }
    })
    
    dataTask.resume()
    
}
    
}
