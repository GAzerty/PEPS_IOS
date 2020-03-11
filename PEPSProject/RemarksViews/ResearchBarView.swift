//
//  ResearchBarView.swift
//  PEPSProject
//
//  Created by Paola Andreu on 27/02/2020.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct ResearchBarView: View {
    @State private var searchTerm : String = ""
    @State private var showCancelButton: Bool = false
    @ObservedObject var remarkSetBase : RemarkSet
    @ObservedObject var remarkSetSelected : RemarkSet
    @State private var showDetail = false
    @Binding var personalRemark: Bool
    
    var body: some View {
        VStack{
            HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("search", text: $searchTerm, onEditingChanged: { isEditing in
                     self.showCancelButton = true
                 }, onCommit: {
                    self.remarkSetSelected.remarkSet = self.remarkSetBase.filterBy(words: self.searchTerm)
                 }).foregroundColor(.primary)

                Button(action: {
                    self.searchTerm = ""
                    self.remarkSetSelected.remarkSet = self.remarkSetBase.remarkSet
                 }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchTerm == "" ? 0 : 1)
                 }
              
                
             }
             .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
             .foregroundColor(.secondary)
             .background(Color(.secondarySystemBackground))
             .cornerRadius(10.0).shadow(color: .gray, radius: 3, x: 1, y: 1)
                OrderByView(remarkSetSelected : self.remarkSetSelected)
            }

            FiltersView(remarkSetBase : self.remarkSetBase,remarkSetSelected: self.remarkSetSelected, personalRemark: self.$personalRemark)
        }.padding(10)
    }
}

/*struct ResearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ResearchBarView(remarkSetBase: RemarkSet(),remarkSetSelected: RemarkSet(), personalRemark: false)
    }
}*/

