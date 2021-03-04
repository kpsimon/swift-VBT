//
//  StatPageViewController.swift
//  SB-Vball
//
//  Created by Keoni Simon on 2/26/21.
//

import UIKit
import RealmSwift

class StatPageViewController: UIViewController {
    @IBOutlet weak var serveInValueLabel: UILabel!
    @IBOutlet weak var totalHitsValueLabel: UILabel!
    @IBOutlet weak var killPercentageValueLabel: UILabel!
    @IBOutlet weak var tipsValueLabel: UILabel!
    @IBOutlet weak var blocksValueLabel: UILabel!
    @IBOutlet weak var digsValueLabel: UILabel!
    
    let realm = try! Realm()
    
    var selectedGame: StatItem? {
        didSet {
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func loadItems() {
        if let game = selectedGame {
            let servePercentage = Double(game.serveIn) / Double(game.serveIn + game.serveOut) * 100
            let killPercentage = Double(game.kills) / Double(game.hits + game.kills) * 100
            let killPercentageFormat = killPercentage != 100 ? "%.2f" : "%.0f"
            
            DispatchQueue.main.async {
                self.serveInValueLabel.text = String(format: "%.2f", servePercentage)
                self.totalHitsValueLabel.text = String(game.hits + game.kills)
                self.killPercentageValueLabel.text = String(format: killPercentageFormat, killPercentage)
                self.tipsValueLabel.text = String(game.tips)
                self.blocksValueLabel.text = String(game.blocks)
                self.digsValueLabel.text = String(game.digs)
            }
        }
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete game?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Delete", style: .default) { (action) in
            if let game = self.selectedGame {
                self.delete(item: game)
            }
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                    //Cancel Action
                }))
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func delete(item: StatItem) {
        do {
            try self.realm.write {
                // delete with realm
                self.realm.delete(item)
            }
        } catch {
            print("Error saving done status \(error)")
        }
    }
}
