//
//  FiltersView.swift
//  PEPSProject
//
//  Created by Paola Andreu on 28/02/2020.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct FiltersView: View {
    @ObservedObject var categorySet : CategorySet = CategorySet()
    @State var categoriesSelected : [Int] = [Int]()
    @ObservedObject var remarkSetBase : RemarkSet
    @ObservedObject var remarkSetSelected : RemarkSet
    @State var arePressed : [Int] = [Int]()
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack{
                ForEach(self.categorySet.categorySet.indices){
                    i in
                   
                       Button(action: {
                        if(!self.arePressed.contains(i)){
                            self.arePressed.append(i)
                            self.categoriesSelected.append(self.categorySet.categorySet[i].idCategory)
                        }else{
                            print("supprimer")
                            self.arePressed.remove(at: self.arePressed.firstIndex(of: i)!)
                            self.categoriesSelected.remove(at: self.categoriesSelected.firstIndex(of: self.categorySet.categorySet[i].idCategory)!)
                            
                        }
                        print(i)
                        print(self.categoriesSelected)
                        self.remarkSetSelected.remarkSet = self.remarkSetBase.filterBy(idCategories: self.categoriesSelected)
                             }) {
                                Text("\(self.categorySet.categorySet[i].lib)").padding(5).foregroundColor(.secondary).background(self.arePressed.contains(i) ? Color.gray : Color(.secondarySystemBackground)).cornerRadius(50)
                         }
                }
            }
        }
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(remarkSetBase: RemarkSet(),remarkSetSelected: RemarkSet())
    }
}


