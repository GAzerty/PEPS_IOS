//
//  Answer.swift
//  PEPSProject
//
//  Created by user164567 on 3/1/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation

class Answer : Identifiable, ObservableObject{
    
    var idAnswer : Int
    var answer : String
    var category : Int
    var user : User
    @Published var nbLike : Int
    
    init(idAnswer: Int, answer: String, category: Int, user: User, nbLike: Int){
        self.idAnswer=idAnswer
        self.answer=answer
        self.category=category
        self.user=user
        self.nbLike = nbLike
    }
    
    func incrementLike(){
        self.nbLike+=1
    }
    
    func decrementLike(){
        self.nbLike = self.nbLike - 1
    }

    
}
