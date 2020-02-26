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
                Text("\(remark.user.pseudo!)")
                Text("DATE 01/01/2020")
            }
            HStack{
                Text("\(remark.remark)")
            }
            HStack{
                Text("NB COMMENTS")
                Text("ENCOUNTER NUMBER")
            }
        }
    }
}

struct RemarkRowView_Previews: PreviewProvider {
    static var previews: some View {
        RemarkRowView()
    }
}
