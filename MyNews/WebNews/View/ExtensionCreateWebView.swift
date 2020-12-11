//
//  ExtensionCreateWebView.swift
//  MyNews
//
//  Created by mac on 21.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

//import UIKit
//import WebKit
//
//extension CreateWebView {
//
//    func createWebView() {
//
//  //      var webView = WKWebView()
//        //            var strContent: String?
//
//        //            init(text: String) {
//        //                super.init(nibName: nil, bundle: nil)
//        //                self.strContent = text
//        //            }
//        //
//        //            required init?(coder: NSCoder) {
//        //                fatalError("init(coder:) has not been implemented")
//        //            }
//
//        //        func loadView() {
//        //                let webConfiguration = WKWebViewConfiguration()
//        //                webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        // //               webView!.navigationDelegate = self
//        //     //       addSubview(webView!)
//        //        //        self.createWebView()
//        //            }
//
//        //            override func viewDidLoad() {
//        //                super.viewDidLoad()
//        //
//        //                webView?.navigationDelegate = self
//        //                self.setupBgColor()
//        //                self.setupInitData()
//        //                self.createToolBar()
//        //        //        tabBarController?.tabBar.tabsVisiblti(false)
//        //        //        tabBarController?.setTabBarVisible(visible: false, animated: true)
//        //         //       self.toolBarHeight(visible: false, animated: true)
//        //            }
//
//
//
//        //            private func setupInitData() {
//        //                var strForUrl = "https://www.google.com"
//        //                if let url = self.strContent {
//        //                    strForUrl = url
//        //                }
//        //
//        //                print("\(strForUrl)")
//        //                let url = URL(string: strForUrl)
//        //                let myRequest = URLRequest(url: url!)
//        //                webView!.load(myRequest)
//        //                webView!.allowsBackForwardNavigationGestures = true
//        //            }
//
//        //            func removeUnderline(searchText: String) -> String {
//        //                let escapedSearchText = searchText.replacingOccurrences(of: " ", with: "_")
//        //                return escapedSearchText
//        //            }
//
////        let webConfiguration = WKWebViewConfiguration()
////        let myWebView = WKWebView(frame: .zero, configuration: webConfiguration)
//
//     //   addSubview(myWebView)
//        self.webView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        self.webView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        self.webView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        self.webView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//
//
//    }
//
//    func createToolBar(navigationController: UINavigationController) {
//
//        navigationController.isToolbarHidden = false
//        navigationController.toolbar.backgroundColor = .clear
//        navigationController.toolbar.barTintColor = .systemTeal
//        var items = [UIBarButtonItem]()
//
//        let scaleConfig = UIImage.SymbolConfiguration(scale: .large)
//        let imageback = UIImage(systemName: "chevron.left.2", withConfiguration: scaleConfig)!
//        let imageTemp1 = imageback.withRenderingMode(.alwaysTemplate)
//        let back = UIBarButtonItem(image: imageTemp1, style: .plain, target: self, action: #selector(CreateWebView.backButton))
//
//        let imageForvard = UIImage(systemName: "chevron.right.2", withConfiguration: scaleConfig)!
//        let imageTemp2 = imageForvard.withRenderingMode(.alwaysTemplate)
//        let forvard = UIBarButtonItem(image: imageTemp2, style: .plain, target: self, action: #selector(CreateWebView.forvardButton))
//
//        let imageReload = UIImage(systemName: "arrow.clockwise", withConfiguration: scaleConfig)!
//        let imageTemp3 = imageReload.withRenderingMode(.alwaysTemplate)
//        let reload = UIBarButtonItem(image: imageTemp3, style: .plain, target: self, action: #selector(CreateWebView.forvardButton))
//
//        items.append(back)
//        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
//        items.append(forvard)
//        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
//        items.append(reload)
//        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
//        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
//        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
//        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
//        navigationController.toolbarItems = items
//
//    }
//
//    @objc func backButton() {
//        if webView.canGoBack {
//            webView.goBack()
//        }
//    }
//
//    @objc func forvardButton() {
//        if webView.canGoForward {
//            webView.goForward()
//        }
//    }
//
//    @objc func reloadButton() {
//        webView.reload()
//    }
//}
//
////extension CreateWebView: WKNavigationDelegate {
////
////    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
////        self.toolbarItems![0].isEnabled = false
////        self.toolbarItems![2].isEnabled = false
////    }
////
////    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
////        if webView.canGoBack {
////            self.toolbarItems![0].isEnabled = true
////        } else if webView.canGoForward {
////            self.toolbarItems![2].isEnabled = true
////        }
////    }
////
////}
//
