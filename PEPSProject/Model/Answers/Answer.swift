//
//  Answer.swift
//  PEPSProject
//
//  Created by user164567 on 3/1/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation

class Answer : Identifiable{
    
    var idAnswer : Int
    var answer : String
    var category : Category
    var user : User
    
    init(idAnswer: Int, answer: String, category: Category, user: User){
        self.idAnswer=idAnswer
        self.answer=answer
        self.category=category
        self.user=user
    }
    
}
