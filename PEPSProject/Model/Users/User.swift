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
       
    
    init(){}
    
    init(idUser: Int,pseudo: String, password: String, role: String){
        self.idUser = idUser
        self.pseudo = pseudo
        self.password = password
        self.role = role
    }
}
