//
//  RemarkQueryService.swift
//  PEPSProject
//
//  Created by user164567 on 2/27/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation


struct createRemarkJSON: Codable{
    var remark: String
    var idCategory: Int
    var token: String
    var location: String
}

struct tokenJSON: Codable{
    var token: String
}

struct linkAnswerRemarkJSON: Codable{
    var idAnswer : Int
    var idRemark : Int
}

class RemarkQueryService {
    
    func getAllRemarks() -> [Remark]{
        
        var remarkSet : [Remark] = [Remark]()
        var responseDataOpt : [String: Any]?
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/remarks/", httpMethod: "GET", httpBody: nil)
        
        if let responseData = responseDataOpt{
            
            if let dataT = responseData["data"] as? [Any]{
                for remark in dataT{
                    if let newRemark = remark as? [String:Any]{
                        let idRemark = newRemark["idRemark"] as! Int
                        let remark = newRemark["remark"] as! String
                        let idCategory = newRemark["idCategory"] as! Int
                        let idUser = newRemark["idUser"] as! Int
                        
                        let dateCreation = newRemark["dateCreation"] as! String
                        let array = dateCreation.components(separatedBy: "T")
                        let formater = ISO8601DateFormatter()
                        let dateFormat = array[0]+"T00:00:00Z"
                        let date = formater.date(from: dateFormat)
                        
                        let location = newRemark["location"] as! String
                        let nbEncounter = RemarkQueryService().getNbEncounter(idRemark: idRemark)
                        let answerSet = AnswerSet()
                        answerSet.addAnswers(answerTab: RemarkQueryService().getAllRemarksAnswer(idRemark: idRemark))
                        
                        if let u : User = UserQueryService().getUserById(idUser: idUser){
                            if let date = date {
                                
                                let r = Remark(idRemark: idRemark, remark: remark, idCategory: idCategory, user: u, answerSet: answerSet, location: location, date: date, nbEncounter: nbEncounter)
                                
                                remarkSet.append(r)
                            }
                            
                        }
                        
                    }
                }
            }
        }
        return remarkSet
    }
    
    func getAllRemarksByUser(idUserChoosen: Int) -> [Remark]{
        var remarkSet : [Remark] = [Remark]()
        var responseDataOpt : [String: Any]?
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/remarks/users/"+String(idUserChoosen), httpMethod: "GET", httpBody: nil)
        
        if let responseData = responseDataOpt{
            
            if let dataT = responseData["data"] as? [Any]{
                for remark in dataT{
                    if let newRemark = remark as? [String:Any]{
                        let idRemark = newRemark["idRemark"] as! Int
                        let remark = newRemark["remark"] as! String
                        let idCategory = newRemark["idCategory"] as! Int
                        let idUser = newRemark["idUser"] as! Int
                        
                        let dateCreation = newRemark["dateCreation"] as! String
                        let array = dateCreation.components(separatedBy: "T")
                        let formater = ISO8601DateFormatter()
                        let dateFormat = array[0]+"T00:00:00Z"
                        let date = formater.date(from: dateFormat)
                        
                        let location = newRemark["location"] as! String
                        let nbEncounter = RemarkQueryService().getNbEncounter(idRemark: idRemark)
                        let answerSet = AnswerSet()
                        answerSet.addAnswers(answerTab: RemarkQueryService().getAllRemarksAnswer(idRemark: idRemark))
                        
                        if let u : User = UserQueryService().getUserById(idUser: idUser){
                            if let date = date {
                                let r = Remark(idRemark: idRemark, remark: remark, idCategory: idCategory, user: u, answerSet: answerSet, location: location, date: date, nbEncounter: nbEncounter)
                                
                                remarkSet.append(r)
                            }
                            
                        }
                        
                    }
                }
            }
        }
        return remarkSet
    }
    
    
    
    func getAllRemarksAnswer(idRemark: Int) -> [Answer]{
        
        var answerSet : [Answer] = [Answer]()
        var responseDataOpt : [String: Any]?
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/remarks/"+String(idRemark)+"/answers", httpMethod: "GET", httpBody: nil)
        
        if let responseData = responseDataOpt{
            if let dataT = responseData["data"] as? [Any]{
                for answer in dataT{
                    if let newAnswer = answer as? [String: Any]{
                        let idAnswer = newAnswer["idAnswer"] as! Int
                        let answer = newAnswer["answer"] as! String
                        let idCategory = newAnswer["idCategory"] as! Int
                        let idUser = newAnswer["idUser"] as! Int
                        
                        
                        
                            if let user = UserQueryService().getUserById(idUser: idUser){
                                if let nbLike = AnswerQueryService().getNbLikeAnswer(idAnswer: idAnswer){
                                    let answ = Answer(idAnswer: idAnswer, answer: answer, category: idCategory, user: user, nbLike: nbLike)
                                    answerSet.append(answ)
                                }
                                
                            }
                        
                    }
                }
            }
        }
        
        return answerSet
    }
    
    
    func getNbEncounter(idRemark: Int) -> Int {
        
        
        var encounter : Int = 0
        
        var responseDataOpt : [String: Any]?
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/remarks/"+String(idRemark)+"/encounter", httpMethod: "GET", httpBody: nil)
        
        if let responseData = responseDataOpt{
            //print(responseData)
            if let dataT = responseData["data"] as? [String: Any]{
                let count = dataT["count"] as! String
                encounter = Int(count) ?? 0
            }
        }
        return encounter
    }
    
    
    //Pre: The user is logged
    func createRemark(remark: String, idCategory: Int, location: String)  -> Int? {
        var idRemark : Int?
        var responseDataOpt : [String: Any]?
        
        var jsonData : Data?
        do {
            if let token = UserQueryService().getToken(){
                let newRemark = createRemarkJSON(remark: remark, idCategory: idCategory, token: token, location: location)
                jsonData = try JSONEncoder().encode(newRemark)
            }
            
        } catch {
            print(error)
        }
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/remarks", httpMethod: "POST", httpBody: jsonData)
        
        if let responseData = responseDataOpt{
            //print(responseData)
            let message = responseData["message"] as! String
            if message == "Success"{
                print(message)
                if let dataT = responseData["data"] as? [String: Any]{
                    idRemark = dataT["idRemark"] as? Int
                }
            }
        }
        
        return idRemark
        
    }
    
    func addEncounter(remark: Remark) -> Bool{
        var requestDone : Bool = false
        var responseDataOpt : [String: Any]?
        
        var jsonData : Data?
        do {
            if let token = UserQueryService().getToken(){
                let addEncounter = tokenJSON(token: token)
                jsonData = try JSONEncoder().encode(addEncounter)
            }
            
        } catch {
            print(error)
        }
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/remarks/"+String(remark.idRemark)+"/encounter", httpMethod: "POST", httpBody: jsonData)
        
        if let responseData = responseDataOpt{
            let message = responseData["message"] as! String
            if message == "Success"{
                requestDone = true
                remark.incrementEncounter()
            }
        }
        
        return requestDone
    }
    
    func removeEncounter(remark: Remark) -> Bool{
        var requestDone : Bool = false
        var responseDataOpt : [String: Any]?
        
        var jsonData : Data?
        do {
            if let token = UserQueryService().getToken(){
                let addEncounter = tokenJSON(token: token)
                jsonData = try JSONEncoder().encode(addEncounter)
            }
            
        } catch {
            print(error)
        }
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/remarks/"+String(remark.idRemark)+"/encounter", httpMethod: "DELETE", httpBody: jsonData)
        
        if let responseData = responseDataOpt{
            let message = responseData["message"] as! String
            if message == "Success"{
                requestDone = true
                remark.decrementEncounter()
            }
        }
        
        return requestDone
    }
    
    
    
    func linkAnswserToRemark(idRemark: Int, idAnswer: Int) -> Bool{
        var requestDone : Bool = false
        var responseDataOpt : [String: Any]?
        
        var jsonData : Data?
        do {
            if let token = UserQueryService().getToken(){
                let linkAnswerRemark = tokenJSON(token: token)
                jsonData = try JSONEncoder().encode(linkAnswerRemark)
            }
            
        } catch {
            print(error)
        }
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/remarks/"+String(idRemark)+"/answers/"+String(idAnswer), httpMethod: "POST", httpBody: jsonData)
        
        if let responseData = responseDataOpt{
            let message = responseData["message"] as! String
            if message == "Success"{
                requestDone = true
            }
        }
        
        return requestDone
    }
    
    func updateRemark(remark: Remark, remarkContent: String, idCategory: Int, location: String) -> Bool{
        var requestDone : Bool = false
        var responseDataOpt : [String: Any]?
        
        var jsonData : Data?
        do {
            if let token = UserQueryService().getToken(){
                let updateRemark = createRemarkJSON(remark: remarkContent, idCategory: idCategory, token: token, location: location)
                jsonData = try JSONEncoder().encode(updateRemark)
            }
        } catch {
            print(error)
        }
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/remarks/"+String(remark.idRemark), httpMethod: "PUT", httpBody: jsonData)
        
        if let responseData = responseDataOpt{
            let message = responseData["message"] as! String
            if message == "Success"{
                requestDone = true
                remark.remark = remarkContent
                remark.category = idCategory
                remark.location = location
            }
        }
        
        return requestDone
    }
    
    
    func deleteRemark(idRemark: Int) -> Bool{
        var requestDone : Bool = false
        var responseDataOpt : [String: Any]?
        
        var jsonData : Data?
        do {
            if let token = UserQueryService().getToken(){
                let deleteRemark = tokenJSON(token: token)
                jsonData = try JSONEncoder().encode(deleteRemark)
            }
        } catch {
            print(error)
        }
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/remarks/"+String(idRemark), httpMethod: "DELETE", httpBody: jsonData)
        
        if let responseData = responseDataOpt{
            let message = responseData["message"] as! String
            if message == "Success"{
                requestDone = true
            }
        }
        
        return requestDone
    }
    
}
