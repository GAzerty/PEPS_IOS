//
//  SideMenuView.swift
//  PEPSProject
//
//  Created by user164567 on 3/5/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct SideMenuView: View {
    
    @State var isLogged : Bool = UserQueryService().isLogged()
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.gray, .white]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading){
                VStack{
                    if(self.isLogged){
                        ReadUserView(user: UserQueryService().getUserLogged())
                        Spacer()
                    }else{
                        Text("Please Login !").foregroundColor(.white).font(.title)
                    }
                   
                }.padding(10)
                
            }
        }.shadow(color: .gray, radius: 3, x: 1, y: 1)
        
        
        
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
