//
//  CreateRemarkView.swift
//  PEPSProject
//
//  Created by user164567 on 3/2/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct CreateRemarkView: View {
    
    @Binding var isPresented : Bool
    @State private var showingAlert = false
    @State var remark: String = ""
    @State var selectedidCategory: Int = 0
    @State var location: String = ""
    var categorySet : CategorySet = CategorySet()
    
    
    var body: some View {
        
        VStack{
            Text("Create a new Remark")
            TextField("Post you remark...", text: $remark).padding().background(Color.gray).cornerRadius(20.0)
            Picker(selection: $selectedidCategory, label: Text("Category")){
                ForEach(0 ..< categorySet.categorySet.count) {
                    Text("\(self.categorySet.categorySet[$0].lib)")
                    
                }
            }
            TextField("Location...", text: $location).padding().background(Color.gray).cornerRadius(20.0)
            
            Button(action:{
                if self.remark != "" && self.location != ""{
                    if RemarkQueryService().createRemark(remark: self.remark, idCategory: self.selectedidCategory+1, location: self.location){
                        self.isPresented.toggle()
                    }
                }else{
                    self.showingAlert = true
                }
            })
            {
                Text("Send")
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("Empty Field"), message: Text("Please fill the fields"), dismissButton: .default(Text("Got it !")))
            }
        }
        
    }
}

/*struct CreateRemarkView_Previews: PreviewProvider {
 static var previews: some View {
 CreateRemarkView()
 }
 }*/
