//
//  ExtensionCreateView.swift
//  MyNews
//
//  Created by mac on 01.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import TextFieldEffects

extension CreateView {
    
    func createFonView() -> UIView {
        
        let fonNews: UIImageView = {
            let view = UIImageView()
            view.backgroundColor = .white
            view.image = UIImage(named: "fonNews")
            view.layer.cornerRadius = 6
            view.layer.masksToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        addSubview(fonNews)
        fonNews.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        fonNews.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        fonNews.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fonNews.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        fonNews.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        
        addSubview(goButton)
        goButton.bottomAnchor.constraint(equalTo: fonNews.bottomAnchor, constant: -self.frame.height / 8).isActive = true
        goButton.centerXAnchor.constraint(equalTo: fonNews.centerXAnchor).isActive = true
        goButton.widthAnchor.constraint(equalToConstant: self.frame.width - self.frame.width / 4).isActive = true
        goButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return fonNews
    }
    
    func createView() -> UIView {
        
        let generalView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            view.layer.cornerRadius = 6
            view.layer.masksToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        //        let countryLabel: UILabel = {
        //            let lb = UILabel()
        //            //        tv.isEditable = false
        //            lb.font = UIFont.systemFont(ofSize: 16)
        //            lb.textAlignment = .center
        //            lb.textColor = .black
        //            lb.text = "Select a country?"
        //            lb.layer.borderWidth = 1
        //            lb.layer.cornerRadius = 8
        //            lb.backgroundColor = .red
        //            lb.layer.masksToBounds = true
        //            lb.translatesAutoresizingMaskIntoConstraints = false
        //            return lb
        //        }()
        
        //        let categoryLabel: UILabel = {
        //            let lb = UILabel()
        //            //        tv.isEditable = false
        //            lb.font = UIFont.systemFont(ofSize: 16)
        //            lb.textAlignment = .center
        //            lb.textColor = .black
        //            lb.text = "Select a category?"
        //            lb.layer.borderWidth = 1
        //            lb.layer.cornerRadius = 8
        //            lb.backgroundColor = .green
        //            lb.layer.masksToBounds = true
        //            lb.translatesAutoresizingMaskIntoConstraints = false
        //            return lb
        //        }()
        
        //        let searchLabel: UILabel = {
        //            let lb = UILabel()
        //            //        tv.isEditable = false
        //            lb.font = UIFont.systemFont(ofSize: 16)
        //            lb.textAlignment = .center
        //            lb.textColor = .black
        //            lb.text = "Keyword?"
        //            lb.layer.borderWidth = 1
        //            lb.layer.cornerRadius = 8
        //            lb.backgroundColor = .green
        //            lb.layer.masksToBounds = true
        //            lb.translatesAutoresizingMaskIntoConstraints = false
        //            return lb
        //        }()
        
        addSubview(generalView)
        
        generalView.topAnchor.constraint(equalTo: self.segment.bottomAnchor, constant: 8).isActive = true
 //       generalView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        generalView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        generalView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        generalView.heightAnchor.constraint(equalToConstant: self.frame.height / 2).isActive = true
        
        generalView.addSubview(searchTextField)
        generalView.addSubview(countryTextField)
        generalView.addSubview(categoryTextField)
//        generalView.addSubview(goButton)
        
        searchTextField.topAnchor.constraint(equalTo: generalView.topAnchor, constant: 30).isActive = true
        searchTextField.centerXAnchor.constraint(equalTo: generalView.centerXAnchor).isActive = true
        searchTextField.widthAnchor.constraint(equalToConstant: self.frame.width - self.frame.width / 3).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        countryTextField.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 50).isActive = true
        countryTextField.centerXAnchor.constraint(equalTo: generalView.centerXAnchor).isActive = true
        countryTextField.widthAnchor.constraint(equalToConstant: self.frame.width - self.frame.width / 3).isActive = true
        countryTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        categoryTextField.topAnchor.constraint(equalTo: countryTextField.bottomAnchor, constant: 50).isActive = true
        categoryTextField.centerXAnchor.constraint(equalTo: generalView.centerXAnchor).isActive = true
        categoryTextField.widthAnchor.constraint(equalToConstant: self.frame.width - self.frame.width / 3).isActive = true
        categoryTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        searchTextField.placeholder = NSLocalizedString("Search", comment: "search")
        categoryTextField.placeholder = NSLocalizedString("Category", comment: "category")
        countryTextField.placeholder = NSLocalizedString("Country", comment: "country")
        
        return generalView
    }
    
    func createView2() -> UIView {
        
        let generalView2: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            view.layer.cornerRadius = 6
            view.layer.masksToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        addSubview(generalView2)
        
        generalView2.topAnchor.constraint(equalTo: self.segment.bottomAnchor, constant: 8).isActive = true
        generalView2.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        generalView2.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        generalView2.heightAnchor.constraint(equalToConstant: self.frame.height / 2).isActive = true
        
        generalView2.addSubview(searchTextField2)
        generalView2.addSubview(langvichTextField2)
 //       generalView2.addSubview(goButton)
        
        searchTextField2.topAnchor.constraint(equalTo: generalView2.topAnchor, constant: 30).isActive = true
        searchTextField2.centerXAnchor.constraint(equalTo: generalView2.centerXAnchor).isActive = true
        searchTextField2.widthAnchor.constraint(equalToConstant: self.frame.width - self.frame.width / 3).isActive = true
        searchTextField2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        langvichTextField2.topAnchor.constraint(equalTo: searchTextField2.bottomAnchor, constant: 50).isActive = true
        langvichTextField2.centerXAnchor.constraint(equalTo: generalView2.centerXAnchor).isActive = true
        langvichTextField2.widthAnchor.constraint(equalToConstant: self.frame.width - self.frame.width / 3).isActive = true
        langvichTextField2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return generalView2
    }
}

extension CreateView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerMasiv!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerMasiv![row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch index {
        case 1:
            self.countryTextField.text = self.pickerMasiv![row]
        case 2:
            self.langvichTextField2.text = self.pickerMasiv![row]
        default:
            self.categoryTextField.text = self.pickerMasiv![row]
        }
        endEditing(true) // чтоб спрятать piker
        
    }
}
