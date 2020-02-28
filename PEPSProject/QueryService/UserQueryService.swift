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
        if let urlAPI = URL(string: "https://web-ios-api.herokuapp.com/users/"+String(idUser)){
             print(urlAPI)
            let group = DispatchGroup()
            group.enter()
             URLSession.shared.dataTask(with: urlAPI) { data, response, error in
                 if let data = data {
                     
                     if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.mutableLeaves]){
                         //print(jsonObj)
                         
                         if let dictionnaryData = jsonObj as? [String:Any]{
                             //print(dictionnaryData)
                             //print(dictionnaryData["data"] as! [Any])
                             
                             //On recupere "data" comme un tableau de type Any
                             if let dataT = dictionnaryData["data"] as? [Any]{
                                 for user in dataT{
                                     if let newUser = user as? [String:Any]{
                                         //print(newUser)
                                        newU.idUser = (newUser["idUser"] as! Int)
                                        newU.role = (newUser["role"] as! String)
                                        newU.pseudo = (newUser["pseudo"] as! String)
                                     }
                                 }
                                group.leave()
                             }
                         }
                     }
                 }
             }.resume()
            group.wait()
         }
        return newU
    }
    
    //
    // Send a request to API for create a new User in database
    //
    func createUser(pseudo: String, password: String) -> Bool{
        
        var requestDone : Bool = false
        if let urlAPI = URL(string: "https://web-ios-api.herokuapp.com/users"){
            
            let group = DispatchGroup()
            group.enter()
            var request : URLRequest = URLRequest(url: urlAPI)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            do {
                let newUser = createUserJSON(pseudo: pseudo, password: password)
                let jsonData = try JSONEncoder().encode(newUser)
                request.httpBody = jsonData
            } catch {
                print(error)
            }
             URLSession.shared.dataTask(with: request) { data, response, error in
                 if let data = data {
                     
                     if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.mutableLeaves]){
                         if let dictionnaryData = jsonObj as? [String:Any]{
                             print(dictionnaryData)
                            if let message = dictionnaryData["message"] as? String{
                                print(message)
                                if message == "Success"{
                                    requestDone = true
                                }
                            }
                            group.leave()
                         }
                     }
                }
             }.resume()
            group.wait()
         }
        return requestDone
    }

    //Log the User in the API
    //Store the token in a json file (AppDelegate)
    func login(pseudo: String, password: String) -> Bool{
        
        var requestDone : Bool = false
        var userToken : String = ""
        if let urlAPI = URL(string: "https://web-ios-api.herokuapp.com/users/login"){
            
            let group = DispatchGroup()
            group.enter()
            
            var request : URLRequest = URLRequest(url: urlAPI)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            do {
                let newUser = createUserJSON(pseudo: pseudo, password: password)
                let jsonData = try JSONEncoder().encode(newUser)
                request.httpBody = jsonData
            } catch {
                print(error)
            }
             URLSession.shared.dataTask(with: request) { data, response, error in
                 if let data = data {
                     
                     if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.mutableLeaves]){
                         if let dictionnaryData = jsonObj as? [String:Any]{
                             print(dictionnaryData)
                            if let message = dictionnaryData["message"] as? String{
                                print(message)
                                if message == "Success"{
                                    requestDone = true
                                }
                            }
                            if let dataT = dictionnaryData["data"] as? [String:Any]{
                                userToken = dataT["token"] as! String
                            }
                            group.leave()
                         }
                     }
                }
             }.resume()
            group.wait()
         }
        return requestDone
    }
    
    
}
