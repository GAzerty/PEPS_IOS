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
    @Binding var haveBeenDisconnected : Bool
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(UIColor(red: 49/255, green: 32/255, blue: 97/255, alpha: 1.0)),Color(UIColor(red: 104/255, green: 83/255, blue: 163/255, alpha: 1.0)),Color(UIColor(red: 209/255, green: 111/255, blue: 172/255, alpha: 1.0)),Color(UIColor(red: 252/255, green: 239/255, blue: 245/255, alpha: 1.0)),.white]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading){
                VStack{
                    if(self.isLogged){
                        ReadUserView(user: UserQueryService().getUserLogged(), haveBeenDisconnected: self.$haveBeenDisconnected)
                        Spacer()
                    }else{
                        Text("Please Login !").foregroundColor(.white).font(.title)
                    }
                   
                }.padding(10)
                
            }
        }.shadow(color: .gray, radius: 3, x: 1, y: 1)
        
        
        
    }
}

/*struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}*/
