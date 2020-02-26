//
//  ListRemarksView.swift
//  PEPSProject
//
//  Created by user164567 on 2/25/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct ListRemarksView: View {
    
    var remarkSet : RemarkSet = RemarkSet()
    
    var body: some View {
        
        VStack{
            //NavBarView()
            //SearchView()
            Text("\(remarkSet.remarkSet.count)")
            List(self.remarkSet.remarkSet) {
                remark in VStack{
                    RemarkRowView(remark: remark)
                    Text("hi")
                }
            }
        }
    }
}

struct ListRemarksView_Previews: PreviewProvider {
    static var previews: some View {
        ListRemarksView()
    }
}
