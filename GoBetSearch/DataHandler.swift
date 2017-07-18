//
//  DataHandler.swift
//  GoBetSearch
//
//  Created by Patrik Adolfsson on 2017-07-15.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import UIKit

// = = = = =
enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_7          = IS_IPHONE_6
    static let IS_IPHONE_7P         = IS_IPHONE_6P
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO_9_7      = IS_IPAD
    static let IS_IPAD_PRO_12_9     = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

struct Version{
    static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7 = (Version.SYS_VERSION_FLOAT < 8.0 && Version.SYS_VERSION_FLOAT >= 7.0)
    static let iOS8 = (Version.SYS_VERSION_FLOAT >= 8.0 && Version.SYS_VERSION_FLOAT < 9.0)
    static let iOS9 = (Version.SYS_VERSION_FLOAT >= 9.0 && Version.SYS_VERSION_FLOAT < 10.0)
    static let iOS10 = (Version.SYS_VERSION_FLOAT >= 10.0 && Version.SYS_VERSION_FLOAT < 11.0)
}
// = = = = =

enum Gender: Int {
    case Unknown = 0, Male = 1, Female = 2
}

struct Variables {
    static var DeviceId: String = "patrik123"
    static var Email: String = "patrik@mooi.ninja"
    static var password: String = "test"
    static var UserToken: String = "MTUwMDM3NTUwM3xDZ3dBQnpFd01EQXdNREU9fFUIRqgjJ9ZNJ-BmtGTtMjeLeCkhqXxfXuZBRbU19iBf"
    static var UserId: Int64 = 0
    static var CurrentUser : User? = nil
}



class DataHandler {
    
    var baseUrl = "http://mule.gobetsearch.com"
    var baseUrlNew = "https://api-dot-gobetsearch-play.appspot.com"
    
    
    
    //  ****************************************************************************************
    //  Mark: Helper functions
    //  ****************************************************************************************
    
    func storeLocalData(object: String, value: Any) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: object)
        defaults.synchronize()
    }
    
    func deleteLocalData(object: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: object)
        defaults.synchronize()
    }
    
    func getLocalData(object: String) -> Any? {
        let defaults = UserDefaults.standard
        if( defaults.value(forKey: object) != nil) {
            
            return defaults.value(forKey: object)
        }
        return ""
    }
    
    func clearLocalData() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
    
    func printJson(data: Any)  {
        if let string = NSString(data: data as! Data, encoding: String.Encoding.utf8.rawValue) {
            print(string)
        }
    }
    
    //  ****************************************************************************************
    //  Mark: API functions NEW
    //  ****************************************************************************************
    
    func logIn(email: String, password: String, completionHandler:@escaping (Bool, String) -> ()) {
        
        let dictionary = ["email": email,"password": password] as [String : Any]
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            
            // create post request
            let url = URL(string: "\(baseUrlNew)/users/signin")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = theJSONData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                do {
                    
                    let resultData = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                    if resultData["text"] != nil {
                        let resultText = resultData.value(forKey: "text") as! String
                        if ( resultText == "wrong password" ) {
                            completionHandler(false, "Wrong password")
                            return
                        }
                    }
                    Variables.UserToken = resultData.value(forKey: "token") as! String
                    Variables.UserId = resultData.value(forKey: "userId") as! Int64
                    
                    self.getUser(userToken: Variables.UserToken, completionHandler: { (success) in
                        completionHandler(true, "Logged in")
                    })
                }  catch let error as NSError {
                    print(error)
                    completionHandler(false, error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    public func getUser(userToken: String, completionHandler:@escaping (User) -> ()) {
        if let url = NSURL(string:"\(baseUrlNew)/users/me/poll") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
            request.addValue("GoBetSearch \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                do {
                    
                    let resultData = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    let poll = resultData["poll"] as! NSDictionary
                    let user = poll["user"] as! NSDictionary
                    
                    var email = ""
                    if ( user["email"] != nil ) {
                        email = (user["email"] as! NSArray).firstObject as! String
                    }
                    
                    let userObject = User(Id: user.value(forKey: "id") as! Int64,
                                          FirstName: user.value(forKey: "firstName") as! String,
                                          LastName: user.value(forKey: "lastName") as! String,
                                          Email: email)
                    
                    Variables.CurrentUser = userObject
                    self.storeLocalData(object: "user", value: userObject.dictionaryRepresentation)
                    
                    
                    
                    completionHandler(userObject)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    public func getUserObject(userToken: String, completionHandler:@escaping (NSDictionary) -> ()) {
        if let url = NSURL(string:"\(baseUrlNew)/users/me/poll") {
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
            request.addValue("GoBetSearch \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print("\(String(describing: error))")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        let resultData = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        
                        let poll = resultData["poll"] as! NSDictionary
                        let user = poll["user"] as! NSDictionary
                        
                        completionHandler(user)
                        
                    }  catch let error as NSError {
                        print(error.localizedDescription)
                    }
                })
            }
            task.resume()
        }
        
    }
    
    func registerUser(firstName: String?, lastName: String?, email: String?, password: String?, completionHandler:@escaping (Bool) -> ()) {
        let dictionary = ["email": email!,"password": password!, "firstName": firstName!, "lastName": lastName!] as [String : Any]
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            
            // create post request
            let url = URL(string: "\(baseUrlNew)/users")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = theJSONData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                do {
                    let resultData = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                    Variables.UserToken = resultData.value(forKey: "token") as! String
                    Variables.UserId = resultData.value(forKey: "userId") as! Int64
                    
                    self.getUser(userToken: Variables.UserToken, completionHandler: { (success) in
                        completionHandler(true)
                    })
                }  catch let error as NSError {
                    print(error)
                    completionHandler(false)
                }
            }
            task.resume()
        }
    }
    
    func updateUser(firstName: String?, lastName: String?, email: String?, password: String?, completionHandler:@escaping (Bool) -> ()) {
        
        getUserObject(userToken: Variables.UserToken) { (user) in
            
            let userDict : NSMutableDictionary = NSMutableDictionary(dictionary: user)
            
            userDict["firstName"] = firstName
            userDict["lastName"] = lastName
            userDict["email"] = [email]
            
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: userDict,
                options: []) {
                
                // create post request
                let url = URL(string: "\(self.baseUrlNew)/users/\(Variables.UserId)")!
                var request = URLRequest(url: url)
                
                request.httpMethod = "PUT"
                request.httpBody = theJSONData
                request.addValue("GoBetSearch \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let _ = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    do {
                        
                        _ = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        self.getUser(userToken: Variables.UserToken, completionHandler: { (success) in
                            completionHandler(true)
                        })
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
                task.resume()
            }
        }
    }
    
    func updateUserPassword(old: String?, new: String?, again: String?, completionHandler:@escaping (Bool, String) -> ()) {
        
        let dictionary = ["old": old!,"new": new!, "again": again!] as [String : Any]
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            
            // create post request
            let url = URL(string: "\(self.baseUrlNew)/users/\(Variables.UserId)/password")!
            var request = URLRequest(url: url)
            
            request.httpMethod = "PUT"
            request.httpBody = theJSONData
            request.addValue("GoBetSearch \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let _ = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                do {
                    
                    let resultData = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    if resultData["text"] != nil {
                        let resultText = resultData.value(forKey: "text") as! String
                        if ( resultText == "incorrect password" ) {
                            completionHandler(false, "Incorrect password")
                            return
                        }
                    }
                    
                    Variables.password = new!
                    
                    completionHandler(true, "Password updated")
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                    completionHandler(false, error.localizedDescription)
                }
            }
            task.resume()
        }
        
    }
    func forgotPassword(completionHandler:@escaping (Bool, String) -> ()) {
        
        let dictionary = ["email": Variables.Email] as [String : Any]
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            
            // create post request
            let url = URL(string: "\(baseUrlNew)/users/forgot")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("GoBetSearch \(Variables.UserToken)", forHTTPHeaderField: "Authorization")
            request.httpBody = theJSONData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                do {
                    
                    let resultData = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                    if resultData["text"] != nil {
                        let resultText = resultData.value(forKey: "text") as! String
                        if ( resultText == "user not found" ) {
                            completionHandler(false, "User not found")
                            return
                        }
                    }
                    
                    completionHandler(true, "New password sent")
                    
                }  catch let error as NSError {
                    print(error)
                    completionHandler(false, error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    //    //  ****************************************************************************************
    //    //  Mark: API functions
    //    //  ****************************************************************************************
    //
    //    func logInOLD(email: String, password: String, completionHandler:@escaping (Bool) -> ()) {
    //        let dictionary = [ "emailId": email, "password": password] as [String : Any]
    //
    //        if let theJSONData = try? JSONSerialization.data(
    //            withJSONObject: dictionary,
    //            options: []) {
    //
    //            // create post request
    //            let url = URL(string: "\(baseUrl)/login")!
    //            var request = URLRequest(url: url)
    //            request.httpMethod = "POST"
    //            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //            request.addValue("application/json", forHTTPHeaderField: "Accept")
    //            request.addValue(Variables.DeviceId, forHTTPHeaderField: "deviceId")
    //            request.httpBody = theJSONData
    //
    //
    //            let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //                guard let data = data, error == nil else {
    //                    print(error?.localizedDescription ?? "No data")
    //                    return
    //                }
    //                do {
    //
    //                    let resultData = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
    //                    let user = resultData.value(forKey: "user") as! NSDictionary
    //
    //
    //                    let userObject = User(Id: user.value(forKey: "id") as! String,
    //                                          FirstName: user.value(forKey: "firstName") as! String,
    //                                          LastName: user.value(forKey: "lastName") as! String,
    //                                          EmailId: user.value(forKey: "emailId") as! String,
    //                                          DateOfBirth: user.value(forKey: "dateOfBirth") as! String,
    //                                          DeviceId: user.value(forKey: "deviceId") as! String,
    //                                          Password: password)
    //
    //                    Variables.CurrentUser = userObject
    //                    self.storeLocalData(object: "user", value: userObject.dictionaryRepresentation)
    //
    //                    completionHandler(true)
    //
    //                }  catch let error as NSError {
    //                    print(error)
    //                    completionHandler(false)
    //                }
    //            }
    //            task.resume()
    //        }
    //    }
    //
    //    func registerUser(firstName: String?, lastName: String?, password: String?, completionHandler:@escaping (Bool) -> ()) {
    //
    //        guard let fName = firstName else { return }
    //        Variables.CurrentUser?.FirstName = fName
    //
    //        guard let lName = lastName else { return }
    //        Variables.CurrentUser?.LastName = lName
    //
    //        guard let pwd = password else { return }
    //        Variables.CurrentUser?.Password = pwd
    //
    //
    //        let dictionary = ["firstName": Variables.CurrentUser?.FirstName, "lastName": Variables.CurrentUser?.LastName, "password": Variables.CurrentUser?.Password, "emailId": Variables.CurrentUser?.EmailId, "dateOfBirth": Variables.CurrentUser?.DateOfBirth]
    //
    //        if let theJSONData = try? JSONSerialization.data(
    //            withJSONObject: dictionary as Any,
    //            options: []) {
    //
    //            // create post request
    //            let url = URL(string: "\(baseUrl)/register")!
    //            var request = URLRequest(url: url)
    //            request.httpMethod = "POST"
    //            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //            request.addValue("application/json", forHTTPHeaderField: "Accept")
    //            request.addValue(Variables.DeviceId, forHTTPHeaderField: "deviceId")
    //            request.addValue((Variables.CurrentUser?.Id)!, forHTTPHeaderField: "userId")
    //            request.httpBody = theJSONData
    //
    //
    //            let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //                guard let data = data, error == nil else {
    //                    print(error?.localizedDescription ?? "No data")
    //                    return
    //                }
    //                do {
    //
    //                    let resultData = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
    //                    let user = resultData.value(forKey: "user") as! NSDictionary
    //
    //
    //                    let userObject = User(Id: user.value(forKey: "id") as! String,
    //                                          FirstName: user.value(forKey: "firstName") as! String,
    //                                          LastName: user.value(forKey: "lastName") as! String,
    //                                          EmailId: user.value(forKey: "emailId") as! String,
    //                                          DateOfBirth: user.value(forKey: "dateOfBirth") as! String,
    //                                          DeviceId: user.value(forKey: "deviceId") as! String,
    //                                          Password: (Variables.CurrentUser?.Password)!)
    //
    //                    Variables.CurrentUser = userObject
    //                    self.storeLocalData(object: "user", value: userObject.dictionaryRepresentation)
    //
    //                    completionHandler(true)
    //
    //                }  catch let error as NSError {
    //                    print(error)
    //                    completionHandler(false)
    //                }
    //            }
    //            task.resume()
    //        }
    //    }
    //
    //    func updateUserProfile(firstName: String?, lastName: String?, password: String?, completionHandler:@escaping (Bool) -> ()) {
    //
    //        guard let fName = firstName else { return }
    //        Variables.CurrentUser?.FirstName = fName
    //
    //        guard let lName = lastName else { return }
    //        Variables.CurrentUser?.LastName = lName
    //
    //        guard let pwd = password else { return }
    //        Variables.CurrentUser?.Password = pwd
    //
    //
    //        let dictionary = ["firstName": Variables.CurrentUser?.FirstName, "lastName": Variables.CurrentUser?.LastName, "password": Variables.CurrentUser?.Password, "emailId": Variables.CurrentUser?.EmailId, "dateOfBirth": Variables.CurrentUser?.DateOfBirth]
    //
    //        if let theJSONData = try? JSONSerialization.data(
    //            withJSONObject: dictionary as Any,
    //            options: []) {
    //
    //            // create post request
    //            let url = URL(string: "\(baseUrl)/updateUserProfile")!
    //            var request = URLRequest(url: url)
    //            request.httpMethod = "POST"
    //            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //            request.addValue("application/json", forHTTPHeaderField: "Accept")
    //            request.addValue(Variables.DeviceId, forHTTPHeaderField: "deviceId")
    //            request.addValue((Variables.CurrentUser?.Id)!, forHTTPHeaderField: "userId")
    //            request.httpBody = theJSONData
    //
    //
    //            let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //                guard let data = data, error == nil else {
    //                    print(error?.localizedDescription ?? "No data")
    //                    return
    //                }
    //                do {
    //
    //                    let resultData = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
    //                    let user = resultData.value(forKey: "user") as! NSDictionary
    //
    //
    //                    let userObject = User(Id: user.value(forKey: "id") as! String,
    //                                          FirstName: user.value(forKey: "firstName") as! String,
    //                                          LastName: user.value(forKey: "lastName") as! String,
    //                                          EmailId: user.value(forKey: "emailId") as! String,
    //                                          DateOfBirth: user.value(forKey: "dateOfBirth") as! String,
    //                                          DeviceId: user.value(forKey: "deviceId") as! String,
    //                                          Password: (Variables.CurrentUser?.Password)!)
    //
    //                    Variables.CurrentUser = userObject
    //                    self.storeLocalData(object: "user", value: userObject.dictionaryRepresentation)
    //
    //                    completionHandler(true)
    //
    //                }  catch let error as NSError {
    //                    print(error)
    //                    completionHandler(false)
    //                }
    //            }
    //            task.resume()
    //        }
    //    }
    //
    //    func getListofOperator(completionHandler:@escaping ([Operator]) -> ()) {
    //        if let url = NSURL(string:"\(baseUrl)/getListofOperator") {
    //            let request = NSMutableURLRequest(url: url as URL)
    //            request.httpMethod = "GET"
    //            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //            request.addValue("application/json", forHTTPHeaderField: "Accept")
    //            request.addValue(Variables.DeviceId, forHTTPHeaderField: "deviceId")
    //            request.addValue((Variables.CurrentUser?.Id)!, forHTTPHeaderField: "userId")
    //
    //            let task = URLSession.shared.dataTask(with: request as URLRequest) {
    //                data, response, error in
    //                if error != nil {
    //                    print("\(String(describing: error))")
    //                    return
    //                }
    //                do {
    //                    let resultData = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
    //                    let operators = resultData.value(forKey: "operatorIds") as! NSArray
    //
    //                    var _operators = [Operator]()
    //
    //                    for op in operators {
    //                        let ope = op as! NSDictionary
    //                        let _operator = Operator(Id: (ope.value(forKey: "_id") as! NSDictionary).value(forKey: "$oid") as! String,
    //                                                 OperatorId: ope.value(forKey: "operatorId") as! Int,
    //                                                 Name: ope.value(forKey: "operatorName") as! String,
    //                                                 Rank: ope.value(forKey: "rank") as! Int,
    //                                                 Url: ope.value(forKey: "url") as! String)
    //                        _operators.append(_operator)
    //                    }
    //
    //                    completionHandler(_operators)
    //
    //                }  catch let error as NSError {
    //                    print(error.localizedDescription)
    //                    completionHandler([])
    //                }
    //            }
    //            task.resume()
    //        }
    //
    //    }
    //
    //    func getListofSport(completionHandler:@escaping ([Sport]) -> ()) {
    //        if let url = NSURL(string:"\(baseUrl)/getListofSport") {
    //            let request = NSMutableURLRequest(url: url as URL)
    //            request.httpMethod = "GET"
    //            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //            request.addValue("application/json", forHTTPHeaderField: "Accept")
    //            request.addValue(Variables.DeviceId, forHTTPHeaderField: "deviceId")
    //            request.addValue((Variables.CurrentUser?.Id)!, forHTTPHeaderField: "userId")
    //
    //            let task = URLSession.shared.dataTask(with: request as URLRequest) {
    //                data, response, error in
    //                if error != nil {
    //                    print("\(String(describing: error))")
    //                    return
    //                }
    //                do {
    //                    let resultData = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
    //                    let sports = resultData.value(forKey: "sports") as! NSArray
    //
    //                    var _sports = [Sport]()
    //
    //                    for op in sports {
    //                        let ope = op as! NSDictionary
    //                        let _sport = Sport(Id: (ope.value(forKey: "_id") as! NSDictionary).value(forKey: "$oid") as! String,
    //                                           SportId: ope.value(forKey: "sportId") as! Int64,
    //                                           SportName: ope.value(forKey: "sportName") as! String)
    //                        _sports.append(_sport)
    //                    }
    //
    //                    completionHandler(_sports)
    //
    //                }  catch let error as NSError {
    //                    print(error.localizedDescription)
    //                    completionHandler([])
    //                }
    //            }
    //            task.resume()
    //        }
    //
    //    }
    
    
}
