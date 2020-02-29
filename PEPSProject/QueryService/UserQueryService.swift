//
//  UserQueryService.swift
//  PEPSProject
//
//  Created by user164567 on 2/27/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation


struct createUserJSON: Codable{
    var pseudo: String
    var password : String
}

class UserQueryService{
    
    //
    //Make a request to API and get the User corresponding to the ID given in parameter
    //Create a User with the data received and return the User
    func getUserById(idUser: Int) -> User{
        
        var newU : User = User()
        
        var responseDataOpt : [String: Any]?
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/users/"+String(idUser), httpMethod: "GET", httpBody: nil)
        
        if let responseData = responseDataOpt{
            if let dataUser = responseData["data"] as? [Any]{
                for user in dataUser{
                    if let newUser = user as? [String:Any]{
                        //print(newUser)
                        newU.idUser = (newUser["idUser"] as! Int)
                        newU.role = (newUser["role"] as! String)
                        newU.pseudo = (newUser["pseudo"] as! String)
                    }
                }
            }
        }
        
        return newU
    }
    
    
    
    
    //
    // Send a request to API for create a new User in database
    //
    func createUser(pseudo: String, password: String) -> Bool{
        
        var requestDone : Bool = false
        
        var jsonData : Data?
        do {
            let newUser = createUserJSON(pseudo: pseudo, password: password)
            jsonData = try JSONEncoder().encode(newUser)
        } catch {
            print(error)
        }
        
        var responseDataOpt : [String: Any]?
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/users", httpMethod: "POST", httpBody: jsonData)
        
        if let responseData = responseDataOpt{
            if let message = responseData["message"] as? String{
                //print(message)
                
                if message == "Success"{
                    requestDone = true
                }
            }
        }
        return requestDone
    }
    
    
    
    //Log the User in the API
    //Store the token in a json file (AppDelegate)
    func login(pseudo: String, password: String) -> Bool{
        
        var requestDone : Bool = false
        var userToken : String = ""
        
        var jsonData : Data?
        do {
            let newUser = createUserJSON(pseudo: pseudo, password: password)
            jsonData = try JSONEncoder().encode(newUser)
        } catch {
            print(error)
        }
        
        var responseDataOpt : [String: Any]?
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/users/login", httpMethod: "POST", httpBody: jsonData)
        
        if let responseData = responseDataOpt{
            
            if let dataT = responseData["data"] as? [String:Any]{
                userToken = dataT["token"] as! String
                print(userToken)
                requestDone = true
            }
        }
        return requestDone
        
    }
    
    
}
