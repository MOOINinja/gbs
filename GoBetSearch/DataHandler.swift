//
//  DataHandler.swift
//  GoBetSearch
//
//  Created by Patrik Adolfsson on 2017-07-15.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import Foundation



struct Variables {
    static var DeviceId: String = "patrik123"
    static var EmailId: String = "patrik@splitstockholm.se"
    static var password: String = "Kirtap123!"
    static var CurrentUser : User? = nil
}

struct User {
    var Id: String
    var FirstName: String
    var LastName: String
    var EmailId: String
    var DateOfBirth: String
    var DeviceId: String
}

struct Operator {
    var Id: String
    var OperatorId: Int
    var Name: String
    var Rank: Int
    var Url: String
}

class DataHandler {
    
    var baseUrl = "http://mule.gobetsearch.com"
    
    func logIn(email: String, password: String, completionHandler:@escaping (Bool) -> ()) {
        let dictionary = [ "emailId": email, "password": password] as [String : Any]
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            
            // create post request
            let url = URL(string: "\(baseUrl)/login")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(Variables.DeviceId, forHTTPHeaderField: "deviceId")
            request.httpBody = theJSONData
            
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                do {
                    
                    let resultData = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                    let user = resultData.value(forKey: "user") as! NSDictionary
                    
                    
                    Variables.CurrentUser = User(Id: user.value(forKey: "id") as! String,
                                                 FirstName: user.value(forKey: "firstName") as! String,
                                                 LastName: user.value(forKey: "lastName") as! String,
                                                 EmailId: user.value(forKey: "emailId") as! String,
                                                 DateOfBirth: user.value(forKey: "dateOfBirth") as! String,
                                                 DeviceId: user.value(forKey: "deviceId") as! String)
                    
                    completionHandler(true)
                    
                }  catch let error as NSError {
                    print(error)
                    completionHandler(false)
                }
            }
            task.resume()
        }
    }
    
    func getListofOperator(completionHandler:@escaping ([Operator]) -> ()) {
        if let url = NSURL(string:"\(baseUrl)/getListofOperator") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(Variables.DeviceId, forHTTPHeaderField: "deviceId")
            request.addValue((Variables.CurrentUser?.Id)!, forHTTPHeaderField: "userId")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                        do {
                            let resultData = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                            let operators = resultData.value(forKey: "operatorIds") as! NSArray
                            
                            var _operators = [Operator]()
                            
                            for op in operators {
                                let ope = op as! NSDictionary
                                let _operator = Operator(Id: (ope.value(forKey: "_id") as! NSDictionary).value(forKey: "$oid") as! String,
                                    OperatorId: ope.value(forKey: "operatorId") as! Int,
                                                             Name: ope.value(forKey: "operatorName") as! String,
                                                             Rank: ope.value(forKey: "rank") as! Int,
                                                             Url: ope.value(forKey: "url") as! String)
                                _operators.append(_operator)
                            }
                        
                        completionHandler(_operators)
                        
                    }  catch let error as NSError {
                        print(error.localizedDescription)
                        completionHandler([])
                    }
            }
            task.resume()
        }

    }
    
}
