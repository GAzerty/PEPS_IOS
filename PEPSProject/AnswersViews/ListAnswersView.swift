//
//  ListAnswersView.swift
//  PEPSProject
//
//  Created by Paola Andreu on 02/03/2020.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct ListAnswersView: View {
    @ObservedObject var answerSet : AnswerSet = AnswerSet()
    
    var body: some View {
        
        List(self.answerSet.answerSet) {
            answer in
            VStack{
                AnswerRowView(answer: answer)
            }
        }
    }
}

struct ListAnswersView_Previews: PreviewProvider {
    static var previews: some View {
        ListAnswersView()
    }
}
