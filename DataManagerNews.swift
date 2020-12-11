//
//  DataManagerNews.swift
//  MyNews
//
//  Created by user on 31.08.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SQLite
import RxSwift
import RxCocoa

class DataManagerNews {
   
   static let sharedManager = DataManagerNews()
    
    // для создания таблицы sqlite------------------------
    var dataBase: Connection!
    let lincsTable = Table("lincs")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let linc = Expression<String>("linc")
    let lincImage = Expression<String>("lincImage")
    let source = Expression<String>("source")
    //----------------------------------------------------
    
    private var itemsPrivate: PublishSubject<[AnimatesSectionModel]>
    var items: Observable<[AnimatesSectionModel]> {
        return itemsPrivate.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
    
   private init() {
    
    // для создания таблицы sqlite-------------------------
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("news").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.dataBase = database
        } catch {
            print(error)
        }
        //-------------------------------------------------------
    
    self.itemsPrivate = PublishSubject<[AnimatesSectionModel]>()
    
    self.createTableDatabase()
    }
    
    private func createTableDatabase() {
         let createTable = self.lincsTable.create { (table) in
             table.column(self.id, primaryKey: true)
             table.column(self.name)
             table.column(self.linc, unique: true)
            table.column(self.lincImage)
            table.column(self.source)
         }
         do {
             try self.dataBase.run(createTable)
         } catch {
             print(error)
         }
     }
    
    func insert(newsName: String, linc: String, newsImage: String,  newsSource: String) {
        let insertNews = self.lincsTable.insert(DataManagerNews.sharedManager.name <- newsName, DataManagerNews.sharedManager.linc <- linc, DataManagerNews.sharedManager.lincImage <- newsImage, DataManagerNews.sharedManager.source <- newsSource)
        do {
            try self.dataBase.run(insertNews)
//            self.getItems()
            self.itemsPrivate.onNext(self.listNews2()!)
            print("Insert News")
        } catch {
            print(error)
        }
    }
    
//    private func getItems() {
//           var arrayList = [AnimatesSectionModel]()
//           do {
//               let news = try self.dataBase.prepare(self.lincsTable)
//               for new in news {
//                   arrayList.append(AnimatesSectionModel(header: new[self.linc], items: [SqlNewsModel(name: new[self.name], linc: new[self.linc], lincImage: new[self.lincImage], source: new[self.source])]))
//               }
//                self.itemsPrivate.onNext(arrayList)
//           } catch {
//               print(error)
//           }
//       }
     
    func listNews() -> [SqlNewsModel]? {
        var arrayList = [SqlNewsModel]()
         do {
             let news = try self.dataBase.prepare(self.lincsTable)
             for new in news {
                 print("lincId: \(new[self.id]), name: \(new[self.name]), linc: \(new[self.linc])")
                let curentNews = SqlNewsModel(name: new[self.name], linc: new[self.linc], lincImage: new[self.lincImage], source: new[self.source])
                arrayList.append(curentNews)
             }
            return arrayList
         } catch {
             print(error)
            return nil
         }
     }
    
    func listNews2() -> [AnimatesSectionModel]? {
        
        var arrayList = [AnimatesSectionModel]()
        do {
            let news = try self.dataBase.prepare(self.lincsTable)
            for new in news {
                arrayList.append(AnimatesSectionModel(header: new[self.linc], items: [SqlNewsModel(name: new[self.name], linc: new[self.linc], lincImage: new[self.lincImage], source: new[self.source])]))
                
            }
            return arrayList
        } catch {
            print(error)
            return nil
        }
    }
    
    func deleteUser(userLinc: String) {
        
        let user = self.lincsTable.filter(self.linc == userLinc)
        let deleteUser = user.delete()
        do {
            try self.dataBase.run(deleteUser)
//            self.getItems()
            self.itemsPrivate.onNext(self.listNews2()!)
            print("deleteUser")
        } catch {
            print(error)
        }
    }
    


}
