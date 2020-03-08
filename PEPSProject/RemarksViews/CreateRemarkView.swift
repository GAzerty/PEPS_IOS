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
    var categorySet : CategorySet = CategorySet(type: "remark")
    var isUpdateView : Bool = false
    var remarkUpdated : Remark?
    
    var body: some View {
        VStack{
            if(!isUpdateView){
                Text("Create a new Remark").font(.title).foregroundColor(.purple)
                .cornerRadius(10.0).padding()
            }else{
                Text("Update your Remark").font(.title).foregroundColor(.purple)
                .cornerRadius(10.0).padding()
            }
            
            TextField("Post your remark...", text: $remark).padding().background(Color(.secondarySystemBackground)).cornerRadius(10)
            
            Picker(selection: $selectedidCategory, label: Text("Category")){
                ForEach(0 ..< categorySet.categorySet.count) {
                    Text("\(self.categorySet.categorySet[$0].lib)").padding().foregroundColor(.secondary)  .background(Color(.secondarySystemBackground)).cornerRadius(10)
                }
            }.padding().foregroundColor(.secondary)  .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            
            TextField("Location...", text: $location).padding().foregroundColor(.secondary)  .background(Color(.secondarySystemBackground)).cornerRadius(10)
            
            Button(action:{
                if self.remark != "" && self.location != ""{
                    let idCategory = self.categorySet.categorySet[self.selectedidCategory].idCategory
                    if(!self.isUpdateView){
                        if RemarkQueryService().createRemark(remark: self.remark, idCategory: idCategory, location: self.location){
                            self.isPresented.toggle()
                        }
                    }else{
                        if let remarkUpdated = self.remarkUpdated{
                            if RemarkQueryService().updateRemark(remark: remarkUpdated, remarkContent: self.remark, idCategory: idCategory, location: self.location){
                                self.isPresented.toggle()
                            }
                        }
                        
                    }
                    
                }else{
                    self.showingAlert = true
                }
            })
            {
                Text("Send").font(.title).padding(10).foregroundColor(.purple).background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .gray, radius: 3)
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("Empty Field"), message: Text("Please fill the fields"), dismissButton: .default(Text("Got it !")))
            }
            
        }.padding(10)
        
    }
}

/*struct CreateRemarkView_Previews: PreviewProvider {
 static var previews: some View {
 CreateRemarkView()
 }
 }*/
