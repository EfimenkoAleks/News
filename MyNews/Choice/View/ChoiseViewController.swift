//
//  ChoiseViewController.swift
//  MyNews
//
//  Created by mac on 01.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SwiftEntryKit
import RxSwift
import RxCocoa

class ChoiseViewController: UIViewController {
    
    var viewModel: ChoiseViewModelProtocol!
    var myView: CreateView!
    var tableFavorites: CreateTableFavorites!
    let disposBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        ////        self.navigationController?.navigationBar.isTranslucent = true
        //        self.navigationController?.view.backgroundColor = UIColor.clear

//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.tintColor = .systemIndigo
        
        self.addView()
        self.bindUI()
//        self.myView.goButton.addTarget(self, action: #selector(ChoiseViewController.createSearch), for: .touchUpInside)
        navigationItem.rightBarButtonItems = self.createBarItemWaves()
        self.startCreatePopUpFavorites()
        
        NetStatus.shared.status
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { (event) in
                if event == true {
                    print("next element = true")
                    if !NetStatus.shared.isConnected {
                        print("No conected")
                        self.createAlert()
                        NetStatus.shared.stopMonitoring()
                    } else {
                        NetStatus.shared.stopMonitoring()
                    }
                }
            }).disposed(by: self.disposBag)
        
        if !NetStatus.shared.isMonitoring {
            NetStatus.shared.startMonitoring()
    
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.navigationBar.isTranslucent = true

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
               self.navigationController?.navigationBar.shadowImage = UIImage()
               navigationController?.navigationBar.tintColor = .systemIndigo
    }
    
    private func addView() {
        self.myView = CreateView()
        self.myView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myView)
        myView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        myView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func bindUI() {
        self.myView.countryTextField.rx.text.map { $0 ?? "" }.bind(to: self.viewModel.countryTextPublicSubject).disposed(by: self.disposBag)
          self.myView.categoryTextField.rx.text.map { $0 ?? "" }.bind(to: self.viewModel.categoryTextPublicSubject).disposed(by: self.disposBag)
          self.myView.searchTextField.rx.text.map { $0 ?? "" }.bind(to: self.viewModel.serhcTextPublicSubject).disposed(by: self.disposBag)
          self.myView.searchTextField2.rx.text.map { $0 ?? "" }.bind(to: self.viewModel.serhc2TextPublicSubject).disposed(by: self.disposBag)
          self.myView.langvichTextField2.rx.text.map { $0 ?? "" }.bind(to: self.viewModel.languageTextPublicSubject).disposed(by: self.disposBag)
          
          self.viewModel.isValid().bind(to: self.myView.goButton.rx.isEnabled).disposed(by: self.disposBag)
        self.viewModel.isValid().map { $0 ? 1 : 0.1 }.bind(to: self.myView.goButton.rx.alpha).disposed(by: disposBag)
        
        self.myView.segment.rx.value.bind(to: self.viewModel.segmentIndex).disposed(by: self.disposBag)
        self.myView.segment.rx.value.asDriver().drive(onNext: {
            if $0 == 0 {
                print("section000000")
                self.viewModel.serhc2TextPublicSubject.accept("")
                self.viewModel.languageTextPublicSubject.accept("")
            } else {
                print("section11111111")
                self.viewModel.countryTextPublicSubject.accept("")
                self.viewModel.serhcTextPublicSubject.accept("")
                self.viewModel.categoryTextPublicSubject.accept("")
            }
        }).disposed(by: self.disposBag)
        
        self.myView.goButton.rx.tap.asDriver().drive(onNext: {
            self.viewModel.showNews()
        }).disposed(by: self.disposBag)
        
        self.viewModel.isValid().bind(to: self.myView.goButton.rx.isEnabled).disposed(by: self.disposBag)
        self.viewModel.isValid().map { $0 ? 1 : 0.1 }.bind(to: self.myView.goButton.rx.alpha).disposed(by: self.disposBag)
    }
        
    //---------------------------------------------
    //MARK: - bind таблица
    private func bindTable() {
        
         self.tableFavorites.table!.rx.setDelegate(self).disposed(by: self.disposBag)
        
        self.viewModel.getData()
            .bind(to: self.tableFavorites.table!.rx.items(dataSource: self.viewModel.dataSource))
            .disposed(by: self.disposBag)
        
        self.tableFavorites.table!.rx
            .itemSelected
            .map { indexPath in
                return (indexPath, self.viewModel.dataSource[indexPath])
        }
        .subscribe(onNext: { item in
            let curentModelSqlNews = SqlNewsModel(name: (item.1.name), linc: (item.1.linc), lincImage: (item.1.lincImage), source: (item.1.source))
            self.viewModel.showFavoritesNews(news: curentModelSqlNews)
            SwiftEntryKit.dismiss()
        })
            .disposed(by: self.disposBag)
        
        self.tableFavorites.table!.rx.itemDeleted
            .subscribe(onNext: { self.viewModel.removeItem(at: $0) })
            .disposed(by: self.disposBag)
        
        self.navigationItem.rightBarButtonItems?.first?.rx.tap.asDriver().drive(onNext: {
//            self.viewModel.abdateData()
            self.createPopUpFavorites()
        }).disposed(by: self.disposBag)
    }
    //----------------------------------------------
    
    //MARK: - для swiftEntryKit
    
    func startCreatePopUpFavorites() {
        self.tableFavorites = CreateTableFavorites()
//        self.tableFavorites.table?.delegate = self
         self.bindTable()
    }
    
    private func createAlert() {
        SwiftEntryKit.display(entry: AlertView(), using: self.viewModel.setupAttributes())
    }
    
    @objc private func createPopUpFavorites() {
        SwiftEntryKit.display(entry: self.tableFavorites, using: self.viewModel.setupAttributes())
    }
    //-------------------------------------------
    
    //MARK: - barbatonItems
    func createBarItemWaves() -> [UIBarButtonItem] {
//        let scaleConfig = UIImage.SymbolConfiguration(scale: .large)
//        let imageMenu = UIImage(systemName: "dot.radiowaves.left.and.right", withConfiguration: scaleConfig)!
//        let imageTemp = imageMenu.withRenderingMode(.alwaysTemplate)
//        let waves = UIBarButtonItem(image: imageTemp, style: .plain, target: self, action: #selector(ChoiseViewController.createPopUpWawe))
        
        let scaleConfig2 = UIImage.SymbolConfiguration(scale: .large)
        let imageFavorites = UIImage(systemName: "folder", withConfiguration: scaleConfig2)
        let imageTemplate2 = imageFavorites?.withRenderingMode(.alwaysTemplate)
        let favorites = UIBarButtonItem(image: imageTemplate2, style: .plain, target: self, action: #selector(ChoiseViewController.createPopUpFavorites))
        
        return [favorites]
    }
    
}

extension ChoiseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
}
