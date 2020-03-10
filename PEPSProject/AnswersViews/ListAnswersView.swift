//
//  ListAnswersView.swift
//  PEPSProject
//
//  Created by Paola Andreu on 02/03/2020.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct ListAnswersView: View {
    @ObservedObject var answerSet : AnswerSet
    var body: some View {
        
        VStack{
            List(self.answerSet.answerSet) {
                answer in
                
                VStack{
                    
                    if(UserQueryService().getUserLogged()?.idUser == answer.user.idUser){
                        AnswerRowView(answer: answer,isUserAnswers: true)
                    }else{
                        AnswerRowView(answer: answer,isUserAnswers: false)
                    }
                    
                }
            }
        }
    }
}

/*struct ListAnswersView_Previews: PreviewProvider {
    static var previews: some View {
        ListAnswersView()
    }
}*/
