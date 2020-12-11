//
//  ChoiceViewModel.swift
//  MyNews
//
//  Created by mac on 01.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SDWebImage
import SwiftEntryKit
import RxDataSources

protocol ChoiseViewModelProtocol: class {
    var dataSource: RxTableViewSectionedAnimatedDataSource<AnimatesSectionModel> { get set}
    var countryTextPublicSubject: BehaviorRelay<String> { get set}
    var categoryTextPublicSubject: BehaviorRelay<String> { get set}
    var serhcTextPublicSubject: BehaviorRelay<String> { get set}
    var serhc2TextPublicSubject: BehaviorRelay<String> { get set}
    var languageTextPublicSubject: BehaviorRelay<String> { get set}
    var segmentIndex: BehaviorRelay<Int> { get set}
    init(router: RouterProtocol, netWorkServis: NetWorkServisCountrie)
    func showNews()
    func showFavoritesNews(news: SqlNewsModel)
    func setupAttributes() -> EKAttributes
    func removeItem(at indexPath: IndexPath)
    func getData() -> Observable<[AnimatesSectionModel]>
    func isValid() -> Observable<Bool>
    
}

class ChoiceViewModel: ChoiseViewModelProtocol {
    
    var router: RouterProtocol
    var netWorkServis: NetWorkServisCountrie
    var dataSource: RxTableViewSectionedAnimatedDataSource<AnimatesSectionModel>
    var data: BehaviorSubject<[AnimatesSectionModel]>
    let disposBag = DisposeBag()
    var countryTextPublicSubject: BehaviorRelay<String>
    var categoryTextPublicSubject: BehaviorRelay<String>
    var serhcTextPublicSubject: BehaviorRelay<String>
    var serhc2TextPublicSubject: BehaviorRelay<String>
    var languageTextPublicSubject: BehaviorRelay<String>
    var segmentIndex: BehaviorRelay<Int>
    var countryOut: String
    var categoryOut: String
    var searchOut: String
    var search2Out: String
    var languageOut: String

    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(self.countryTextPublicSubject.asObservable().startWith(""), self.categoryTextPublicSubject.asObservable().startWith(""), self.serhcTextPublicSubject.asObservable().startWith(""), self.serhc2TextPublicSubject.asObservable().startWith(""), self.languageTextPublicSubject.asObservable().startWith("")).map { country, category, serhc, serhc2, language in
            return country.count > 1 || category.count > 1 || serhc.count > 1 || (serhc2.count > 1 && language.count > 1)
        }.startWith(false)
    }
    
    required init(router: RouterProtocol, netWorkServis: NetWorkServisCountrie) {
        
        self.router = router
        self.netWorkServis = netWorkServis
        
        if DataManagerNews.sharedManager.listNews() != nil {
            self.data = BehaviorSubject(value: DataManagerNews.sharedManager.listNews2()!)
        } else {
            self.data = BehaviorSubject(value: [])
        }
      
        self.dataSource = RxTableViewSectionedAnimatedDataSource<AnimatesSectionModel>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .none,
                                                           reloadAnimation: .none,
                                                           deleteAnimation: .left),
            configureCell: { dataSource, tableView, indexPath, title in
                let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell2", for: indexPath) as! ListTableViewCell
                return cell
        })
        
        self.countryTextPublicSubject = BehaviorRelay<String>(value: "")
        self.categoryTextPublicSubject = BehaviorRelay<String>(value: "")
        self.serhcTextPublicSubject = BehaviorRelay<String>(value: "")
        self.serhc2TextPublicSubject = BehaviorRelay<String>(value: "")
        self.languageTextPublicSubject = BehaviorRelay<String>(value: "")
        self.segmentIndex = BehaviorRelay<Int>(value: 0)
        self.countryOut = ""
        self.categoryOut = ""
        self.searchOut = ""
        self.search2Out = ""
        self.languageOut = ""
        
        self.segmentIndex.asObservable().subscribe(onNext: { (new) in
            print("section \(new)")
        }).disposed(by: self.disposBag)
        self.countryTextPublicSubject.asObservable().subscribe(onNext: { (new) in
            self.countryOut = new
        }).disposed(by: self.disposBag)
        self.categoryTextPublicSubject.asObservable().subscribe(onNext: { (new) in
            self.categoryOut = new
        }).disposed(by: self.disposBag)
        self.serhcTextPublicSubject.asObservable().subscribe(onNext: { (new) in
            self.searchOut = new
        }).disposed(by: self.disposBag)
        self.serhc2TextPublicSubject.asObservable().subscribe(onNext: { (new) in
            self.search2Out = new
        }).disposed(by: self.disposBag)
        self.languageTextPublicSubject.asObservable().subscribe(onNext: { (new) in
            self.languageOut = new
        }).disposed(by: self.disposBag)
        
        self.createDataSource()
        
        DataManagerNews.sharedManager.items
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (newItem) in
                self.data.onNext(newItem)
            }, onError: { (error) in
                print(error)
            }).disposed(by: self.disposBag)
    }
    
    func getData() -> Observable<[AnimatesSectionModel]> {
        return data.asObservable()
    }
    
    func removeItem(at indexPath: IndexPath) {
        
        guard let sections = try? self.data.value() else { return }
        
        // Get the current section from the indexPath
        let currentSection = sections[indexPath.section]
        
        // Remove the item from the section at the specified indexPath
        DataManagerNews.sharedManager.deleteUser(userLinc: currentSection.items[indexPath.row].linc)
 //       currentSection.items.remove(at: indexPath.row)
        
        // Update the section on section list
//        sections[indexPath.section] = currentSection
        
        // Inform your subject with the new changes
   //     self.data.onNext(sections)
    }
    
    private func createDataSource() {
        
        self.dataSource = RxTableViewSectionedAnimatedDataSource<AnimatesSectionModel>(configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell2", for: indexPath) as! ListTableViewCell
            
            cell.title.text = item.name
            cell.source.text = item.source
            
            DispatchQueue.global(qos: .background).async {
                
                self.netWorkServis.loadImage(str: item.lincImage) { (image) in
                    if let dowdloadImage = image {
                        DispatchQueue.main.async {
                            cell.imageNews.image = dowdloadImage
                        }
                    }
                }
            }
            return cell
            
        })
        
        self.dataSource.canEditRowAtIndexPath = { dataSource, indexPath  in
            return true
        }
    }
    
//    func showNews(serch: String?, country: String?, category: String?, language: String?, indexRequest: Int) {
//        self.router.showListNews(serch: serch, country: country, category: category, language: language, indexRequest: indexRequest)
//    }
    
    func showNews() {
        var search = ""
        switch self.segmentIndex.value {
        case 0:
            search = self.removeUnderline(searchText: self.serhcTextPublicSubject.value)
            print("--------------------\(search)")
        default:
            search = self.removeUnderline(searchText: self.serhc2TextPublicSubject.value)
             print("--------------------\(search)")
        }
        self.router.showListNews(serch: search, country: self.countryTextPublicSubject.value, category: self.categoryTextPublicSubject.value, language: self.languageTextPublicSubject.value, indexRequest: self.segmentIndex.value)
//        print("search \(search)")
//         print("country \(self.countryTextPublicSubject.value)")
//         print("category \(self.categoryTextPublicSubject.value)")
//         print("language \(self.languageTextPublicSubject.value)")
//         print("Index \(self.segmentIndex.value)")
     }
    
    func showFavoritesNews(news: SqlNewsModel) {
        self.router.showWebNews(newStr: news)
    }
    
    func removeUnderline(searchText: String) -> String {
        
        let arrayStr = ["~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "+", "=", "{", "}", "[", "]", "<", ">", "?", ",", ".", "/", "|", ";", ":", "'"]
        
        var escapedSearchText = searchText
        for element in arrayStr {
            escapedSearchText = escapedSearchText.replacingOccurrences(of: element, with: "_")
        }
        return escapedSearchText
    }
    
    //------------------------------------------
    // для swiftEntryKit
    func setupAttributes() -> EKAttributes {
        var attributes = EKAttributes.bottomFloat
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/255.0, alpha: 0.3), dark: UIColor(white: 50.0/255.0, alpha: 0.3)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 1, initialVelocity: 0)),
                                             scale: .init(from: 1.05, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        attributes.positionConstraints.verticalOffset = 10
        attributes.statusBar = .dark
        return attributes
    }
    //---------------------------------------
}
