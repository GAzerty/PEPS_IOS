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
    @ObservedObject var remarkSet : RemarkSet = RemarkSet()
    @State private var showDetail = false
   
    var body: some View {
        VStack{
            HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("search", text: $searchTerm, onEditingChanged: { isEditing in
                     self.showCancelButton = true
                 }, onCommit: {
                     print("onCommit")
                 }).foregroundColor(.primary)

                Button(action: {
                     self.searchTerm = ""
                 }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchTerm == "" ? 0 : 1)
                 }
              
                
             }
             .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
             .foregroundColor(.secondary)
             .background(Color(.secondarySystemBackground))
             .cornerRadius(10.0)
            OrderByView()
            }

            FiltersView(remarkSet: self.remarkSet)
        }.padding(10)
    }
}

struct ResearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ResearchBarView()
    }
}

