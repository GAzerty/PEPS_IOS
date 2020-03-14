//
//  ListUserRemarksView.swift
//  PEPSProject
//
//  Created by user164567 on 3/6/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct ListUserRemarksView: View {
    @ObservedObject var remarkSetBase : RemarkSet = RemarkSet(idUser: UserQueryService().getUserLogged()?.idUser)
    @ObservedObject var remarkSetSelected : RemarkSet = RemarkSet(idUser: UserQueryService().getUserLogged()?.idUser)
    @State var isShown: Bool = false
    @State var personalRemark: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            VStack{
                ResearchBarView(remarkSetBase: self.remarkSetBase,remarkSetSelected: self.remarkSetSelected, personalRemark: self.$personalRemark)
                List(self.remarkSetSelected.remarkSet) {
                    remark in VStack{
                        RemarkRowView(remarkSet: self.remarkSetSelected,remark: remark, isUserRemarks: true)
                    }
                }
            }
            VStack {
                Spacer()
                HStack {
                    Button(action:{self.isShown.toggle()}){
                        ZStack {
                            Circle()
                                .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255))
                                .frame(width: 55, height: 55).shadow(color: .gray, radius: 3, x: 1, y: 1)
                            
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .foregroundColor(.purple)
                        }.padding()
                    }.sheet(isPresented: self.$isShown){
                        
                        if(UserQueryService().isLogged()){
                            CreateRemarkView(isPresented: self.$isShown)
                        }else{
                            CreateUserView(isPresented: self.$isShown)
                        }
                    }
                }
            }
        }
    }
}

struct ListUserRemarksView_Previews: PreviewProvider {
    static var previews: some View {
        ListUserRemarksView()
    }
}
