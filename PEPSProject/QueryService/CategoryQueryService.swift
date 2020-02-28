//
//  CategoryQueryService.swift
//  PEPSProject
//
//  Created by Paola Andreu on 28/02/2020.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation
class CategoryQueryService {
    
    func getAllCategories(categorySet : CategorySet) -> Bool{
        
        if let urlAPI = URL(string: "https://web-ios-api.herokuapp.com/categories"){
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
                                DispatchQueue.main.async {
                                     for category in dataT{
                                         if let newCategory = category as? [String:Any]{
                                            let idCategory = newCategory["idCategory"] as! Int
                                            let lib = newCategory["lib"] as! String
                                            let type = newCategory["type"] as! String
                                           
                                            let c = Category(idCategory: idCategory, lib: lib, type: type)
                                            
                                            categorySet.addCategory(category: c)
                                            
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
    
    
    
}
