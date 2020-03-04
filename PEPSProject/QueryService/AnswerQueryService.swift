//
//  AnswerQueryService.swift
//  PEPSProject
//
//  Created by user164567 on 3/1/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation


struct createAnswserJSON: Codable{
    var answer: String
    var idCategory : Int
    var token: String
}

class AnswerQueryService {
    
    //func getAnswerById(idAnswer: Int){}
    
    func createAnswser(answser: String, idCategory: Int) -> Int? {
        var idAnswer : Int?
        var responseDataOpt : [String: Any]?
        
        var jsonData : Data?
        do {
            if let token = UserQueryService().getToken(){
                let createAnswer = createAnswserJSON(answer: answser, idCategory: idCategory, token: token)
                jsonData = try JSONEncoder().encode(createAnswer)
            }
            
        } catch {
            print(error)
        }
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/answers", httpMethod: "POST", httpBody: jsonData)
        
        if let responseData = responseDataOpt{
            
            let message = responseData["message"] as! String
            
            if message == "Success"{
                print(message)
                if let dataT = responseData["data"] as? [String: Any]{
                    idAnswer = dataT["idAnswer"] as? Int
                }
            }
        }
        return idAnswer
    }
    
    func getNbLikeAnswer(idAnswer: Int) -> Int?{
        var nbLike : Int?
        var responseDataOpt : [String: Any]?
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/answers/"+String(idAnswer)+"/likes", httpMethod: "GET", httpBody: nil)
        
        if let responseData = responseDataOpt{
            print(responseData)
            let message = responseData["message"] as! String
            
            if message == "Success"{
                print(message)
                if let dataT = responseData["data"] as? [String: Any]{
                    let count = dataT["count"] as! String
                    nbLike = Int(count) ?? 0
                }
            }
        }
        return nbLike
    }
    
}
