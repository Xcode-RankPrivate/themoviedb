//
//  ShowDetailViewController.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 30/07/22.
//

import UIKit

class ShowDetailViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var image: UIImage?
    
    var cellItem: MovieModel?
    
    var reviewsArray: [ReviewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(DetailMainTableViewCell.nib(), forCellReuseIdentifier: DetailMainTableViewCell.identifier)
        mainTableView.register(DetailDescTableViewCell.nib(), forCellReuseIdentifier: DetailDescTableViewCell.identifier)
        mainTableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.identifier)
        
        APICall().fetchReviews(movieId: cellItem?.id ?? 0) { (reviews, error) in
            
            if error != nil {
                DispatchQueue.main.async {
                    self.showInfoMessage(title: "API Error", desc: error?.localizedDescription ?? "unknown", button: "ok")
                }
                
            }else{
                
                self.reviewsArray = reviews
                
                DispatchQueue.main.async {
                    if reviews.isEmpty {
                        self.showInfoMessage(title: "Reviews Empty", desc: "No Reviews at the moment.", button: "ok")
                        return
                    }
                    self.mainTableView.reloadData()
                }
            }
            
        }
    }
    
    func showInfoMessage(title: String, desc: String, button: String) {
        let alertView = UIAlertController(title: title, message: desc, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: button, style: .cancel, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
}

extension ShowDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return reviewsArray.count
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath == IndexPath(row: 0, section: 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailMainTableViewCell.identifier, for: indexPath) as! DetailMainTableViewCell
            
            cell.theImageView.image = image
            cell.releasedDate.text = "Released Date: \(cellItem?.releaseDate ?? "unknown")"
            cell.showTitle.text = cellItem?.title ?? cellItem?.name
            cell.showScore.text = "TMDB Score \(cellItem?.voteAverage ?? 0.0)"
            
            cell.releasedDate.adjustsFontSizeToFitWidth = true
            cell.showTitle.adjustsFontSizeToFitWidth = true
            cell.showScore.adjustsFontSizeToFitWidth = true
            
            cell.contentView.backgroundColor = .link
            
            return cell
        }else if indexPath == IndexPath(row: 1, section: 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailDescTableViewCell.identifier, for: indexPath) as! DetailDescTableViewCell
            
            cell.descLabel.text = "Synopsis: \(cellItem?.overview ?? "-")"
            cell.descLabel.numberOfLines = 0
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as! ReviewTableViewCell
        
        cell.nameLabel.text = "\(reviewsArray[indexPath.row].theAuthorDetail.username ?? "anonymous") @ \(reviewsArray[indexPath.row].theReviewDate.prefix(10))"
        cell.detailLabel.text = "\(reviewsArray[indexPath.row].theReview)"
        cell.detailLabel.textAlignment = .center
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 210
            }
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Reviews - What viewers say"
        }
        
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }
        
        return 0
    }
}
