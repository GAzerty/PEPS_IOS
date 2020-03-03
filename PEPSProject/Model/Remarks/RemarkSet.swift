//
//  RemarkSet.swift
//  PEPSProject
//
//  Created by user164567 on 2/26/20.
//  Copyright © 2020 user164567. All rights reserved.
//

import Foundation


class RemarkSet: ObservableObject {
    
    @Published var remarkSet : [Remark] = [Remark]()
    
    init(){
        addRemarks(remarkTab: RemarkQueryService().getAllRemarks())
    }
    
    init(idUser: Int){}
    
    func addRemarks(remark: Remark){
        self.remarkSet.append(remark)
    }
    
    func addRemarks(remarkTab: [Remark]){
        for remark in remarkTab{
            self.remarkSet.append(remark)
        }
    }
    func filterBy(idCategory : Int)->[Remark]{
        return remarkSet.filter( {$0.category != idCategory })
    }
    func filterBy(idCategories : [Int])->[Remark]{
        return idCategories == [] ? remarkSet : remarkSet.filter( { idCategories.contains($0.category) })
    }
    func orderBy(order : Int)->[Remark]{
        var remarkOrderer : [Remark]
        switch order {
        case 1://recent
            remarkOrderer = self.remarkSet.sorted(by: { $0.date > $1.date })
        case 2://recommmanded
            remarkOrderer = self.remarkSet.sorted(by: { $0.nbEncounter > $1.nbEncounter })
        default:
            remarkOrderer = self.remarkSet
        }
        return remarkOrderer
    }
}
