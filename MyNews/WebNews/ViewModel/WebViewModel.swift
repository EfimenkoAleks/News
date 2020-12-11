//
//  WebViewModel.swift
//  MyNews
//
//  Created by mac on 21.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SDWebImage

protocol WebViewModelProtocol: class {
    var router: RouterProtocol { get set}
//    var netWorkServis: NetWorkServisCountrie { get }
    var webString: String? { get set }
    var webName: String? { get set }
    var webSouce: String? { get set }
    var webImage: String? { get set }
//    var dictBehavior: [String: BehaviorSubject<UIImage>] { get set}
//    var data: BehaviorRelay<[New]> { get set}
    init(webStr: SqlNewsModel?, router: RouterProtocol)
//    func showNews(news: String)
}

class WebViewModel: WebViewModelProtocol {
    
    var router: RouterProtocol
//    var dictBehavior: [String: BehaviorSubject<UIImage>]
//    var data: BehaviorRelay<[New]>
//    var netWorkServis: NetWorkServisCountrie
    let disposBag = DisposeBag()
    var webString: String?
    var webName: String?
    var webSouce: String?
    var webImage: String?
     
    required init(webStr: SqlNewsModel?, router: RouterProtocol) {
        
        self.router = router
        self.webString = webStr?.linc
        self.webName = webStr?.name
        self.webImage = webStr?.lincImage
        self.webSouce = webStr?.source
    }
    
//    func showNews(news: String) {
//   //     self.router.showLeague(country: country)
//       }
//
    

}
