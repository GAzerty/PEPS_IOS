//
//  FiltersView.swift
//  PEPSProject
//
//  Created by Paola Andreu on 28/02/2020.
//  Copyright © 2020 user164567. All rights reserved.
//

import SwiftUI

struct FiltersView: View {
    @ObservedObject var categorySet : CategorySet = CategorySet(type: "remark")
    @State var categoriesSelected : [Int] = [Int]()
    @ObservedObject var remarkSetBase : RemarkSet
    @ObservedObject var remarkSetSelected : RemarkSet
    @State var arePressed : [Int] = [Int]()
    @Binding var personalRemark: Bool
    var isConnected : Bool!
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack{
                if(self.isConnected){
                    Button(action:{
                        self.personalRemark.toggle()
                        if(self.personalRemark){
                            let userID = UserQueryService().getUserLogged()?.idUser
                            if let idUser = userID{
                                self.remarkSetBase.reset()
                                self.remarkSetBase.addRemarks(remarkTab: RemarkQueryService().getAllRemarksByUser(idUserChoosen: idUser))
                                self.remarkSetSelected.reset()
                                self.remarkSetSelected.addRemarks(remarkTab: RemarkQueryService().getAllRemarksByUser(idUserChoosen: idUser))
                            }
                        }else{
                            self.remarkSetBase.reset()
                            self.remarkSetSelected.reset()
                            self.remarkSetBase.addRemarks(remarkTab: RemarkQueryService().getAllRemarks())
                            self.remarkSetSelected.addRemarks(remarkTab: RemarkQueryService().getAllRemarks())
                        }
                        
                        
                    }){
                        Text("My Posts")
                    }.padding(5).foregroundColor(self.personalRemark ? Color.white : Color.secondary).background(self.personalRemark ? Color(UIColor(red: 104/255, green: 83/255, blue: 163/255, alpha: 1.0)) : Color(.secondarySystemBackground)).cornerRadius(50).shadow(color: .gray, radius: 3, x: 1, y: 1)
                }
                
                
                ForEach(self.categorySet.categorySet.indices){
                    i in
                   
                       Button(action: {
                        if(!self.arePressed.contains(i)){
                            self.arePressed.append(i)
                            self.categoriesSelected.append(self.categorySet.categorySet[i].idCategory)
                        }else{
                            print("supprimer")
                            self.arePressed.remove(at: self.arePressed.firstIndex(of: i)!)
                            self.categoriesSelected.remove(at: self.categoriesSelected.firstIndex(of: self.categorySet.categorySet[i].idCategory)!)
                            
                        }
                        print(i)
                        print(self.categoriesSelected)
                        self.remarkSetSelected.remarkSet = self.remarkSetBase.filterBy(idCategories: self.categoriesSelected)
                             }) {
                                Text("\(self.categorySet.categorySet[i].lib)").padding(5).foregroundColor(self.arePressed.contains(i) ? Color.white : Color.secondary).background(self.arePressed.contains(i) ? Color(UIColor(red: 104/255, green: 83/255, blue: 163/255, alpha: 1.0)) : Color(.secondarySystemBackground)).cornerRadius(50)
                       }.padding(5).shadow(color: .gray, radius: 3, x: 1, y: 1)
                }
            }
        }
    }
}

/*struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(remarkSetBase: RemarkSet(),remarkSetSelected: RemarkSet())
    }
}*/


