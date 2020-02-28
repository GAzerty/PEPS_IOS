//
//  RemarkRowView.swift
//  PEPSProject
//
//  Created by user164567 on 2/26/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct RemarkRowView: View {
    
    var remark: Remark!
    
    var body: some View {
      VStack{
        HStack{
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "person")
                    Text("\(remark.user.pseudo ?? "pseudo")")
                    Spacer()
                    Text("\(remark.date)")
                }
                HStack{
                    Image(systemName: "mappin")
                    Text("\(remark.location)")
                }
            }
            
               
        }.padding(10)
        Divider()
        Text("\(remark.remark)").padding(10)
        Divider()
        HStack{
            Text("remark.nbComments  comments")
            Spacer()
            HStack{
                Text("\(remark.nbEncounter)")
                Image(systemName: "volume")
            }
        }.padding(10.0)
    }.background(Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0))).cornerRadius(30).padding(10).shadow(color: .gray, radius: 1, x: 1, y: 1)
    }
}


struct RemarkRowView_Previews: PreviewProvider {
    static var previews: some View {
        RemarkRowView()
    }
}
