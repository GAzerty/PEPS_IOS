//
//  User.swift
//  PEPSProject
//
//  Created by user164567 on 2/25/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation

class User{
    
    var idUser: Int?
    var pseudo: String?
    var password: String?
    var role: String?
    var token: String?
    
    func getById(idUser: Int){
        if let urlAPI = URL(string: "https://web-ios-api.herokuapp.com/users/"+String(idUser)){
             print(urlAPI)
        
             URLSession.shared.dataTask(with: urlAPI) { data, response, error in
                 if let data = data {
                     
                     if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.mutableLeaves]){
                         //print(jsonObj)
                         
                         if let dictionnaryData = jsonObj as? [String:Any]{
                             print(dictionnaryData)
                             //print(dictionnaryData["data"] as! [Any])
                             
                             //On recupere "data" comme un tableau de type Any
                             if let dataT = dictionnaryData["data"] as? [Any]{
                                 for user in dataT{
                                     if let newUser = user as? [String:Any]{
                                         //print(newUser)
                                        self.idUser = (newUser["idUser"] as! Int)
                                        self.password = (newUser["password"] as! String)
                                        self.role = (newUser["role"] as! String)
                                        self.pseudo = (newUser["pseudo"] as! String)
                                     }
                                 }
                             }
                         }
                     }
                 }
             }.resume()
         }
    }
    
    init(idUser: Int){
        getById(idUser: idUser)
    }
    
    init(idUser: Int,pseudo: String, password: String, role: String){
        self.idUser = idUser
        self.pseudo = pseudo
        self.password = password
        self.role = role
    }
}
