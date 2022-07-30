//
//  ViewController.swift
//  themoviedb
//
//  Created by JAN FREDRICK on 29/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var customTitleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        customTitleLabel.adjustsFontSizeToFitWidth = true
        
        loginButton.layer.borderWidth = 2.0
        loginButton.layer.borderColor = UIColor.link.cgColor
        loginButton.layer.cornerRadius = loginButton.frame.height/2
        loginButton.addTarget(self, action: #selector(enterToMainScreen), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }

    @objc func enterToMainScreen() {
        self.performSegue(withIdentifier: "fromLoginToMain", sender: self)
    }

}

