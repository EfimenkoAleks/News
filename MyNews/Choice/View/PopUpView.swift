//
//  PopUpView.swift
//  MyNews
//
//  Created by mac on 05.08.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class PopUpView: UIView {
    
    var table: UITableView?
    var nameNetworkWave: [String]
    
    let monitorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Scan waves", for: .normal)
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
        btn.addTarget(self, action: #selector(PopUpView.toggleMonitoring(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.7919723392, green: 0.9469808936, blue: 0.8765978217, alpha: 1)
        return btn
    }()
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.table = createTable()
//        self.setupButton()
//        self.table?.isHidden = false
//        self.backgroundColor = #colorLiteral(red: 0.9181602567, green: 0.9342360197, blue: 0.9469808936, alpha: 1)
//        self.table?.backgroundColor = #colorLiteral(red: 0.9181602567, green: 0.9342360197, blue: 0.9469808936, alpha: 1)
//
//
//        NetStatus.shared.didStopMonitoringHandler = { [unowned self] in
//               self.monitorButton.setTitle("Start Monitoring", for: .normal)
//            self.table?.reloadData()
//           }
//
//        NetStatus.shared.netStatusChangeHandler = {
//            DispatchQueue.main.async { [unowned self] in
//                self.table?.reloadData()
//            }
//        }
//    }
    
    override init(frame: CGRect) {
        self.nameNetworkWave = ["Connected", "Interface Type", "Is Expensive"]
        super.init(frame: frame)
        
        self.table = createTable()
        self.setupButton()
        self.table?.isHidden = false
        backgroundColor = #colorLiteral(red: 1, green: 0.9610562194, blue: 0.9553709397, alpha: 1)
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        self.table?.backgroundColor = #colorLiteral(red: 1, green: 0.9610562194, blue: 0.9553709397, alpha: 1)
//        #colorLiteral(red: 1, green: 0.8782011004, blue: 0.904574452, alpha: 1)
        self.table?.dataSource = self
        self.layer.cornerRadius = 15
        self.table?.layer.cornerRadius = 15
        
        NetStatus.shared.didStartMonitoringHandler = { [unowned self] in
            self.monitorButton.setTitle("Stop Monitoring", for: .normal)
        }
        
        NetStatus.shared.didStopMonitoringHandler = { [unowned self] in
               self.monitorButton.setTitle("Start Monitoring", for: .normal)
            self.table?.reloadData()
           }

        NetStatus.shared.netStatusChangeHandler = {
            DispatchQueue.main.async { [unowned self] in
                self.table?.reloadData()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        addSubview(monitorButton)
        monitorButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        monitorButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        monitorButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        monitorButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
}
