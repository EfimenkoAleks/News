//
//  ExtensionPopUpView.swift
//  MyNews
//
//  Created by mac on 05.08.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
//import SwiftEntryKit

extension PopUpView {
    
    func createTable() -> UITableView {
        let tableView = UITableView()
        
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PopUpView")
        //        tableView.refreshControl = UIRefreshControl()
        
        addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 255).isActive = true
        
        return tableView
    }
    
    @objc func toggleMonitoring(_ sender: Any) {
        if !NetStatus.shared.isMonitoring {
            NetStatus.shared.startMonitoring()
        } else {
            NetStatus.shared.stopMonitoring()
        }
    }
}

extension PopUpView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section != 1 ? 1 : NetStatus.shared.availableInterfacesTypes?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.nameNetworkWave.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.nameNetworkWave[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopUpView", for: indexPath)
        
        switch indexPath.section {
           case 0:
            cell.textLabel?.text  = NetStatus.shared.isConnected ? "Connected" : "Not Connected"
               cell.imageView?.image = NetStatus.shared.isConnected ? UIImage(named: "checkmark") : UIImage(named: "delete")
        
           case 1:
               if let interfaceType = NetStatus.shared.availableInterfacesTypes?[indexPath.row] {
                   cell.textLabel?.text = "\(interfaceType)"
        
                   if let currentInterfaceType = NetStatus.shared.interfaceType {
                    cell.imageView?.image = (interfaceType == currentInterfaceType) ? UIImage(named: "checkmark") : nil
                   }
               }
        
           case 2:
               cell.textLabel?.text = NetStatus.shared.isExpensive ? "Expensive" : "Not Expensive"
               cell.imageView?.image = NetStatus.shared.isExpensive ? UIImage(named: "warning") : nil
        
           default: ()
           }
        
           return cell
    }
    
    
}
