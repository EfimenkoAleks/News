//
//  CreateWebView.swift
//  MyNews
//
//  Created by mac on 21.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

//import UIKit
//import WebKit
//
//class CreateWebView: UIView, WKUIDelegate {
//    
// //   lazy var webView = createWebView()
//    var webView: WKWebView!
//    var strContent: String!
//    
//    func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        self.webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        self.webView.uiDelegate = self
//        addSubview(webView!)
//        //        self.createWebView()
//    }
//    
//    init(urlStr: String) {
//        super.init(frame: .zero)
//        self.strContent = urlStr
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//       
//        self.loadView()
//        self.createWebView()
//        self.setupInitData()
//        self.backgroundColor = .white
// //       self.webView.backgroundColor = #colorLiteral(red: 0.7919723392, green: 0.9469808936, blue: 0.8765978217, alpha: 1).withAlphaComponent(0.2)
//       
//    }
//    
//    private func setupInitData() {
//        var strForUrl = "https://www.google.com"
//        if let url = self.strContent {
//            strForUrl = url
//        }
//        
//        print("\(strForUrl)")
//        let url = URL(string: strForUrl)
//        let myRequest = URLRequest(url: url!)
//        webView!.load(myRequest)
//        webView!.allowsBackForwardNavigationGestures = true
//    }
//    
//           
//}
