//
//  CreateUserView.swift
//  PEPSProject
//
//  Created by user164567 on 2/25/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct CreateUserView: View {
    
    @Binding var isPresented : Bool
    @State private var showingAlert = false
    @State private var pseudo: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack (alignment: .center){
            Text("Creation d'un compte").padding()
            
            TextField("Pseudo...", text: $pseudo).padding().background(Color.gray).cornerRadius(20.0)
            SecureField("Password ...", text: $password).padding().background(Color.gray).cornerRadius(20.0)
            
            HStack{
                Button(action: {
                    if (self.password != "" && self.pseudo != ""){
                        print("data checked")
                        if UserQueryService().createUser(pseudo: self.pseudo, password: self.password){
                            self.isPresented.toggle()
                        }
                    }else{
                        self.showingAlert = true
                    }
                    
                }) {
                    Text("Create")
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text("Erreur"), message: Text("Valeurs incorrectes"), dismissButton: .default(Text("Compris !")))
            }.padding().background(Color.orange).foregroundColor(.white).cornerRadius(15)
                
                Button(action: {
                    UserQueryService().login(pseudo: "newUser", password: "newPass")
                }) {
                    Text("Login")
            }.padding().background(Color.green).foregroundColor(.white).cornerRadius(15)
            }
            
            
        }
        
    }
}

/*struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}*/
