//
//  ExtensionCreateTable.swift
//  MyNews
//
//  Created by mac on 06.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension CreateTable {
    
    func createTable() -> UITableView {
        let tableView = UITableView()
        
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListCell")
//        tableView.refreshControl = UIRefreshControl()
        
        addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        return tableView
    }
    
//    func createBarItemPlus() -> UIBarButtonItem {
//
//        let scaleConfig = UIImage.SymbolConfiguration(scale: .large)
//        let imageMenu = UIImage(systemName: "plus", withConfiguration: scaleConfig)!
//        let imageTemp = imageMenu.withRenderingMode(.alwaysTemplate)
//        let menu = UIBarButtonItem(image: imageTemp, style: .plain, target: self, action: #selector(CollectionView.addItem(_:)))
//        //        navigationItem.rightBarButtonItem = menu
//        return menu
//    }
}
