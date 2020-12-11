//
//  CreateTableFavorites.swift
//  MyNews
//
//  Created by mac on 03.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class CreateTableFavorites: UIView {
    
    var table: UITableView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.table = createTable()
        self.table?.isHidden = false
        backgroundColor = #colorLiteral(red: 1, green: 0.9610562194, blue: 0.9553709397, alpha: 1)
        heightAnchor.constraint(equalToConstant: 400).isActive = true
        self.table?.backgroundColor = #colorLiteral(red: 1, green: 0.9610562194, blue: 0.9553709397, alpha: 1)
        self.layer.cornerRadius = 15
        self.table?.layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    }
}

