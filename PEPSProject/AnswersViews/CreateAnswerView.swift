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
    var remark : Remark?
    @State var selectedidCategory: Int = 0
    var categorySet : CategorySet = CategorySet(type: "answer")
    var isUpdateView : Bool = false
    var answerUpdated : Answer?
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                Form{
                    Section{
                        
                        VStack{
                            
                            if(!self.isUpdateView){
                                Text("Create an Answser").font(.title).foregroundColor(.purple).cornerRadius(10.0).padding()
                            }else{
                                Text("Update a Answser").font(.title).foregroundColor(.purple).cornerRadius(10.0).padding()
                            }
                            TextField("Answser...", text: self.$answer).padding().background(Color(.secondarySystemBackground)).cornerRadius(10)
                            Picker(selection: $selectedidCategory, label: Text("Category")){
                                ForEach(0 ..< categorySet.categorySet.count) {
                                    Text("\(self.categorySet.categorySet[$0].lib)").padding().foregroundColor(.secondary)  .background(Color(.secondarySystemBackground)).cornerRadius(10)
                                }
                            }.padding().foregroundColor(.secondary)  .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                            
                        }
                        
                    }
                    
                }
                VStack{
                    Button(action:{
                        if self.answer != ""{
                            
                            
                            let idCategory = self.categorySet.categorySet[self.selectedidCategory].idCategory
                            
                            if(!self.isUpdateView){
                                if let idAnswerCreated = AnswerQueryService().createAnswser(answser: self.answer, idCategory: idCategory){
                                    if let remark = self.remark{
                                        if RemarkQueryService().linkAnswserToRemark(idRemark: remark.idRemark, idAnswer: idAnswerCreated){
                                            
                                            guard let user = UserQueryService().getUserLogged() else{
                                                return
                                            }
                                            guard let nbLike = AnswerQueryService().getNbLikeAnswer(idAnswer: idAnswerCreated) else{
                                                return
                                            }
                                            let newAnswer = Answer(idAnswer: idAnswerCreated, answer: self.answer, category: idCategory, user: user,nbLike: nbLike)
                                            remark.answerSet.addAnswers(answer: newAnswer)
                                            self.isPresented.toggle()
                                        }
                                    }
                                    
                                }
                            }else{
                                
                                if let answerUpdated = self.answerUpdated{
                                    if AnswerQueryService().updateAnswer(answer: answerUpdated, answerContent: self.answer, idCategory: idCategory){
                                        self.isPresented.toggle()
                                    }
                                }
                            }
                            
                        }else{
                            self.showingAlert = true
                        }
                    })
                    {
                        Text("Send").font(.title).padding(10).foregroundColor(.purple).background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: .gray, radius: 3)
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("Empty Field"), message: Text("Please fill the fields"), dismissButton: .default(Text("Got it !")))
                    }
                }
                
                
            }
            
        }
        
    }
}

/*struct CreateAnswerView_Previews: PreviewProvider {
 static var previews: some View {
 CreateAnswerView(isPresented: <#Binding<Bool>#>)
 }
 }*/
