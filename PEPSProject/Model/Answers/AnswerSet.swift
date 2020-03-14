//
//  AnswerSet.swift
//  PEPSProject
//
//  Created by user164567 on 3/1/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation

class AnswerSet: ObservableObject {
    
    @Published var answerSet : [Answer] = [Answer]()
    
    init(){}
    
    func addAnswers(answer: Answer){
        self.answerSet.append(answer)
    }
    
    func addAnswers(answerTab: [Answer]){
        for answer in answerTab{
            self.answerSet.append(answer)
        }
    }
    
    func remove(answer: Answer){
        self.answerSet.removeAll{ $0.idAnswer == answer.idAnswer}
    }
}
