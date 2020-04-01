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
    @ObservedObject var answerSet: AnswerSet
    @ObservedObject var answer: Answer
    var isUserAnswers : Bool!
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Image(systemName: "person.circle").font(.system(size: 19))
                Text("\(answer.user.pseudo ?? "pseudo")").bold().font(Font.system(size: 20)).foregroundColor(Color(UIColor(red: 104/255, green: 83/255, blue: 163/255, alpha: 1.0)))
                
                Spacer()
                Text("\(CategoryQueryService().getCategoryById(idCategory: answer.category)!.lib)").font(Font.system(size: 13.5)).foregroundColor(Color(.darkGray))
            }.padding(10)
            
            HStack(){
                
                Text("\" \(answer.answer) \"")
                    .font(Font.system(size: 20))
                
                Spacer()
            }.padding(5)
            
            
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
                        if AnswerQueryService().deleteAnswer(idAnswer: self.answer.idAnswer){
                            self.answerSet.remove(answer: self.answer)
                        }
                    }
                    Spacer()
                }else{
                    Spacer()
                }
                HStack{
                    Text("\(self.answer.nbLike)")
                    if(self.answer.nbLike == 0){
                        Image(systemName: "volume.fill").padding(5).foregroundColor(Color(UIColor(red: 209/255, green: 111/255, blue: 172/255, alpha: 1.0)))
                    }else if(self.answer.nbLike < 2){
                        Image(systemName: "volume.2.fill").padding(5).foregroundColor(Color(UIColor(red: 209/255, green: 111/255, blue: 172/255, alpha: 1.0)))
                    }else{
                        Image(systemName: "volume.3.fill").padding(5).foregroundColor(Color(UIColor(red: 209/255, green: 111/255, blue: 172/255, alpha: 1.0)))
                    }
                }.onTapGesture {
                    print("tap gesture addlike answer")
                    if(UserQueryService().isLogged()){
                        if !AnswerQueryService().addLikeAnswer(answer: self.answer){
                            if AnswerQueryService().removeLikeAnswer(answer: self.answer){
                            }
                        }
                    }
                }.padding(10)
                
            }
            
        }.background(Color(.white)).cornerRadius(15).padding(10).shadow(color: .gray, radius: 3, x: 1, y: 1)
        
    }
    
}

/*struct AnswerRowView_Previews: PreviewProvider {
 static var previews: some View {
 AnswerRowView(answer: <#Answer#>)
 }
 }*/
