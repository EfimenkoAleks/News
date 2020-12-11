//
//  CreateTable.swift
//  MyNews
//
//  Created by mac on 06.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class CreateTable: UIView {
    
    lazy var table = createTable()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.table.isHidden = false
        self.backgroundColor = #colorLiteral(red: 0.9181602567, green: 0.9342360197, blue: 0.9469808936, alpha: 1)
        self.table.backgroundColor = #colorLiteral(red: 0.9181602567, green: 0.9342360197, blue: 0.9469808936, alpha: 1)
     
        self.table.backgroundColor = .clear
      
    }
}
