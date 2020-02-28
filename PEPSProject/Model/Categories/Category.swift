//
//  Categories.swift
//  PEPSProject
//
//  Created by Paola Andreu on 28/02/2020.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation

class Category : Identifiable{
    var idCategory: Int
    var lib: String
    var type: String
     
      
    init(idCategory: Int, lib: String, type: String){
          self.idCategory = idCategory
          self.lib = lib
          self.type = type
      }
}
