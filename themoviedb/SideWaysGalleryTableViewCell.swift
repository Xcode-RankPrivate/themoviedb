//
//  SideWaysGalleryTableViewCell.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 30/07/22.
//

import UIKit

class SideWaysGalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var theCollectionView: UICollectionView!
    
    var parentVC: UIViewController!
    var itemArray: [MovieModel] = []
    
    static let identifier = "SideWaysGalleryTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SideWaysGalleryTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
        theCollectionView.register(ImageCollectionViewCell.nib(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SideWaysGalleryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        
        APICall().fetchImage(imageView: cell.imageView, poster: itemArray[indexPath.row].poster!)
        cell.titleHeightConstraint.constant = 0
        cell.backgroundColor = .link
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowDetailVC") as! ShowDetailViewController
        
        detailVC.cellItem = itemArray[indexPath.row]
        detailVC.image = (collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell).imageView.image
        
        parentVC.navigationController?.show(detailVC, sender: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 10, height: self.bounds.height - 10)
    }
    
}
