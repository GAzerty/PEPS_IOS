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
    init(){
        addCategories(categoryTab: CategoryQueryService().getAllCategories())
    }
    func addCategory(category: Category){
        self.categorySet.append(category)
    }
    func addCategories(categoryTab: [Category]){
        for category in categoryTab{
            self.categorySet.append(category)
        }
    }
}
