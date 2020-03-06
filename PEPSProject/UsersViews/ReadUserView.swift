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
    
    var body: some View {
        
        VStack{
            
            Text("Infos Personnelles:").padding()
            Text("Pseudo: "+self.user.pseudo!)
            
            Button(action: {}) {
            Text("Mes Posts:").padding()
                }.padding()
            
            Button(action: {}) {
            Text("Password")
                }.padding()
            
            Button(action: {}) {
            Text("Delete Account")
            }.padding().foregroundColor(.red)
            
        }
    }
}

struct ReadUserView_Previews: PreviewProvider {
    static var previews: some View {
        ReadUserView()
    }
}
