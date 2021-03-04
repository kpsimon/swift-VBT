//
//  ViewController.swift
//  SB-Vball
//
//  Created by Keoni Simon on 2/25/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var trackStatsButton: UIButton!
    @IBOutlet weak var statsHistoryButton: UIButton!
    @IBOutlet weak var overallStatsButton: UIButton!
    
    //MARK: - UIView Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
}

