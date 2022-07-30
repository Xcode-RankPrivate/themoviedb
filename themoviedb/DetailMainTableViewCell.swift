//
//  DetailMainTableViewCell.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 30/07/22.
//

import UIKit

class DetailMainTableViewCell: UITableViewCell {

    @IBOutlet weak var theImageView: UIImageView!
    @IBOutlet weak var releasedDate: UILabel!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showScore: UILabel!
    
    static let identifier = "DetailMainTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailMainTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        showScore.textColor = .white
        showTitle.textColor = .white
        releasedDate.textColor = .white
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
