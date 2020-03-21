//
//  ListRemarksView.swift
//  PEPSProject
//
//  Created by user164567 on 2/25/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct ListRemarksView: View {
    
    @ObservedObject var remarkSetBase : RemarkSet
    @ObservedObject var remarkSetSelected : RemarkSet
    @State var isShown: Bool = false
    @Binding var personalRemark: Bool
    var isConnected : Bool!

    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            
            
            VStack{
                ResearchBarView(remarkSetBase: self.remarkSetBase,remarkSetSelected: self.remarkSetSelected, personalRemark: self.$personalRemark, isConnected: self.isConnected)
                List(self.remarkSetSelected.remarkSet) {
                    remark in VStack{
                        RemarkRowView(remarkSet: self.remarkSetSelected,remark: remark, isUserRemarks: self.personalRemark)
                    }
                }
                
            }
            VStack {
                Spacer()
                HStack {
                    Button(action:{self.isShown.toggle()}){
                        ZStack {
                            Circle()
                                .foregroundColor(Color(.white))
                                .frame(width: 55, height: 55).shadow(color: .gray, radius: 3, x: 1, y: 1)
                            
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .foregroundColor(Color(UIColor(red: 209/255, green: 111/255, blue: 172/255, alpha: 1.0)))
                        }.padding()
                    }.sheet(isPresented: self.$isShown){
                        
                        if(UserQueryService().isLogged()){
                            CreateRemarkView(isPresented: self.$isShown,isUpdateView: false,remarkSet: self.remarkSetSelected)
                        }else{
                            CreateUserView(isPresented: self.$isShown)
                        }
                    }
                }
            }
        }
    }
    
    
}

/*struct ListRemarksView_Previews: PreviewProvider {
    static var previews: some View {
        ListRemarksView()
    }
}*/
