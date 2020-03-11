//
//  ReadUserView.swift
//  PEPSProject
//
//  Created by user164567 on 2/25/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct ReadUserView: View {
    
    var user: User!
    @State var isShown: Bool = false
    var body: some View {
        
        VStack{
            
            Text("Personal Data").padding(10).background(Color(.white)).cornerRadius(10)
            Text(self.user.pseudo!).padding(10).foregroundColor(.white).font(.headline)
            
            Button(action: {self.isShown.toggle()}) {
                Text("Password").padding(10).background(Color(.white)).cornerRadius(10)
            }.sheet(isPresented: self.$isShown){
                ChangePasswordView(isPresented: self.$isShown)
            }.padding(10)
            
            Button(action: {}) {
            Text("Delete Account").padding(10).background(Color(.white)).cornerRadius(10)
            }.padding(10).foregroundColor(.red)
            
        }
    }
}

struct ReadUserView_Previews: PreviewProvider {
    static var previews: some View {
        ReadUserView()
    }
}
