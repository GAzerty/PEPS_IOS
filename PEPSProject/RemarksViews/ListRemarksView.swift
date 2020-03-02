//
//  ListRemarksView.swift
//  PEPSProject
//
//  Created by user164567 on 2/25/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct ListRemarksView: View {
    
    @ObservedObject var remarkSet : RemarkSet = RemarkSet()
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing){
                
                ResearchBarView()
                List(self.remarkSet.remarkSet) {
                    remark in NavigationLink(destination: RemarkRowView(remark: remark)) {VStack{
                        RemarkRowView(remark: remark)
                    }
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Button(action:{
                            print("Create a Remark")
                        }){
                            ZStack {
                                Circle()
                                    .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255))
                                    .frame(width: 55, height: 55).shadow(color: .gray, radius: 3, x: 1, y: 1)
                                
                                Image(systemName: "plus")
                                    .imageScale(.large)
                                    .foregroundColor(.purple)
                            }.padding()
                        }
                    }
                }
            }
            
            
        }
    }
    
}

struct ListRemarksView_Previews: PreviewProvider {
    static var previews: some View {
        ListRemarksView()
    }
}
