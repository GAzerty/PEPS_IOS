//
//  ContentView.swift
//  PEPSProject
//
//  Created by user164567 on 2/25/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   
    @State var isShown: Bool = false

    var body: some View {
        
        VStack{
            HStack{
                Text(" WELCOME TO PEPS").padding()
                Button(action:{self.isShown.toggle()}){
                    VStack{
                        Image(systemName: "person")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.gray)
                        .cornerRadius(40)
                    }
                }.sheet(isPresented: self.$isShown){
                    
                    if(UserQueryService().isLogged()){
                        
                        ReadUserView(user: UserQueryService().getUserLogged())
                    }else{
                        CreateUserView(isPresented: self.$isShown)
                    }
                }
                   
            }
            VStack{
                ListRemarksView()
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
