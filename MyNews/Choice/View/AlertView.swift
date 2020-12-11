//
//  AlertView.swift
//  MyNews
//
//  Created by user on 19.10.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    let okButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Ok", for: .normal)
        btn.setTitleColor(.systemIndigo, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 17)
        // btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 1)
        btn.layer.shadowRadius = 1
        //btn.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        //btn.layer.shouldRasterize = true
        btn.addTarget(self, action: #selector(AlertView.ok(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.9187057018, green: 1, blue: 0.9847425818, alpha: 1)
        return btn
    }()
    
    let cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(.systemIndigo, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 17)
        // btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 1)
        btn.layer.shadowRadius = 1
        //btn.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        //btn.layer.shouldRasterize = true
        btn.addTarget(self, action: #selector(AlertView.cancel(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.9187057018, green: 1, blue: 0.9847425818, alpha: 1)
        return btn
    }()
    
    let nameLabel: UILabel = {
           let lb = UILabel()
           lb.textAlignment = .center
           lb.font = UIFont.systemFont(ofSize: 20)
           lb.backgroundColor = .clear
           lb.layer.cornerRadius = 10
           lb.layer.masksToBounds = true
           lb.numberOfLines = 1
        lb.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(0.3)
           lb.translatesAutoresizingMaskIntoConstraints = false
           return lb
       }()
    
    let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 17)
        lb.backgroundColor = .clear
        lb.layer.cornerRadius = 10
        lb.layer.masksToBounds = true
        lb.numberOfLines = 0
        lb.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(0.3)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
//       var descriptionLabel: UIView = {
//           let view = UIView()
//           view.backgroundColor = .clear
//           view.layer.cornerRadius = 8
//           view.layer.masksToBounds = true
//           view.translatesAutoresizingMaskIntoConstraints = false
//           return view
//       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.9748304486, green: 0.942463994, blue: 0.9257830977, alpha: 1).withAlphaComponent(0.7)
        self.createElement()
        heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.layer.cornerRadius = 20
        self.nameLabel.text = "No conected"
        self.descriptionLabel.text = "Please turn on the internet"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
