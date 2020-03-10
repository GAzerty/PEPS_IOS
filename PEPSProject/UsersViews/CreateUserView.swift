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
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.purple, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack (){
                Image("pepsWhite")
                .resizable()
                .scaledToFit()
                .frame(width: 200.0, height: 200.0)
                
                Text("Sign In or Login").padding().font(.title).foregroundColor(.white)
                
                TextField("Pseudo...", text: $pseudo).padding().background(Color.white).cornerRadius(20.0).shadow(color: .gray, radius: 3, x: 1, y: 1)
                SecureField("Password ...", text: $password).padding().background(Color.white).cornerRadius(20.0).shadow(color: .gray, radius: 3, x: 1, y: 1)
                
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
                }.padding().background(Color.orange).foregroundColor(.white).cornerRadius(15).shadow(color: .gray, radius: 3, x: 1, y: 1)
                    
                    Button(action: {
                        
                        
                        if (self.password != "" && self.pseudo != ""){
                            print("data checked")
                            if UserQueryService().login(pseudo: self.pseudo, password: self.password){
                                self.isPresented.toggle()
                            }
                        }else{
                            self.showingAlert = true
                        }
                    }) {
                        Text("Login")
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("Erreur"), message: Text("Valeurs incorrectes"), dismissButton: .default(Text("Compris !")))
                }.padding().background(Color.green).foregroundColor(.white).cornerRadius(15).shadow(color: .gray, radius: 3, x: 1, y: 1)
                }
                
                
            }
        }
        
        
        
        
    }
}

/*struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}*/
