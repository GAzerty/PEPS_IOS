//
//  CreateUserView.swift
//  PEPSProject
//
//  Created by user164567 on 2/25/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct CreateUserView: View {
    
    @State private var pseudo: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack (alignment: .center){
            Text("Creation d'un compte").padding()
            
            TextField("Pseudo...", text: $pseudo).padding().background(Color.gray).cornerRadius(20.0)
            TextField("Password ...", text: $password).padding().background(Color.gray).cornerRadius(20.0)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Text("Create")
            }.padding().background(Color.green).foregroundColor(.white).cornerRadius(15)
            
        }
        
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}
