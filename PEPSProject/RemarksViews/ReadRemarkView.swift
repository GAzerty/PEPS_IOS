//
//  ReadRemarkView.swift
//  PEPSProject
//
//  Created by user164567 on 3/2/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct ReadRemarkView: View {
    
    @ObservedObject var remark : Remark
    @Binding var isPresentend : Bool
    @State var isShown: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            
            VStack{
               
            Text("Answsers").font(.largeTitle).foregroundColor(.purple).padding(10)
                    Spacer()
               
                ListAnswersView(answerSet: self.remark.answerSet)
            }
            VStack {
                Spacer()
                HStack {
                    Button(action:{self.isShown.toggle()}){
                        ZStack {
                            Circle()
                                .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255))
                                .frame(width: 55, height: 55).shadow(color: .gray, radius: 3, x: 1, y: 1)
                            
                            Image(systemName: "pencil")
                                .imageScale(.large)
                                .foregroundColor(.purple)
                        }.padding()
                    }.sheet(isPresented: self.$isShown){
                        
                        if(UserQueryService().isLogged()){
                            CreateAnswerView(isPresented: self.$isShown, remark: self.remark)
                        }
                    }
                }
            }
        }
    }
}

/*struct ReadRemarkView_Previews: PreviewProvider {
 static var previews: some View {
 ReadRemarkView()
 }
 }*/

