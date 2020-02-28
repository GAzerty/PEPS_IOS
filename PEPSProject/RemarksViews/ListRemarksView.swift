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
                //NavBarView()
                ResearchBarView()
                List(self.remarkSet.remarkSet) {
                    remark in VStack{
                        RemarkRowView(remark: remark)
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
                                    .foregroundColor(Color(red: 50/255, green: 50/255, blue: 255/255))
                                    .frame(width: 55, height: 55)
                                
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                                    .foregroundColor(.white)
                            }
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
