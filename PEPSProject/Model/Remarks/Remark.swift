//
//  Remark.swift
//  PEPSProject
//
//  Created by user164567 on 2/25/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation

class Remark : Identifiable{
    
    var idRemark: Int
    var remark: String
    var category: Int
    var user: User
    var answerSet: AnswerSet
    var location : String
    var date: Date
    var nbEncounter : Int
    
    init(idRemark: Int, remark: String, idCategory: Int, user: User, answerSet: AnswerSet, location: String, date: Date, nbEncounter: Int){
        self.idRemark = idRemark
        self.remark = remark
        self.category = idCategory
        self.user = user
        self.answerSet = answerSet
        self.date = date
        self.location = location
        self.nbEncounter = nbEncounter
    }
    
    //format: String
    //example: format = "fr_FR"
    func getDateFormat(format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: format)
        return dateFormatter.string(from: self.date)
    }
}
