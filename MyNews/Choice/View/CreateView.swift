//
//  CreateView.swift
//  MyNews
//
//  Created by mac on 01.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import TextFieldEffects
import RxSwift
import RxCocoa

class CreateView: UIView {
    
    lazy var fonView = createFonView()
    
    var segment: UISegmentedControl = {
        let items = ["Запрос 1", "Запрос 2"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        
        // Set up Frame and SegmentedControl
        let frame = UIScreen.main.bounds
        customSC.frame = CGRect(x: frame.minX + 10, y: frame.minY + 100,
                                width: frame.width - 20, height: frame.height*0.05)
        
        // Style the Segmented Control
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        customSC.tintColor = .brown
        customSC.selectedSegmentTintColor = #colorLiteral(red: 0.9608978426, green: 0.912968934, blue: 0.8459051666, alpha: 1)
        customSC.layer.borderWidth = 1
        
        // Add target action method
        customSC.addTarget(self, action: #selector(CreateView.forSegment), for: .valueChanged)
        return customSC
    }()
    
    var requestView: UIView!
    var requestView2: UIView!
    
    // Запрос 1 --------------------
    
    let countryTextField: HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholderColor = .black
        tf.borderActiveColor = .systemBlue
        tf.borderInactiveColor = .systemBlue
        tf.placeholder = "Country"
        tf.font = UIFont(name: "CourierNewPS-BoldMT", size: 17)
        tf.placeholderFontScale = 1.2
        tf.addTarget(self, action: #selector(CreateView.forCountryPickerViewInstal), for: .allEvents)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let categoryTextField: HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholderColor = .black
        tf.borderActiveColor = .systemBlue
        tf.borderInactiveColor = .systemBlue
        tf.placeholder = "Category"
        tf.font = UIFont(name: "CourierNewPS-BoldMT", size: 17)
        tf.placeholderFontScale = 1.2
        tf.addTarget(self, action: #selector(CreateView.forCategoryPickerViewInstal), for: .allEvents)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let searchTextField: HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholderColor = .black
        tf.borderActiveColor = .systemBlue
        tf.borderInactiveColor = .systemBlue
        tf.placeholder = "Search"
        tf.font = UIFont(name: "CourierNewPS-BoldMT", size: 17)
        tf.placeholderFontScale = 1.2
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // Запрос 2 ---------------------
    
    let searchTextField2: HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholderColor = .black
        tf.borderActiveColor = .systemBlue
        tf.borderInactiveColor = .systemBlue
        tf.placeholder = "Search"
        tf.font = UIFont(name: "CourierNewPS-BoldMT", size: 17)
        tf.placeholderFontScale = 1.2
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let langvichTextField2: HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholderColor = .black
        tf.borderActiveColor = .systemBlue
        tf.borderInactiveColor = .systemBlue
        tf.placeholder = "Language"
        tf.font = UIFont(name: "CourierNewPS-BoldMT", size: 17)
        tf.placeholderFontScale = 1.2
        tf.addTarget(self, action: #selector(CreateView.forLangvichPickerView), for: .allEvents)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //-------------------------
    
    //   let countryTextField: UITextField = {
    //       let tf = UITextField()
    //       tf.textAlignment = .center
    //       tf.placeholder = "Country"
    //       tf.layer.borderWidth = 1
    //       tf.layer.cornerRadius = 8
    //       tf.backgroundColor = .red
    //    tf.addTarget(self, action: #selector(CreateView.forCountryPickerViewInstal), for: .allEvents)
    //       tf.translatesAutoresizingMaskIntoConstraints = false
    //       return tf
    //   }()
    
    let goButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Go news", for: .normal)
        btn.setTitleColor(.systemIndigo, for: .normal)
        btn.titleLabel?.font = UIFont(name: "CourierNewPS-BoldMT", size: 22)
        // btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 40
        btn.layer.borderWidth = 1
        
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 1)
        btn.layer.shadowRadius = 1
        
        //btn.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        //btn.layer.shouldRasterize = true
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.9608978426, green: 0.912968934, blue: 0.8459051666, alpha: 1)
        return btn
    }()
    
    private var stringPicker: UIPickerView?
    var pickerMasiv: [String]?
    var index = 0
    var indexForSegment = 1
    
//    let countryTextPublicSubject = PublishSubject<String>()
//    let categoryTextPublicSubject = PublishSubject<String>()
//    let serhcTextPublicSubject = PublishSubject<String>()
//    let serhc2TextPublicSubject = PublishSubject<String>()
//    let languageTextPublicSubject = PublishSubject<String>()
//    let disposBag = DisposeBag()
//    
//    func isValid() -> Observable<Bool> {
//        return Observable.combineLatest(self.countryTextPublicSubject.asObservable().startWith(""), self.categoryTextPublicSubject.asObservable().startWith(""), self.serhcTextPublicSubject.asObservable().startWith(""), self.serhc2TextPublicSubject.asObservable().startWith(""), self.languageTextPublicSubject.asObservable().startWith("")).map { country, category, serhc, serhc2, language in
//            return country.count > 1 || category.count > 1 || serhc.count >= 1 || serhc2.count >= 1 || language.count > 1
//        }.startWith(false)
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .white
        self.fonView.backgroundColor = #colorLiteral(red: 0.7919723392, green: 0.9469808936, blue: 0.8765978217, alpha: 1).withAlphaComponent(0.2)
        addSubview(segment)
        self.requestView = self.createView()
        self.requestView.backgroundColor = .clear
        self.requestView2 = self.createView2()
        self.requestView2.backgroundColor = .clear
        self.requestView2.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        addGestureRecognizer(tap)
        
//        searchTextField.text = nil
//        categoryTextField.text = nil
//        countryTextField.text = nil
        
        goButton.setTitle(NSLocalizedString("Go news", comment: "go news button"), for: .normal)
        
    }
    
//    private func bindUI() {
//        self.countryTextField.rx.text.map { $0 ?? "" }.bind(to: countryTextPublicSubject).disposed(by: self.disposBag)
//        self.categoryTextField.rx.text.map { $0 ?? "" }.bind(to: categoryTextPublicSubject).disposed(by: self.disposBag)
//        self.searchTextField.rx.text.map { $0 ?? "" }.bind(to: serhcTextPublicSubject).disposed(by: self.disposBag)
//        self.searchTextField2.rx.text.map { $0 ?? "" }.bind(to: serhc2TextPublicSubject).disposed(by: self.disposBag)
//        self.langvichTextField2.rx.text.map { $0 ?? "" }.bind(to: languageTextPublicSubject).disposed(by: self.disposBag)
//
//        self.isValid().bind(to: self.goButton.rx.isEnabled).disposed(by: self.disposBag)
//        self.isValid().map { $0 ? 1 : 0.1 }.bind(to: goButton.rx.alpha).disposed(by: disposBag)
//    }
    
    @objc private func forSegment(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.requestView2.isHidden = true
            self.requestView.isHidden = false
            self.indexForSegment = 1
            self.searchTextField2.text = ""
            self.langvichTextField2.text = ""
        default:
            self.requestView.isHidden = true
            self.requestView2.isHidden = false
            self.indexForSegment = 2
            self.categoryTextField.text = ""
            self.countryTextField.text = ""
            self.searchTextField.text = ""
        }
    }
    
    @objc func forCountryPickerViewInstal() {
        self.pickerMasiv = ["ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph", "pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua", "us", "ve", "za"]
        self.stringPicker = UIPickerView()
        self.stringPicker?.dataSource = self
        self.stringPicker?.delegate = self
        self.stringPicker?.contentMode = .center
        self.countryTextField.inputView = stringPicker
        self.index = 1
        
    }
    
    @objc func forCategoryPickerViewInstal() {
        self.pickerMasiv = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
        self.stringPicker = UIPickerView()
        self.stringPicker?.dataSource = self
        self.stringPicker?.delegate = self
        self.stringPicker?.contentMode = .center
        self.categoryTextField.inputView = stringPicker
        self.index = 0
        
    }
    
    @objc func forLangvichPickerView() {
        self.pickerMasiv = ["ar","de", "en", "es", "fr", "he", "it", "nl", "no", "pt", "ru", "se", "ud", "zh"]
        self.stringPicker = UIPickerView()
        self.stringPicker?.dataSource = self
        self.stringPicker?.delegate = self
        self.stringPicker?.contentMode = .center
        self.langvichTextField2.inputView = stringPicker
        self.index = 2
        
    }
}

