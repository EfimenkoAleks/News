//
//  ModelForTableFavorites.swift
//  MyNews
//
//  Created by mac on 08.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import RxDataSources

//struct SectionOfCustomData {
//  var items: [Item]
//}
//extension SectionOfCustomData: SectionModelType {
//  typealias Item = SqlNewsModel
//
//   init(original: SectionOfCustomData, items: [Item]) {
//    self = original
//    self.items = items
//  }
//}


//extension String {
//    public typealias Identity = String
//    public var identity: Identity { return self }
//}



//extension SqlNewsModel: IdentifiableType {
//    var identity : String {
//        return self.linc
//    }
//}

//struct AnimatesSectionModel {
//    var forIdentity: String
//    var data: [SqlNewsModel]
//}
    
extension SqlNewsModel: IdentifiableType {

    typealias Identity = String
    var identity: Identity { return linc}
}

extension SqlNewsModel: Equatable {
    
    static func ==(lhs: SqlNewsModel, rhs: SqlNewsModel) -> Bool {
        return lhs.linc == rhs.linc
    }
}

struct AnimatesSectionModel {
    var header: String
    var items: [SqlNewsModel]
}

extension AnimatesSectionModel: AnimatableSectionModelType {
    
    typealias Identity = String
    typealias Item = SqlNewsModel
    var identity: Identity { return header}
  
    
    
    init(original: AnimatesSectionModel, items: [Item]) {
      self = original
      self.items = items
    }
    
//    static func ==(lhs: AnimatesSectionModel, rhs: AnimatesSectionModel) -> Bool {
//        return lhs.items.first?.linc == rhs.items.first?.linc
//    }

}
