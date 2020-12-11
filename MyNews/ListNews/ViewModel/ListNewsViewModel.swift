//
//  ListNewsViewModel.swift
//  MyNews
//
//  Created by user on 05.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SDWebImage

protocol ListNewsViewModelProtocol: class {
//    var router: RouterProtocol { get set}
    var netWorkServis: NetworkServisProtocol { get }
    var dictBehavior: [String: BehaviorSubject<UIImage>] { get set}
    var data: BehaviorRelay<[New]> { get set}
    var keyDownload: BehaviorSubject<Bool> { get set}
    var numberPage: String { get set}
    init(serch: String?, country: String?, category: String?, language: String?, indexRequest: Int, router: RouterProtocol, netWorkServis: NetworkServisProtocol)
    func showNews(news: SqlNewsModel)
    func addNextPage(page: String)
}

class ListNewsViewModel: ListNewsViewModelProtocol {
    
    var router: RouterProtocol
    var dictBehavior: [String: BehaviorSubject<UIImage>]
    var data: BehaviorRelay<[New]>
    var netWorkServis: NetworkServisProtocol
    var keyDownload: BehaviorSubject<Bool>
    let disposBag = DisposeBag()
    var numberPage: String
    var search: BehaviorRelay<String>
    var country: BehaviorRelay<String>
    var category: BehaviorRelay<String>
    var language: BehaviorRelay<String>
    var indexRequest: BehaviorRelay<Int>
     
    required init(serch: String?, country: String?, category: String?, language: String?, indexRequest: Int, router: RouterProtocol, netWorkServis: NetworkServisProtocol) {
        
        self.router = router
        self.netWorkServis = netWorkServis
        self.indexRequest = BehaviorRelay<Int>(value: indexRequest)
        self.dictBehavior = [
            "non": BehaviorSubject(value: UIImage(named: "picture")!)
        ]
        self.keyDownload = BehaviorSubject<Bool>(value: false)
        self.search =  BehaviorRelay<String>(value: "")
        self.country =  BehaviorRelay<String>(value: "")
        self.category =  BehaviorRelay<String>(value: "")
        self.language =  BehaviorRelay<String>(value: "")
        
        if let ser = serch, ser.count > 1 {
            self.search.accept(ser)
        }
        if let cou = country, cou.count > 1 {
            self.country.accept(cou)
        }
        if let cat = category, cat.count > 1 {
            self.category.accept(cat)
        }
        if let lan = language, lan.count > 1 {
            self.language.accept(lan)
        }
//        let encoder = JSONEncoder()
//        let news = NewEncod(author: "Washington Post",
//                            title: "Apple get mony",
//                            url: "https://www.apple.com/apple-news/",
//                            urlToImage: "https://openscience.academy/img/news/201713052212257708.jpg",
//                            publishedAt: "13.07.2020",
//                            source: "news.google.com")
//
//        do {
//            let dataEncod = try encoder.encode(news)
//            let parsedResult: New = try! JSONDecoder().decode(New.self, from: dataEncod)
//            self.data = BehaviorRelay(value: [parsedResult])
//        } catch {
//            print("error data encoding------------------------------------")
//            self.data = BehaviorRelay(value: [])
//        }
        self.data = BehaviorRelay(value: [])
        
        self.numberPage = "1"
//        print("search \(self.search.value)")
//        print("country \(self.country.value)")
//        print("category \(self.category.value)")
//        print("language \(self.language.value)")
//        print("indexRequest \(self.indexRequest.value)")
        
        self.netWorkServis.getNews(serch: self.search.value, country: self.country.value, category: self.category.value, language: self.language.value, indexRequest: self.indexRequest.value, page: self.numberPage) { (list) in
            
            if list.articles.count > 0 {
            var arrayNew = [New]()
            arrayNew.append(list.articles[0])
            let arrayList = self.filterData(source: list.articles, data: arrayNew)
                
            self.data.removeAll()
            self.data.append(contentsOf: arrayList)
            self.keyDownload.onNext(true)
//            for lis in list.articles {
//                print("\(String(describing: lis.title))")
//                print("\(String(describing: lis.urlToImage))")
//            }
        }
        }
        
        print("\(String(describing: self.data.value.count))")
    }
    
    private func filterData(source: [New], data: [New]) -> [New] {
        var arraySource = data
        for arr1 in source {
            var boolContain = false
            for arr2 in arraySource {
                if arr2.url == arr1.url {
                   boolContain = true
                //    break
                }
            }
            if boolContain == false {
                arraySource.append(arr1)
            }
        }
        return arraySource
    }
    
    func addNextPage(page: String) {
        self.netWorkServis.getNews(serch: self.search.value, country: self.country.value, category: self.category.value, language: self.language.value, indexRequest: self.indexRequest.value, page: page) { (list) in
            
            let arrayList = self.filterData(source: list.articles, data: self.data.value)
            self.data.append(contentsOf: arrayList)
            self.keyDownload.onNext(true)
        }
    }
    
    func showNews(news: SqlNewsModel) {
        self.router.showWebNews(newStr: news)
       }
}

extension BehaviorRelay where Element: RangeReplaceableCollection {

    func append(_ subElement: Element.Element) {
        var newValue = value
        newValue.append(subElement)
        accept(newValue)
    }

    func append(contentsOf: [Element.Element]) {
        var newValue = value
        newValue.append(contentsOf: contentsOf)
        accept(newValue)
    }

    public func remove(at index: Element.Index) {
        var newValue = value
        newValue.remove(at: index)
        accept(newValue)
    }

    public func removeAll() {
        var newValue = value
        newValue.removeAll()
        accept(newValue)
    }

}
