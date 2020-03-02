//
//  CreateRemarkView.swift
//  PEPSProject
//
//  Created by user164567 on 3/2/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct CreateRemarkView: View {
    
    @State var remark: String = ""
    @State var selectedidCategory: Int = 0
    @State var location: String = ""
    var categorySet : CategorySet = CategorySet()
    
    
    var body: some View {
        
        VStack{
            Text("Create a new Remark")
            TextField("...", text: $remark).padding().background(Color.gray).cornerRadius(20.0)
            /*Picker(selection: $selectedidCategory, label: "Category"){
                Text("hehe")
            }*/
            TextField("Location...", text: $location).padding().background(Color.gray).cornerRadius(20.0)
        }
        
    }
}

struct CreateRemarkView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRemarkView()
    }
}
