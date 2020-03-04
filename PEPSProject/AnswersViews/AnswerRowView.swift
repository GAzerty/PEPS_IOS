//
//  AnswerRowView.swift
//  PEPSProject
//
//  Created by Paola Andreu on 02/03/2020.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct AnswerRowView: View {
    var answer: Answer!
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "person")
                Text("\(answer.user.pseudo ?? "pseudo")")
                //Text("pseudo")
            }.padding(10)
           
            Text("\(answer.answer)").padding(10)
            //Text("answer.answer").padding(10)
            
            HStack{
                Spacer()
                HStack{
                    Text("\(answer.nbLike)")
                    Image(systemName: "volume")
                }.padding(10.0)
            }
        }.background(Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0))).cornerRadius(30).padding(10).shadow(color: .gray, radius: 3, x: 1, y: 1)
    }
}

struct AnswerRowView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerRowView()
    }
}
