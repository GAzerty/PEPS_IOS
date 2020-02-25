//
//  Remark.swift
//  PEPSProject
//
//  Created by user164567 on 2/25/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation

class Remark{
    
    var idRemark: Int
    var remark: String
    var category: Int
    var user: User
    var date: Date
    
    init(idRemark: Int, remark: String, idCategory: Int, user: User, date: Date){
        self.idRemark = idRemark
        self.remark = remark
        self.category = idCategory
        self.user = user
        self.date = date
    }
}
