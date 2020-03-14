//
//  RemarkRowView.swift
//  PEPSProject
//
//  Created by user164567 on 2/26/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct RemarkRowView: View {
    
    @ObservedObject var remarkSet: RemarkSet
    @ObservedObject var remark: Remark
    @State var isShown: Bool = false
    @State var isShown2: Bool = false
    var isUserRemarks : Bool!
    var body: some View {
        
        VStack{
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "person.circle").font(.system(size: 19))
                        Text("\(remark.user.pseudo ?? "pseudo")").bold().font(Font.system(size: 20)).foregroundColor(Color(UIColor(red: 104/255, green: 83/255, blue: 163/255, alpha: 1.0)))
                        Spacer()
                        Text("\(remark.getDateFormat(format: "fr_FR"))").font(Font.system(size: 13.5)).foregroundColor(Color(UIColor(red: 104/255, green: 83/255, blue: 163/255, alpha: 1.0)))
                    }
                    HStack{
                        Image(systemName: "mappin").foregroundColor(Color(.darkGray)).font(.system(size: 15))
                    Text("\(self.remark.location)").font(Font.system(size: 13.5)).foregroundColor(Color(.darkGray))
                    }
                }
            }.padding(10)
            
            HStack(){
              
            Text("\" \(remark.remark) \"")
                .font(Font.system(size: 20))
                
                Spacer()
            }.padding(5)
            
            HStack{
                
                HStack{
                    Text("\(remark.answerSet.answerSet.count)")
                    Image(systemName: "message").foregroundColor(Color(UIColor(red: 209/255, green: 111/255, blue: 172/255, alpha: 1.0)))
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
                            self.remarkSet.remove(remark: self.remark)
                        }
                    }
                    Spacer()
                }else{
                    Spacer()
                }
                HStack{
                    Text("\(remark.nbEncounter)").padding(5)
                    if(remark.nbEncounter == 0){
                        Image(systemName: "volume.fill").padding(5).foregroundColor(Color(UIColor(red: 209/255, green: 111/255, blue: 172/255, alpha: 1.0)))
                    }else if(remark.nbEncounter < 2){
                        Image(systemName: "volume.2.fill").padding(5).foregroundColor(Color(UIColor(red: 209/255, green: 111/255, blue: 172/255, alpha: 1.0)))
                    }else{
                        Image(systemName: "volume.3.fill").padding(5).foregroundColor(Color(UIColor(red: 209/255, green: 111/255, blue: 172/255, alpha: 1.0)))
                    }
                        
                    
                }.onTapGesture {
                    if(UserQueryService().isLogged()){
                        if !RemarkQueryService().addEncounter(remark: self.remark){
                            if RemarkQueryService().removeEncounter(remark: self.remark){
                            }
                        }
                    }
                }
            }.padding(10)
            
        }.background(Color(.white))//.cornerRadius(15).padding(5).shadow(color: .gray, radius: 3, x: 1, y: 1)
    }
    
}

/*
struct RemarkRowView_Previews: PreviewProvider {
    static var previews: some View {
        RemarkRowView(remark: Remark())
    }
}
*/
