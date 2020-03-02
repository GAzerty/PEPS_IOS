//
//  CategoryQueryService.swift
//  PEPSProject
//
//  Created by Paola Andreu on 28/02/2020.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation
class CategoryQueryService {
    
    func getAllCategories() -> [Category]{
        var categorySet : [Category] = [Category]()
        var responseDataOpt : [String: Any]?
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/categories", httpMethod: "GET", httpBody: nil)
       
        if let data = responseDataOpt {
            
            if let dataT = data["data"] as? [Any]{
                for category in dataT{
                    if let newCategory = category as? [String:Any]{
                        let idCategory = newCategory["idCategory"] as! Int
                        let lib = newCategory["lib"] as! String
                        let type = newCategory["type"] as! String
                                           
                        let c = Category(idCategory: idCategory, lib: lib, type: type)
                                            
                        categorySet.append(c)
                                            
                    }
                }
            }
        }
        return categorySet
    }
    
    
    func getCategoryById(idCategory: Int) -> Category?{
        
        var category : Category?
        var responseDataOpt : [String: Any]?
        
        responseDataOpt = QueryService().request(url: "https://web-ios-api.herokuapp.com/categories/"+String(idCategory), httpMethod: "GET", httpBody: nil)
        
        if let responseData = responseDataOpt{
            if let dataT = responseData["data"] as? [Any]{
                for categ in dataT{
                    if let newCategory = categ as? [String: Any]{
                       let idCategory = newCategory["idCategory"] as! Int
                       let lib = newCategory["lib"] as! String
                       let type = newCategory["type"] as! String
                      
                       category = Category(idCategory: idCategory, lib: lib, type: type)
                   }
                }
            }
        }
        
        return category
    }
    
    
}
