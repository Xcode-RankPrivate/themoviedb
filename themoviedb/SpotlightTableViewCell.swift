//
//  SpotlightTableViewCell.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 29/07/22.
//

import UIKit

class SpotlightTableViewCell: UITableViewCell {

    @IBOutlet weak var theImageView: UIImageView!
    @IBOutlet weak var theTitleLabel: UILabel!
    
    static let identifier = "SpotlightTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SpotlightTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.backgroundColor = .systemPink
        
        theTitleLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        theTitleLabel.textColor = .systemGray
        theTitleLabel.textAlignment = .center
        
        theImageView.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
