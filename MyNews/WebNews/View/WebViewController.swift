//
//  WebViewController.swift
//  MyNews
//
//  Created by mac on 21.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WebKit
import SQLite

class WebViewController: UIViewController {
    
    var webView: WKWebView! //view
    var viewModel: WebViewModelProtocol!
    let disposBag = DisposeBag()
    var strContent: String?
    var toolBar: UIToolbar?
    
// Устанавливаем размеры view
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView!.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9181602567, green: 0.9342360197, blue: 0.9469808936, alpha: 1)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.createBarItem()
        self.setBgGradientImage()
     
        webView?.navigationDelegate = self
        self.setupInitData(urlStr: self.viewModel.webString)
        //        navigationController?.toolbar.isHidden = false
        self.createToolBar()
        
    }

    //    override func viewDidAppear(_ animated: Bool) {
    //        //1
    //        let navigationBar = self.navigationController?.navigationBar
    //
    //        //2
    //        navigationBar?.barStyle = UIBarStyle.black
    //
    //        //3
    //        navigationBar?.tintColor = UIColor.green
    //
    //        //4
    //        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    //        imageView.contentMode = .scaleAspectFit
    //
    //        // 5
    //        let image = UIImage(named: "news")
    //        imageView.image = image
    //
    //        // 6
    //        navigationItem.titleView = imageView
    //    }
    
// Создаем путь для загрузки страницы
    private func setupInitData(urlStr: String?) {
        var strForUrl = "https://www.google.com"
        if let url = urlStr {
            strForUrl = url
        }
        print("\(strForUrl)")
        let url = URL(string: strForUrl)
        let myRequest = URLRequest(url: url!)
        webView!.load(myRequest)
        webView!.allowsBackForwardNavigationGestures = true
    }
    
//MARK: Create ToolBar
    private func createToolBar() {
        
        //        self.toolBar = UIToolbar()
        //        self.toolBar!.barStyle = .default
        //        self.toolBar!.isTranslucent = true
        //        self.toolBar!.backgroundColor = .white
        //        self.toolBar!.tintColor = #colorLiteral(red: 0.8998303413, green: 0.9318749309, blue: 0.8612433076, alpha: 1).withAlphaComponent(0.1)
        //        self.toolBar!.sizeToFit()
        //
        self.navigationController?.isToolbarHidden = false
//        self.navigationController?.toolbar.backgroundColor = .clear
//        self.navigationController?.toolbar.barTintColor = #colorLiteral(red: 0.9181602567, green: 0.9342360197, blue: 0.9469808936, alpha: 1).withAlphaComponent(0.2)
        self.navigationController?.toolbar.isTranslucent = true
        
//        let img = UIImage(named: "waterBg")
 //       self.navigationController?.toolbar.setBackgroundImage(img, forToolbarPosition: .bottom, barMetrics: .default)
        self.navigationController?.toolbar.tintColor = .systemIndigo
        
        var items = [UIBarButtonItem]()
        
        let scaleConfig = UIImage.SymbolConfiguration(scale: .large)
        let imageback = UIImage(systemName: "chevron.left.2", withConfiguration: scaleConfig)!
        let imageTemp1 = imageback.withRenderingMode(.alwaysTemplate)
        let back = UIBarButtonItem(image: imageTemp1, style: .plain, target: self, action: #selector(WebViewController.backButton))
        
        let imageForvard = UIImage(systemName: "chevron.right.2", withConfiguration: scaleConfig)!
        let imageTemp2 = imageForvard.withRenderingMode(.alwaysTemplate)
        let forvard = UIBarButtonItem(image: imageTemp2, style: .plain, target: self, action: #selector(WebViewController.forvardButton))
        
        let imageReload = UIImage(systemName: "arrow.clockwise", withConfiguration: scaleConfig)!
        let imageTemp3 = imageReload.withRenderingMode(.alwaysTemplate)
        let reload = UIBarButtonItem(image: imageTemp3, style: .plain, target: self, action: #selector(WebViewController.reloadButton))
        
        items.append(back)
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(forvard)
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(reload)
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        //       self.toolbarItems = items
        //        self.navigationController?.toolbar.items = items
        self.toolbarItems = items
    }
    
    @objc func backButton() {
        if webView!.canGoBack {
            webView?.goBack()
        }
    }
    
    @objc func forvardButton() {
        if webView!.canGoForward {
            webView?.goForward()
        }
    }
    
    @objc func reloadButton() {
        webView?.reload()
        print("reload")
    }
    
    // для sqlite ---------------------------------
    @objc private func addToFavoriteNews() {
        // создать новую ссылку
        var newsName = "NameNews"
        var newsImage = ""
        var newsSource = ""
        if let linc = self.viewModel.webString {
            newsName = self.viewModel.webName!
            newsSource = self.viewModel.webSouce!
            newsImage = self.viewModel.webImage!
            
            DataManagerNews.sharedManager.insert(newsName: newsName, linc: linc, newsImage: newsImage, newsSource: newsSource)
        }
        
    }
    //------------------------------------------------------
 // для отправки ссылки кому то
    @objc private func sendNews() {
        
        if let str = self.viewModel.webString {
            let activityVC = UIActivityViewController(activityItems: [str], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }
    }
// MARK: Create BarbuttonItem
    func createBarItem(){
        let scaleConfig = UIImage.SymbolConfiguration(scale: .large)
        let imageMenu = UIImage(systemName: "archivebox", withConfiguration: scaleConfig)!
        let imageTemp = imageMenu.withRenderingMode(.alwaysTemplate)
        let box = UIBarButtonItem(image: imageTemp, style: .plain, target: self, action: #selector(WebViewController.addToFavoriteNews))
        
        let scaleConfig2 = UIImage.SymbolConfiguration(scale: .large)
        let imageSend = UIImage(systemName: "square.and.arrow.up", withConfiguration: scaleConfig2)!
        let imageTemp2 = imageSend.withRenderingMode(.alwaysTemplate)
        let send = UIBarButtonItem(image: imageTemp2, style: .plain, target: self, action: #selector(WebViewController.sendNews))
        
        self.navigationItem.rightBarButtonItems = [send, box]
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
    func setBgGradientImage() {
    if let navigationBar = self.navigationController?.navigationBar {
        let gradient = CAGradientLayer()
        var bounds = navigationBar.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = [UIColor.systemYellow.cgColor, UIColor.systemOrange.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)

        
        if let image = getImageFrom(gradientLayer: gradient) {
            navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        }
    }
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.toolbarItems![0].isEnabled = false
        self.toolbarItems![2].isEnabled = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.canGoBack {
            self.toolbarItems![0].isEnabled = true
        } else if webView.canGoForward {
            self.toolbarItems![2].isEnabled = true
        }
    }
}
