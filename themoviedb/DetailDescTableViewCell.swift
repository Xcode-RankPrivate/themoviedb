//
//  DetailDescTableViewCell.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 30/07/22.
//

import UIKit

class DetailDescTableViewCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    
    static let identifier = "DetailDescTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailDescTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
