//
//  UserQueryService.swift
//  PEPSProject
//
//  Created by user164567 on 2/27/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation
import JWTDecode

struct createUserJSON: Codable{
    var pseudo: String
    var password : String
}

struct credentialsJSON: Codable{
    var user: User?
    var token: String
}

class UserQueryService{
    
    
    var fileLocation : URL? = Bundle.main.url(forResource: "credentials", withExtension: "json")
    
    
    //
    //Make a request to API and get the User corresponding to the ID given in parameter
    //Create a User with the data received and return the User
    func getUserById(idUser: Int) -> User?{
        
        var newU : User?
        
        var responseDataOpt : [String: Any]?
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/users/"+String(idUser), httpMethod: "GET", httpBody: nil)
        
        if let responseData = responseDataOpt{
            if let dataUser = responseData["data"] as? [Any]{
                for user in dataUser{
                    if let newUser = user as? [String:Any]{
                        //print(newUser)
                        let idUser = (newUser["idUser"] as! Int)
                        let role = (newUser["role"] as! String)
                        let pseudo = (newUser["pseudo"] as! String)
                        
                        newU = User(idUser: idUser, pseudo: pseudo, role: role)
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
    
    //
    // Send a request to API for delete a User in database
    //
    func deleteUser() -> Bool{
        var requestDone : Bool = false
        
        var jsonData : Data?
        do {
            if let token = getToken(){
                let token = tokenJSON(token: token)
                jsonData = try JSONEncoder().encode(token)
            }
            
        } catch {
            print(error)
        }
        
        var responseDataOpt : [String: Any]?
        if let user = getUserLogged(){
            if let idUser = user.idUser{
                responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/users/"+String(idUser), httpMethod: "DELETE", httpBody: jsonData)
            }
        }
        
        if let responseData = responseDataOpt{
            let message = responseData["message"] as! String
            if message == "Success"{
                requestDone = true
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
                requestDone = true
            }
        }
        storeUser(token: userToken)
        return requestDone
    }
    
    
    //Clear the token stored in the JSON file
    func logout(){
        if let url = self.fileLocation{
            do{
                let resetToken = ""
                let credentialJson = credentialsJSON(user: nil, token: resetToken)
                
                let jsonEncoder = JSONEncoder()
                jsonEncoder.outputFormatting = .prettyPrinted
                let data = try jsonEncoder.encode(credentialJson)
                try data.write(to: url)
            }catch{
                print(error)
            }
        }
    }
    
    //Store the token given by the API in a JSON file
    func storeUser(token: String){
        
        if !(isLogged()){
            
            if let url = self.fileLocation{
                do{
                    let jwt = try decode(jwt: token)
                    let jwtBody = jwt.body
                    let jwtIdUser = jwtBody["idUser"] as! Int
                    guard let user : User = getUserById(idUser: jwtIdUser) else{
                        return
                    }
                    let credentialJson = credentialsJSON(user: user, token: token)
                    
                    let jsonEncoder = JSONEncoder()
                    jsonEncoder.outputFormatting = .prettyPrinted
                    let data = try jsonEncoder.encode(credentialJson)
                    try data.write(to: url)
                }catch{
                    print(error)
                }
            }
        }
        
    }
    
    //Return True if a token is stored in the JSON file
    func isLogged() -> Bool{
        return (getToken() != nil)
    }
    
    
    //Return the Token stored in JSON file
    //Return nil if no token stored
    func getToken() -> String?{
        var token : String?
        
        if let url = self.fileLocation{
            do{
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode(credentialsJSON.self, from: data)
                if(dataFromJson.token != ""){
                    token = dataFromJson.token
                }else{
                    token = nil
                }
            }catch{
                print(error)
            }
        }
        return token
    }
    
    //Return the User stored in the JSON file
    func getUserLogged() -> User?{
        var user : User?
        
        if let url = self.fileLocation{
            do{
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode(credentialsJSON.self, from: data)
                user = dataFromJson.user
            }catch{
                print(error)
            }
        }
        return user
    }
    
    
}
