//
//  ImageCollectionViewCell.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 29/07/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    static let identifier = "ImageCollectionViewCell"
    
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    
    var itemDetails: MovieModel?
    
    static func nib() -> UINib {
        return UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.contentMode = .scaleAspectFill
        
        imageTitle.textAlignment = .center
        imageTitle.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        imageTitle.textColor = .systemGray
        
    }

}
