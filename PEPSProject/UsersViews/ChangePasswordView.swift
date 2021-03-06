//
//  ChangePasswordView.swift
//  PEPSProject
//
//  Created by user164567 on 3/5/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @Binding var isPresented : Bool
    @State var password1 : String = ""
    @State var password2 : String = ""
    
    var body: some View {
        VStack(){
            
            Text("Change Password").font(.title).foregroundColor(.purple)
            .cornerRadius(10.0).padding()
            
            SecureField("New password ...", text: self.$password1).padding().background(Color.white).cornerRadius(20.0).shadow(color: .gray, radius: 3, x: 1, y: 1)
            
            SecureField("Confirm new password ...", text: self.$password2).padding().background(Color.white).cornerRadius(20.0).shadow(color: .gray, radius: 3, x: 1, y: 1)
            
            Button(action:{
                
                if(self.password1 != ""){
                    if(self.password1 == self.password2){
                        if UserQueryService().changePassword(password: self.password1){
                            self.isPresented.toggle()
                        }
                        
                    }else{
                        print("error: password not matching")
                    }
                }else{
                    print("error: empty field")
                }
                
                
            }){
                Text("Change")
                
            }.font(.title).padding(10).foregroundColor(.purple).background(Color.white)
            .cornerRadius(20)
            .shadow(color: .gray, radius: 3)
            
        }.padding(20)
    }
}

/*struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}*/
