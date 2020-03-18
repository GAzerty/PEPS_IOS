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
    @State var errorMessage : String = ""
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(UIColor(red: 49/255, green: 32/255, blue: 97/255, alpha: 1.0)),Color(UIColor(red: 104/255, green: 83/255, blue: 163/255, alpha: 1.0)),Color(UIColor(red: 209/255, green: 111/255, blue: 172/255, alpha: 1.0)),Color(UIColor(red: 252/255, green: 239/255, blue: 245/255, alpha: 1.0)),.white]), startPoint: .top, endPoint: .bottom)
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
                            }else{
                                self.errorMessage = "Error during creation. Change username and try again"
                                self.showingAlert = true
                            }
                        }else{
                            self.errorMessage = "Empty field !"
                            self.showingAlert = true
                        }
                        
                    }) {
                        Text("Create")
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("A problem occured"), message: Text("\(self.errorMessage)"), dismissButton: .default(Text("Got it !")))
                }.padding().background(Color.white).foregroundColor(.blue).cornerRadius(15).shadow(color: .gray, radius: 3, x: 1, y: 1)
                    
                    Button(action: {
                        
                        
                        if (self.password != "" && self.pseudo != ""){
                            print("data checked")
                            if UserQueryService().login(pseudo: self.pseudo, password: self.password){
                                self.isPresented.toggle()
                            }else{
                                self.errorMessage = "Invalid Password or Username. Please try again"
                                self.showingAlert = true
                            }
                        }else{
                            self.errorMessage = "Empty field !"
                            self.showingAlert = true
                        }
                    }) {
                        Text("Login")
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("A problem occured"), message: Text("\(self.errorMessage)"), dismissButton: .default(Text("Got it !")))
                }.padding().background(Color.white).foregroundColor(.green).cornerRadius(15).shadow(color: .gray, radius: 3, x: 1, y: 1)
                }
                
                
            }.padding(20)
        }
        
        
        
        
    }
}

/*struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}*/
