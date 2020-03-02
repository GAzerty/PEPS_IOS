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
    var body : some View {
        VStack(spacing: 10){
            HStack{
                Text("Order by").fontWeight(.heavy)
                Image(systemName: expand ? "chevron.up":"chevron.down").resizable().frame(width:13, height: 6)
            }.onTapGesture {
                self.expand.toggle()
            }
            if expand{
                Button(action : {self.expand.toggle()}){
                    Text("recent")
                }.foregroundColor(.black)
                Button(action : {self.expand.toggle()}){
                    Text("recommanded")
                }.foregroundColor(.black)
            }
           
        }.padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .background(Color(.secondarySystemBackground)).cornerRadius(10).animation(.spring())
    }
}

struct OrderByView_Previews: PreviewProvider {
    static var previews: some View {
        OrderByView()
    }
}
