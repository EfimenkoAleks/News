//
//  AsselberModelBuilder.swift
//  MyNews
//
//  Created by user on 02.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol AsselberBuilderProtocol {
    func createChoiceModule(router: RouterProtocol) -> UIViewController
    func createListNewsModule(serch: String?, country: String?, category: String?, language: String?, indexRequest: Int, router: RouterProtocol) -> UIViewController
    func createWebModule(urlNew: SqlNewsModel, router: RouterProtocol) -> UIViewController
//    func createTableModule(router: RouterProtocol) -> UIViewController
//    func createCollectionModule(router: RouterProtocol) -> UIViewController
//    func createNetWorkTableModule(router: RouterProtocol) -> UIViewController
//     func createDetailModule(comment: Comment?, router: RouterProtocol) -> UIViewController
}

class AsselberModelBuilder: AsselberBuilderProtocol {
    
    func createChoiceModule(router: RouterProtocol) -> UIViewController {
        let view = ChoiseViewController()
        let netWorkServis = NetWorkServisCountrie()
        let viewModel = ChoiceViewModel(router: router, netWorkServis: netWorkServis)
        view.viewModel = viewModel
        return view
    }
    
    func createListNewsModule(serch: String?, country: String?, category: String?, language: String?, indexRequest: Int, router: RouterProtocol) -> UIViewController {
            let view = ListNewsViewController()
            let netWorkServis = NetWorkServisCountrie()
        let viewModel = ListNewsViewModel(serch: serch, country: country, category: category, language: language, indexRequest: indexRequest, router: router, netWorkServis: netWorkServis)
            view.viewModel = viewModel
            return view
        }
    
    func createWebModule(urlNew: SqlNewsModel, router: RouterProtocol) -> UIViewController {
        let view = WebViewController()
 //       let netWorkServis = NetWorkServisLiga()
        let viewModel = WebViewModel(webStr: urlNew, router: router)
        view.viewModel = viewModel
        return view
    }
    
//    func createTableModule(router: RouterProtocol) -> UIViewController {
//        let view = TableViewController()
//        let networkService = NetworkServis()
//        let viewModel = TableViewModel(view: view, networkService: networkService, router: router)
//        view.viewModel = viewModel
//        return view
//    }
    
//    func createCollectionModule(router: RouterProtocol) -> UIViewController {
//        let view = CollectionView()
//        let networkService = NetworkServis()
//        let viewModel = CollectionViewModel(networkService: networkService, router: router)
//        view.viewModel = viewModel
//        return view
//    }
    
//    func createNetWorkTableModule(router: RouterProtocol) -> UIViewController {
//        let view = TableNetworkViewController()
//        let api = APIProvider()
//        let viewModel = NetworkViewModel(api: api, router: router)
//        view.viewModel = viewModel
//        return view
//    }
    
//    func createDetailModule(comment: Comment?, router: RouterProtocol) -> UIViewController {
//        let view = DetailViewController()
//        let networkService = NetworkServis()
//        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, comment: comment)
//        view.presenter = presenter
//        return view
//    }
//
}

