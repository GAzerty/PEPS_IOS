//
//  User.swift
//  PEPSProject
//
//  Created by user164567 on 2/25/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation

class User: Codable{
    
    var idUser: Int?
    var pseudo: String?
    var role: String?
       
    
    init(){}
    
    init(idUser: Int,pseudo: String, role: String){
        self.idUser = idUser
        self.pseudo = pseudo
        self.role = role
    }
}
