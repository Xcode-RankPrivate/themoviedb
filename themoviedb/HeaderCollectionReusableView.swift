//
//  HeaderCollectionReusableView.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 29/07/22.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "HeaderCollectionReusableCell"
    
    public func configure(title: String = "Unknown") {
        
        backgroundColor = .systemGreen
        
        let headerTextLabel = UILabel(frame: CGRect(x: 20, y: 5, width: UIScreen.main.bounds.width - 60, height: 30))
        headerTextLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        headerTextLabel.textColor = .systemGray
        headerTextLabel.text = title
        addSubview(headerTextLabel)
    }
}
