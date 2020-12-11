//
//  ListTableViewCell.swift
//  MyNews
//
//  Created by mac on 06.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    var urlStr = ""
 
        let title: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 16)
            lb.text = "Title"
        lb.textAlignment = .left
            lb.numberOfLines = 0
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let source: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.text = "Source"
        lb.textAlignment = .left
        lb.textColor = .darkGray
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    var imageNews: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "news")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.7
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemFill
        return imageView
    }()
   
//            let bubbleView: UIView = {
//                let view = UIView()
//                view.backgroundColor = .clear
//                view.layer.cornerRadius = 6
//                view.layer.masksToBounds = true
//                view.translatesAutoresizingMaskIntoConstraints = false
//                return view
//            }()
            
            override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
               
                self.setupConstraints()
            }
            
            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
//            override var frame: CGRect {
//                get {
//                    return super.frame
//                }
//                set (newFrame) {
//                    var frame =  newFrame
//                    frame.origin.y += 4
//                    frame.size.height -= 2 * 5
//                    super.frame = frame
//                }
//            }
            
            override func setSelected(_ selected: Bool, animated: Bool) {
                super.setSelected(selected, animated: animated)
                
                self.selectionStyle = .none
                self.layer.cornerRadius = 7.0
                self.backgroundColor = #colorLiteral(red: 0.9823900318, green: 1, blue: 0.9829049575, alpha: 1)
            }
            
        }


extension ListTableViewCell {
    private func setupConstraints() {

        addSubview(title)
        addSubview(imageNews)
        addSubview(source)
        
        imageNews.topAnchor.constraint(equalTo: self.topAnchor, constant: 9).isActive = true
        imageNews.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        imageNews.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageNews.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        title.trailingAnchor.constraint(equalTo: self.imageNews.leadingAnchor, constant: -15).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        title.bottomAnchor.constraint(equalTo: self.source.topAnchor, constant: -6).isActive = true
        
        source.trailingAnchor.constraint(equalTo: self.imageNews.leadingAnchor, constant: -20).isActive = true
        source.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6).isActive = true
        source.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        source.heightAnchor.constraint(equalToConstant: 20).isActive = true
        source.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

