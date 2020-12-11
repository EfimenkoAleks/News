//
//  Router.swift
//  MyNews
//
//  Created by user on 02.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AsselberBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showListNews(serch: String?, country: String?, category: String?, language: String?, indexRequest: Int)
    func showWebNews(newStr: SqlNewsModel)
//    func showDetail(comment: Comment?)
//    func showLeague(country: String)
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AsselberBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AsselberBuilderProtocol){
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let choiseViewController = assemblyBuilder?.createChoiceModule(router: self) else { return }
            navigationController.viewControllers = [choiseViewController]
        }
    }
    
    func showListNews(serch: String?, country: String?, category: String?, language: String?, indexRequest: Int) {
            if let navigationController = navigationController {
                guard let leagueViewController = assemblyBuilder?.createListNewsModule(serch: serch, country: country, category: category, language: language, indexRequest: indexRequest, router: self) else { return }
                navigationController.pushViewController(leagueViewController, animated: true)
            }
        }
    
        func showWebNews(newStr: SqlNewsModel) {
            if let navigationController = navigationController {
                guard let webViewController = assemblyBuilder?.createWebModule(urlNew: newStr, router: self) else { return }
                navigationController.pushViewController(webViewController, animated: true)
            }
        }
    
//    func showLeague(country: String) {
//        if let navigationController = navigationController {
//            guard let leagueViewController = assemblyBuilder?.createLeagueModule(country: country, router: self) else { return }
//            navigationController.pushViewController(leagueViewController, animated: true)
//        }
//    }
    
//    func showDetail(comment: Comment?) {
//        if let navigationController = navigationController {
//            guard let detailViewController = assemblyBuilder?.createDetailModule(comment: comment, router: self) else { return }
//            navigationController.pushViewController(detailViewController, animated: true)
//        }
//    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    
    
}
