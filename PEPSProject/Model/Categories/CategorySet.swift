//
//  CategorySet.swift
//  PEPSProject
//
//  Created by Paola Andreu on 28/02/2020.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation

class CategorySet: ObservableObject {
    @Published var categorySet : [Category] = [Category]()
    
    
    //Constructor
    //type : all - answer - remark
    init(type: String){
        switch type {
        case "answer":
            setAllAnswersCategories()
        case "remark":
             setAllRemarksCategories()
        case "all":
            setAllCategories()
        default:
            setAllCategories()
        }
    }
    
    //Set the attribute categorySet with all the categories stored in db and given by the API
    func setAllCategories(){
        addCategories(categoryTab: CategoryQueryService().getAllCategories())
    }
    
    //Set the attribute categorySet with all the remarks categories stored in db and given by the API
    func setAllRemarksCategories(){
        addCategories(categoryTab: CategoryQueryService().getAllRemarksCategories())
    }
    
    //Set the attribute categorySet with all the answers categories stored in db and given by the API
    func setAllAnswersCategories(){
        addCategories(categoryTab: CategoryQueryService().getAllAnswersCategories())
    }
    
    //add a category to the attribute categorySet
    func addCategory(category: Category){
        self.categorySet.append(category)
    }
    
    //add an array of category to the attribute categorySet
    func addCategories(categoryTab: [Category]){
        for category in categoryTab{
            self.categorySet.append(category)
        }
    }
}
