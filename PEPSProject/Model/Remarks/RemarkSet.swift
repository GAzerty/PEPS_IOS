//
//  RemarkSet.swift
//  PEPSProject
//
//  Created by user164567 on 2/26/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation


class RemarkSet: ObservableObject {
    
    @Published var remarkSet : [Remark] = [Remark]()
    
    init(){
        getAllRemarks()
    }
    
    init(idUser: Int){}
    
    
    func getAllRemarks(){
        if let urlAPI = URL(string: "https://web-ios-api.herokuapp.com/remarks"){
             print(urlAPI)
        
             URLSession.shared.dataTask(with: urlAPI) { data, response, error in
                 if let data = data {
                     
                     if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.mutableLeaves]){
                         //print(jsonObj)
                         
                         if let dictionnaryData = jsonObj as? [String:Any]{
                             //print(dictionnaryData)
                             //print(dictionnaryData["data"] as! [Any])
                             
                             //On recupere "data" comme un tableau de type Any
                             if let dataT = dictionnaryData["data"] as? [Any]{
                                 for remark in dataT{
                                     if let newRemark = remark as? [String:Any]{
                                         //print(newUser)
                                        let idRemark = newRemark["idRemark"] as! Int
                                        let remark = newRemark["remark"] as! String
                                        let idCategory = newRemark["idCategory"] as! Int
                                        let idUser = newRemark["idUser"] as! Int
                                        
                                        let u = User(idUser: idUser)
                                        let r = Remark(idRemark: idRemark, remark: remark, idCategory: idCategory, user: u)
                                        print(r)
                                        self.remarkSet.append(r)
                                     }
                                 }
                             }
                         }
                     }
                 }
             }.resume()
         }
    }
    
    
}
