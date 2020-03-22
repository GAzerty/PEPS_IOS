//
//  ContentView.swift
//  PEPSProject
//
//  Created by user164567 on 2/25/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var remarkSetBase : RemarkSet = RemarkSet()
    @ObservedObject var remarkSetSelected : RemarkSet = RemarkSet()
    @State var isShown: Bool = false
    @State var showMenu : Bool = false
    @State var haveBeenDisconnected : Bool = false
    @State var personalRemark: Bool = false
    
    var drag: some Gesture {
        DragGesture()
            .onEnded {
                _ in self.showMenu = false
                if(self.haveBeenDisconnected){
                    self.personalRemark = false
                    self.remarkSetBase.reset()
                    self.remarkSetSelected.reset()
                    self.remarkSetBase.addRemarks(remarkTab: RemarkQueryService().getAllRemarks())
                    self.remarkSetSelected.addRemarks(remarkTab: RemarkQueryService().getAllRemarks())
                    self.haveBeenDisconnected.toggle()
                }
                
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading){
            GeometryReader { geometry in
                VStack{
                    HStack{
                        Image("pepsColor")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80.0, height: 80.0)
                            
                        Spacer()
                        Button(action:{
                            if(!UserQueryService().isLogged()){
                                self.isShown.toggle()
                            }else{
                                withAnimation {
                                    self.showMenu = true
                                }
                            }
                        }){
                            VStack{
                                Image(systemName: "person")
                            }
                        }.sheet(isPresented: self.$isShown){
                            
                            CreateUserView(isPresented: self.$isShown)
                            
                        }.padding()
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(40)
                            .shadow(color: .gray, radius: 2, x: 1, y: 1)
                    }.padding(10)
                    
                    VStack{
                        if(UserQueryService().isLogged()){
                            ListRemarksView(remarkSetBase: self.remarkSetBase, remarkSetSelected: self.remarkSetSelected, personalRemark: self.$personalRemark, isConnected: true)
                        }
                        else{
                            ListRemarksView(remarkSetBase: self.remarkSetBase, remarkSetSelected: self.remarkSetSelected, personalRemark: self.$personalRemark, isConnected: false)
                        }
                        
                    }
                    
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                    .disabled(self.showMenu ? true : false)
                
                if self.showMenu {
                    SideMenuView(haveBeenDisconnected: self.$haveBeenDisconnected)
                        .frame(width: geometry.size.width/2)
                        .transition(.move(edge: .leading))
                }
            }
        }.onAppear{print("appear content")}.onDisappear{print("dispear content")}.gesture(drag)
  
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
