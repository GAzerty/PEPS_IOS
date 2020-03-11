//
//  RemarkRowView.swift
//  PEPSProject
//
//  Created by user164567 on 2/26/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct RemarkRowView: View {
    
    @ObservedObject var remark: Remark
    @State var isShown: Bool = false
    @State var isShown2: Bool = false
    var isUserRemarks : Bool!
    var body: some View {
        
        VStack{
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "person")
                        Text("\(remark.user.pseudo ?? "pseudo")")
                        Spacer()
                        Text("\(remark.getDateFormat(format: "fr_FR"))")
                    }
                    HStack{
                        Image(systemName: "mappin")
                        Text("\(self.remark.location)")
                    }
                }
            }.padding(10)
            Divider()
            HStack{
                Text("\(remark.remark)")
            }.padding(10)
            Divider()
            
            HStack{
                
                HStack{
                    Text("\(remark.answerSet.answerSet.count)").padding(5)
                    Image(systemName: "message").foregroundColor(.blue).padding(5)
                }.onTapGesture {
                    self.isShown.toggle()
                }.sheet(isPresented: self.$isShown){
                    ReadRemarkView(remark: self.remark,isPresentend: self.$isShown)
                }
                if(self.isUserRemarks){
                    Spacer()
                    Image(systemName: "square.and.pencil").onTapGesture {
                        self.isShown2.toggle()
                    }.sheet(isPresented: self.$isShown2){
                        CreateRemarkView(isPresented: self.$isShown2, remark: self.remark.remark, location: self.remark.location, isUpdateView: true, remarkUpdated: self.remark)
                    }
                    Spacer()
                    Image(systemName: "trash").foregroundColor(.red).onTapGesture {
                        if RemarkQueryService().deleteRemark(idRemark: self.remark.idRemark){
                            print("deleted remark")
                        }
                    }
                    Spacer()
                }else{
                    Spacer()
                }
                HStack{
                    Text("\(remark.nbEncounter)").padding(5)
                    if(remark.nbEncounter == 0){
                        Image(systemName: "volume.fill").padding(5)
                    }else if(remark.nbEncounter < 2){
                        Image(systemName: "volume.2.fill").padding(5)
                    }else{
                        Image(systemName: "volume.3.fill").padding(5)
                    }
                        
                    
                }.onTapGesture {
                    if(UserQueryService().isLogged()){
                        if !RemarkQueryService().addEncounter(remark: self.remark){
                            if RemarkQueryService().removeEncounter(remark: self.remark){
                            }
                        }
                    }
                }
            }.padding(10.0)
            
        }.background(Color(.white)).cornerRadius(15).padding(10).shadow(color: .gray, radius: 3, x: 1, y: 1)
    }
    
}


/*struct RemarkRowView_Previews: PreviewProvider {
    static var previews: some View {
        RemarkRowView(remark: <#Remark#>)
    }
}*/
