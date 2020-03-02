//
//  ReadRemarkView.swift
//  PEPSProject
//
//  Created by user164567 on 3/2/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct ReadRemarkView: View {
    
    var remark : Remark!
    
    var body: some View {
        
        VStack{
            RemarkRowView(remark: self.remark)
            
        }
        
    }
}

/*struct ReadRemarkView_Previews: PreviewProvider {
    static var previews: some View {
        ReadRemarkView()
    }
}*/

