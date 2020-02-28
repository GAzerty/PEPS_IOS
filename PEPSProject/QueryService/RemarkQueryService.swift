//
//  RemarkQueryService.swift
//  PEPSProject
//
//  Created by user164567 on 2/27/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation


class RemarkQueryService {
    
    func getAllRemarks(remarkSet : RemarkSet) -> Bool{
        
        if let urlAPI = URL(string: "https://web-ios-api.herokuapp.com/remarks/"){
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
                                DispatchQueue.main.async {
                                     for remark in dataT{
                                         if let newRemark = remark as? [String:Any]{
                                            let idRemark = newRemark["idRemark"] as! Int
                                            let remark = newRemark["remark"] as! String
                                            let idCategory = newRemark["idCategory"] as! Int
                                            let idUser = newRemark["idUser"] as! Int
                                            let date2 = newRemark["dateCreation"] as! String
                                            print(date2)
                                            //let date = Date(date2)
                                            
                                            let dateFormatter = DateFormatter()
                                            let date = dateFormatter.date(from: "2020-02-25")
                                            print(date)
                                            let location = newRemark["location"] as! String
                                            let nbEncounter = RemarkQueryService().getNbEncounter(idRemark: idRemark)
                                            
                                            let u : User = UserQueryService().getUserById(idUser: idUser)
                                            let r = Remark(idRemark: idRemark, remark: remark, idCategory: idCategory, user: u, location: location, date: date ?? Date(), nbEncounter: nbEncounter)
                                            
                                            remarkSet.addRemarks(remark: r)
                                        }
                                     }
                                }
                             }
                         }
                     }
                 }
             }.resume()
        }
        return true
    }
    
    
    func getNbEncounter(idRemark: Int) -> Int {
        
        
        var encounter : Int = 0
        if let urlAPI = URL(string: "https://web-ios-api.herokuapp.com/remarks/"+String(idRemark)+"/encounter"){
            
            let group = DispatchGroup()
            group.enter()
            
             URLSession.shared.dataTask(with: urlAPI) { data, response, error in
                 if let data = data {
                     
                     if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.mutableLeaves]){
                         if let dictionnaryData = jsonObj as? [String:Any]{
                            //print(dictionnaryData)
                            
                            if let dataT = dictionnaryData["data"] as? [String:Any]{
                                print(dataT["count"])
                                
                                let count = dataT["count"] as! String
                                encounter = Int(count) ?? 0
                            }
                            group.leave()
                         }
                     }
                }
             }.resume()
            group.wait()
         }
        return encounter
    }
    
    
}
