//
//  CreateAnswerView.swift
//  PEPSProject
//
//  Created by user164567 on 3/3/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct CreateAnswerView: View {
    
    @Binding var isPresented : Bool
    @State private var showingAlert = false
    @State var answer : String = ""
    var remark : Remark!
    @State var selectedidCategory: Int = 0
    var categorySet : CategorySet = CategorySet()
    
    var body: some View {
        VStack{
            Text("Create a Answser").padding(10).font(.largeTitle)
            TextField("Answser...", text: self.$answer).padding().background(Color.gray).cornerRadius(20)
            Picker(selection: $selectedidCategory, label: Text("Category")){
                ForEach(0 ..< categorySet.categorySet.count) {
                    Text("\(self.categorySet.categorySet[$0].lib)")
                }
            }
            
            Button(action:{
                if self.answer != ""{
                    let idCategory = self.categorySet.categorySet[self.selectedidCategory].idCategory
                    if let idAnswerCreated = AnswerQueryService().createAnswser(answser: self.answer, idCategory: idCategory){
                        if RemarkQueryService().linkAnswserToRemark(idRemark: self.remark.idRemark, idAnswer: idAnswerCreated){
                            guard let categAnswer = CategoryQueryService().getCategoryById(idCategory: idCategory) else{
                             return
                            }
                            guard let user = UserQueryService().getUserLogged() else{
                             return
                            }
                            guard let nbLike = AnswerQueryService().getNbLikeAnswer(idAnswer: idAnswerCreated) else{
                             return
                            }
                            let newAnswer = Answer(idAnswer: idAnswerCreated, answer: self.answer, category: categAnswer, user: user,nbLike: nbLike)
                            self.remark.answerSet.addAnswers(answer: newAnswer)
                            self.isPresented.toggle()
                        }
                    }
                }else{
                    self.showingAlert = true
                }
            })
            {
                Text("Send")
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("Empty Field"), message: Text("Please fill the fields"), dismissButton: .default(Text("Got it !")))
            }
            
        }
        
    }
}

/*struct CreateAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAnswerView(isPresented: <#Binding<Bool>#>)
    }
}*/
