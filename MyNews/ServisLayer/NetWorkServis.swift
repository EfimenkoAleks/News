//
//  NetWorkServis.swift
//  MyNews
//
//  Created by user on 02.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
//import SDWebImage

protocol NetworkServisProtocol {
    func getNews(serch: String?, country: String?, category: String?, language: String?, indexRequest: Int, page: String?, completion: @escaping (ListNews) -> Void)
    func loadImage(str: String, completion: @escaping (UIImage?) -> Void)
}

class NetWorkServisCountrie: NetworkServisProtocol {
    
    var imageCache = NSCache<NSString, UIImage>()
    
    func getNews(serch: String?, country: String?, category: String?, language: String?, indexRequest: Int, page: String?, completion: @escaping (ListNews) -> Void) {
        switch indexRequest {
        case 0:
            self.getData3Object(serch: serch, country: country, category: category, page: page) { (data) in
                
                guard let dataRez = data else { return }
                var parsedResult: ListNews = try! JSONDecoder().decode(ListNews.self, from: dataRez)
                
                for new in 0..<parsedResult.articles.count {
                    let symbol = "s"
                    let pref = parsedResult.articles[new].url?.prefix(7)
                    var mySource = ""
                    if (pref?.contains(symbol))! {
                        let newNew1 = parsedResult.articles[new].url!.dropFirst(8)
                        for iChar in newNew1 {
                            if iChar == "/" {
                                break
                            }
                            mySource += String(iChar)
                        }
                    } else {
                        let newNew2 = parsedResult.articles[new].url!.dropFirst(7)
                        for iChar in newNew2 {
                            if iChar == "/" {
                                break
                            }
                            mySource += String(iChar)
                        }
                    }
                    parsedResult.articles[new].source = mySource
                }
                
                completion(parsedResult)
            }
        default:
            self.getData2Object(serch: serch, language: language, page: page){ (data) in
                guard let dataRez = data else { return }
                var parsedResult: ListNews = try! JSONDecoder().decode(ListNews.self, from: dataRez)
                
                for new in 0..<parsedResult.articles.count {
                    let symbol = "s"
                    let pref = parsedResult.articles[new].url?.prefix(7)
                    var mySource = ""
                    if (pref?.contains(symbol))! {
                        let newNew1 = parsedResult.articles[new].url!.dropFirst(8)
                        for iChar in newNew1 {
                            if iChar == "/" {
                                break
                            }
                            mySource += String(iChar)
                        }
                    } else {
                        let newNew2 = parsedResult.articles[new].url!.dropFirst(7)
                        for iChar in newNew2 {
                            if iChar == "/" {
                                break
                            }
                            mySource += String(iChar)
                        }
                    }
                    parsedResult.articles[new].source = mySource
                }
                
                completion(parsedResult)
            }
            
        }
        
    }
    
    private func getData3Object(serch: String?, country: String?, category: String?, page: String?, completion: @escaping (Data?) -> Void) {
        
        var serchCurent = ""
        var countryCurent = ""
        var categoryCurent = ""
        var pageCurent = ""
        
        //        let headers = [
        //            "X-Api-Key": "bb1d32ccf2014a76b1d889b5e8371e75"
        //        ]
        let apiKey = "apiKey=bb1d32ccf2014a76b1d889b5e8371e75"
        
        if serch != "" || country != "" || category != "" {
            if let co = country, co.count > 1 {
                countryCurent = "country=" + co + "&"
            }
            
            if let q = serch, q.count > 1 {
                serchCurent = "q=" + q + "&"
            }
            
            if let ca = category, ca.count > 1 {
                categoryCurent = "category=" + ca + "&"
            }
            
        } else {
            countryCurent = "country=" + "ua" + "&"
        }
        
        if let pa = page {
            pageCurent = "page=" + pa + "&"
        }
        print("countryCurent \(countryCurent)")
        print("serchCurent \(serchCurent)")
        print("categoryCurent \(categoryCurent)")
        let request = NSMutableURLRequest(url: NSURL(string: "https://newsapi.org/v2/top-headlines?" + serchCurent + countryCurent + categoryCurent + pageCurent + apiKey)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        //        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, _, error) -> Void in
            if (error != nil) {
                print(error ?? "error")
            } else {
                completion(data)
            }
        })
        
        dataTask.resume()
    }
    
    private func getData2Object(serch: String?, language: String?, page: String?, completion: @escaping (Data?) -> Void) {
        
        var serchCurent = ""
        var languageCurent = ""
        var pageCurent = ""
        
        //        let headers = [
        //            "X-Api-Key": "bb1d32ccf2014a76b1d889b5e8371e75"
        //        ]
        let apiKey = "apiKey=bb1d32ccf2014a76b1d889b5e8371e75"
        
        if let q = serch, q.count > 1, let lan = language, lan.count > 1 {
           
            languageCurent = "language=" + lan + "&"
            serchCurent = "q=" + q + "&"
        } else {
            serchCurent = "q=apple" + "&" + "language=ru" + "&"
        }
        
        if let pa = page {
            pageCurent = "page=" + pa + "&"
        }
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://newsapi.org/v2/everything?" + serchCurent + languageCurent + pageCurent + apiKey)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        //        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, _, error) -> Void in
            if (error != nil) {
                print(error ?? "error")
            } else {
                completion(data)
            }
        })
        
        dataTask.resume()
    }
    
    //    func loadImage(str: String, completion: @escaping (UIImage?) -> Void) {
    //
    //        let myImage = UIImageView()
    //        let url = URL(string: str)
    //        myImage.sd_setImage(with: url) { (image, error, _, _) in
    //            if error == nil {
    //                completion(image!)
    //            }
    //        }
    ////        myImage.sd_setImage(with: url, placeholderImage: UIImage(named: "picture"), options: [.continueInBackground, .progressiveLoad], completed: nil)
    ////        if myImage.image != nil {
    ////            completion(myImage.image!)
    ////        } else {
    //// //           completion(UIImage(named: "picture")!)
    ////        }
    //    }
    
    func loadImage(str: String, completion: @escaping (UIImage?) -> Void) {
        let rezervUrl = "https://www.apple.com/"
        
        let request = NSMutableURLRequest(url: (URL(string: str) ?? URL(string: rezervUrl))!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let data = data{
                if let imgageFromData = UIImage(data: data) {
                    completion(imgageFromData)
                }
            } else {
                print(error ?? "error")
            }
        })
        
        dataTask.resume()
        
    }
    
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
