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
    @State var connectedPanel : Bool = true
    @Binding var haveBeenDisconnected : Bool
    
    var body: some View {
        
        VStack{
            if(self.connectedPanel){
                Text(self.user.pseudo!).padding(10).foregroundColor(.white).font(.title)
                
                Button(action: {self.isShown.toggle()}) {
                    Text("Password").padding(10).background(Color(.white)).cornerRadius(10)
                }.sheet(isPresented: self.$isShown){
                    ChangePasswordView(isPresented: self.$isShown)
                }.padding(10)
                
                Button(action:{
                    UserQueryService().logout()
                    self.haveBeenDisconnected = true
                    self.connectedPanel.toggle()
                }){
                    Text("Logout").padding(10).background(Color(.white)).cornerRadius(10)
                }.padding(10).foregroundColor(.orange)
                
                
                Button(action: {
                    if UserQueryService().deleteUser(){
                        UserQueryService().logout()
                        self.haveBeenDisconnected = true
                        self.connectedPanel.toggle()
                    }
                }) {
                    Text("Delete Account").padding(10).background(Color(.white)).cornerRadius(10)
                }.padding(10).foregroundColor(.red)
            }else{
                HStack{
                    Text("See you again... ").padding(10).foregroundColor(.white).font(.headline)
                }
                
            }
            
            
        }
    }
}

/*struct ReadUserView_Previews: PreviewProvider {
    static var previews: some View {
        ReadUserView()
    }
}*/
