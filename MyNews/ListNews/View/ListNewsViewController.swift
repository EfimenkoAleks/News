//
//  ListNewsViewController.swift
//  MyNews
//
//  Created by user on 05.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
//import RxDataSources

class ListNewsViewController: UIViewController {
    
    var viewModel: ListNewsViewModelProtocol!
    var table: CreateTable! //view
    let disposBag = DisposeBag()
    var subscribeKey = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        //       navigationItem.rightBarButtonItem = self.createBarItem()

//        let gradient:CAGradientLayer = CAGradientLayer()
//        gradient.frame               = CGRect(x: 0, y: 0, width: 400, height: 50)
//        gradient.colors              = [UIColor.yellow.cgColor, UIColor.white.cgColor]
//        self.navigationController?.navigationBar.layer.insertSublayer(gradient, at: 2)
        
        self.view.backgroundColor = #colorLiteral(red: 0.7919723392, green: 0.9469808936, blue: 0.8765978217, alpha: 1).withAlphaComponent(0.2)
        
        self.addTable()
        self.bindTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.navigationBar.isTranslucent = true
       
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
                 navigationController?.navigationBar.tintColor = .systemIndigo
    }
    
    private func addTable() {
        self.table = CreateTable()
        self.table.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(table)
        table.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.table.table.delegate = self
    }
    
    private func listNews() {
        
    }
    
// MARK: Bind Table
    func bindTable() {
//
//        //       self.table.table.rx.setDelegate(self as UIScrollViewDelegate).disposed(by: disposBag)
//
//// bind таблица 2
//        self.viewModel.data2.bind(to: self.table.table2.rx.items(cellIdentifier: "TableCell2", cellType: ListTableViewCell.self)) {index, item, cell in
//            cell.title.text = item.name
//            cell.source.text = item.source
//
//            DispatchQueue.global(qos: .background).async {
//
//                self.viewModel.netWorkServis.loadImage(str: item.lincImage) { (image) in
//                    if let dowdloadImage = image {
//                        DispatchQueue.main.async {
//                            cell.imageNews.image = dowdloadImage
//                        }
//                    }
//                }
//            }
//
//        }.disposed(by: disposBag)
//
//        self.viewModel.data2.asObservable()
//            .subscribe(onNext: { [weak self] value in
//                self?.table.table2.reloadData()
//            }).disposed(by: disposBag)
//
//        self.table.table2.rx.itemSelected
//                   .subscribe(onNext: { [weak self] indexPath in
//                       //                let cell = self?.table.table.cellForRow(at: indexPath) as? ListTableViewCell
//                    let curentModelSqlNews = SqlNewsModel(id: nil, name: (self?.viewModel.data2.value[indexPath.row].name)!, linc: (self?.viewModel.data2.value[indexPath.row].linc)!, lincImage: (self?.viewModel.data2.value[indexPath.row].lincImage)!, source: (self?.viewModel.data2.value[indexPath.row].source)!)
//                       self?.viewModel.showNews(news: curentModelSqlNews)
//                   }).disposed(by: disposBag)

// bind таблица 1
        self.viewModel.data.bind(to: self.table.table.rx.items(cellIdentifier: "ListCell", cellType: ListTableViewCell.self)) { index, item, cell in
            
            cell.title.text = item.title
 //           print("------- title \(String(describing: item.title))")
            cell.source.text = item.source
            if let url = item.url {
                cell.urlStr = url
            }
            
            if item.urlToImage != nil {
                if self.viewModel.dictBehavior.keys.contains(item.urlToImage!) {
                    self.viewModel.dictBehavior[item.urlToImage!]!.bind(to: cell.imageNews.rx.image).disposed(by: self.disposBag)
                    
                } else {
                    DispatchQueue.global(qos: .background).async {
 //                       print("------- urlToImage \(String(describing: item.urlToImage))")
                        self.viewModel.netWorkServis.loadImage(str: item.urlToImage!) { (image) in
                            if let dowdloadImage = image {
                                DispatchQueue.main.async {
                                    
                                    let imageBehNew = BehaviorSubject(value: dowdloadImage)
                                    self.viewModel.dictBehavior[item.urlToImage!] = imageBehNew
                                    self.viewModel.dictBehavior[item.urlToImage!]!.bind(to: cell.imageNews.rx.image).disposed(by: self.disposBag)
                                }
                            }
                        }
                    }
                }
            }
        }
        .disposed(by: disposBag)
        
        // Определение нажатой item
        self.table.table.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                //                let cell = self?.table.table.cellForRow(at: indexPath) as? ListTableViewCell
                let curentModelSqlNews = SqlNewsModel(name: (self?.viewModel.data.value[indexPath.row].title)!, linc: (self?.viewModel.data.value[indexPath.row].url)!, lincImage: (self?.viewModel.data.value[indexPath.row].urlToImage)!, source: (self?.viewModel.data.value[indexPath.row].source)!)
                self?.viewModel.showNews(news: curentModelSqlNews)
            }).disposed(by: disposBag)
        
        self.viewModel.keyDownload.subscribe { (key) in
            self.subscribeKey = key.element!
        }.disposed(by: disposBag)
    }
    
}
// MARK: TableView delegate
extension ListNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // после какого item    начнётся загрузка следующих item
        if indexPath.row >= (self.viewModel.data.value.count - 5) && self.subscribeKey == true {
            self.viewModel.keyDownload.onNext(false)
            let page = Int(self.viewModel.numberPage)! + 1
            
            self.viewModel.addNextPage(page: page.description)
        }
    }
}
