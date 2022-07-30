//
//  MainViewController.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 29/07/22.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var mostTrendy : MovieModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(SpotlightTableViewCell.nib(), forCellReuseIdentifier: SpotlightTableViewCell.identifier)
        mainTableView.register(SideWaysGalleryTableViewCell.nib(), forCellReuseIdentifier: SideWaysGalleryTableViewCell.identifier)
        
        mainTableView.showsVerticalScrollIndicator = false
        
        segmentControl.addTarget(self, action: #selector(segmentControlDidChange(sender:)), for: .valueChanged)
        
        getMostPopularItem()
        
    }
    
    func getMostPopularItem() {
        var type = "movie"
        if segmentControl.selectedSegmentIndex == 1 {
            type = "tv"
        }
        
        APICall().fetchShows(trend: "popular", type: type) { (shows, error) in
            if error != nil {
                self.showInfoMessage(title: "API Error", desc: error?.localizedDescription ?? "unknown", button: "ok")
            }else{
                self.mostTrendy = shows.first
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            }
        }
    }
    
    @objc func segmentControlDidChange(sender: UISegmentedControl) {
        
        print("change happened")
        getMostPopularItem()
        
    }
    
    func showInfoMessage(title: String, desc: String, button: String) {
        let alertView = UIAlertController(title: title, message: desc, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: button, style: .cancel, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SpotlightTableViewCell.identifier) as! SpotlightTableViewCell
            
            let text = "Most Popular \(segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex) ?? "Movies")"
            
            if mostTrendy != nil {
                APICall().fetchImage(imageView: cell.theImageView, poster: mostTrendy?.poster ?? "", large: false)
                
                cell.theTitleLabel?.text = (mostTrendy?.title ?? mostTrendy?.name) ?? String(text.prefix(text.count-1))
            }else{
                cell.theTitleLabel?.text = String(text.prefix(text.count-1))
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: SideWaysGalleryTableViewCell.identifier) as! SideWaysGalleryTableViewCell
            
            var type = "movie"
            if segmentControl.selectedSegmentIndex == 1 {
                type = "tv"
            }
            
            var trend = "trending"
            if indexPath.section == 2 {
                trend = "discover"
            }
            
            cell.parentVC = self
            
            APICall().fetchShows(trend: trend, type: type) { (shows, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        self.showInfoMessage(title: "API Error", desc: error?.localizedDescription ?? "unknown", button: "ok")
                    }
                    
                }else{
                    cell.itemArray = shows
                    DispatchQueue.main.async {
                        cell.theCollectionView.reloadData()
                    }
                }
                
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowDetailVC") as! ShowDetailViewController
            
            detailVC.cellItem = mostTrendy
            detailVC.image = (tableView.cellForRow(at: indexPath) as! SpotlightTableViewCell).theImageView.image
            
            self.navigationController?.show(detailVC, sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UIScreen.main.bounds.width/2
        }else{
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return UIView()
        }
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 40))
        
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 5, width: header.frame.width - 20, height: 30))
        
        if section == 1 {
            titleLabel.text = "Trending"
        }else if section == 2 {
            titleLabel.text = "Discover"
        }
        
        header.backgroundColor = .white
        
        titleLabel.adjustsFontSizeToFitWidth = true
        header.addSubview(titleLabel)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 20
        }
        
        return 30
    }
    
}
