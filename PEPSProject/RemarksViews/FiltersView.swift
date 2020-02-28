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
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack{
                ForEach(self.categorySet.categorySet, id: \.idCategory){
                    category in Text("\(category.lib)").padding(5).foregroundColor(.secondary).background(Color(.secondarySystemBackground)).cornerRadius(50)
                }
            }
        }
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView()
    }
}
