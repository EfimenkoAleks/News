//
//  ExtensionCreateTableFavorites.swift
//  MyNews
//
//  Created by mac on 03.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension CreateTableFavorites {
    
    func createTable() -> UITableView {
        let tableView = UITableView()
        
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "TableCell2")
        //        tableView.refreshControl = UIRefreshControl()
        
        addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        return tableView
    }
}


