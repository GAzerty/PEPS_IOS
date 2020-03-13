//
//  OrderByView.swift
//  PEPSProject
//
//  Created by Paola Andreu on 02/03/2020.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct OrderByView: View {
    @State var expand = false
    @ObservedObject var remarkSetSelected : RemarkSet

    var body : some View {
        VStack(spacing: 10){
            HStack{
                Text("Order by").fontWeight(.heavy).foregroundColor(Color(UIColor(red: 104/255, green: 83/255, blue: 163/255, alpha: 1.0)))
                Image(systemName: expand ? "chevron.up":"chevron.down").resizable().frame(width:13, height: 6)
            }.onTapGesture {
                self.expand.toggle()
            }
            if expand{
                
                Button(action : {
                    self.expand.toggle()
                    self.remarkSetSelected.remarkSet = self.remarkSetSelected.orderBy(order: 1)
                }){
                    Text("recent")
                    }.foregroundColor(.black).tag(1)
                Button(action : {self.expand.toggle()
                    self.remarkSetSelected.remarkSet = self.remarkSetSelected.orderBy(order: 2)
                }){
                    Text("recommanded")
                    }.foregroundColor(.black).tag(2)
            
            }
           
        }.padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .background(Color(.secondarySystemBackground)).cornerRadius(10).animation(.spring()).shadow(color: .gray, radius: 3, x: 1, y: 1)
    }
}

struct OrderByView_Previews: PreviewProvider {
    static var previews: some View {
        OrderByView(remarkSetSelected : RemarkSet())
    }
}
