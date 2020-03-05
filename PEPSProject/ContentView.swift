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
    @State var showMenu : Bool = false
    
    var drag: some Gesture {
        DragGesture()
            .onEnded { _ in self.showMenu = false }
    }
    
    var body: some View {
        ZStack(alignment: .leading){
            GeometryReader { geometry in
                VStack{
                    HStack{
                        Text("PEPS").padding(10).font(.title)
                            .onTapGesture {
                            withAnimation {
                                self.showMenu = true
                            }
                        }
                        Spacer()
                        Button(action:{self.isShown.toggle()}){
                            VStack{
                                Image(systemName: "person")
                            }
                        }.sheet(isPresented: self.$isShown){
                            
                            if(UserQueryService().isLogged()){
                                
                                ReadUserView(user: UserQueryService().getUserLogged())
                            }else{
                                CreateUserView(isPresented: self.$isShown)
                            }
                        }.padding()
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(40)
                            .shadow(color: .gray, radius: 2, x: 1, y: 1)
                    }.padding(10)
                    
                    VStack{
                        ListRemarksView()
                    }
                    
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                    .disabled(self.showMenu ? true : false)
                
                if self.showMenu {
                    SideMenuView()
                        .frame(width: geometry.size.width/2)
                        .transition(.move(edge: .leading))
                }
            }
        }.gesture(drag)
  
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
