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
            Text("Pseudo: "+user.pseudo!)
            
            
            HStack{
                Button(action: {}) {
                Text("Modifier")
                    }.padding()
                Button(action: {}) {
                Text("Supprimer")
                }.padding().foregroundColor(.red)
            }
            
            Text("Mes Posts:").padding()
            //ListRemarksView(user)
        }
    }
}

struct ReadUserView_Previews: PreviewProvider {
    static var previews: some View {
        ReadUserView()
    }
}
