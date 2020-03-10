//
//  AnswerRowView.swift
//  PEPSProject
//
//  Created by Paola Andreu on 02/03/2020.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct AnswerRowView: View {
    
    @State var isShown: Bool = false
    var answer: Answer!
    var isUserAnswers : Bool!
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "person")
                Text("\(answer.user.pseudo ?? "pseudo")")
            }.padding(10)
           
            Text("\(answer.answer)").padding(10)
            
            HStack{
                if(isUserAnswers){
                    Spacer()
                    Image(systemName: "square.and.pencil").foregroundColor(.green).onTapGesture {
                        self.isShown.toggle()
                    }.sheet(isPresented: self.$isShown){
                        CreateAnswerView(isPresented: self.$isShown, answer: self.answer.answer, remark: nil, isUpdateView: true, answerUpdated: self.answer)
                    }
                    Spacer()
                    Image(systemName: "trash").foregroundColor(.red).onTapGesture {
                        AnswerQueryService().deleteAnswer(idAnswer: self.answer.idAnswer)
                    }
                    Spacer()
                }else{
                    Spacer()
                }
                HStack{
                    Text("\(answer.nbLike)")
                    Image(systemName: "volume")
                }.onTapGesture {
                    if(UserQueryService().isLogged()){
                        if !AnswerQueryService().addLikeAnswer(answer: self.answer){
                            if AnswerQueryService().removeLikeAnswer(answer: self.answer){
                            }
                        }
                    }
                }.padding(10)

            }
        }.background(Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0))).cornerRadius(30).padding(10).shadow(color: .gray, radius: 3, x: 1, y: 1)
    }
}

struct AnswerRowView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerRowView()
    }
}
