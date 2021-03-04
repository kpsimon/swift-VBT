//
//  TrackStatsViewController.swift
//  SB-Vball
//
//  Created by Keoni Simon on 2/25/21.
//

import UIKit
import RealmSwift

class TrackStatsViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var serveInCount: UILabel!
    @IBOutlet weak var serveOutCount: UILabel!
    @IBOutlet weak var hitInCount: UILabel!
    @IBOutlet weak var hitOutCount: UILabel!
    @IBOutlet weak var tipsCount: UILabel!
    @IBOutlet weak var blocksCount: UILabel!
    @IBOutlet weak var digsCount: UILabel!
    
    let realm = try! Realm()
    
    //MARK: - UIView Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - Front End Changes
    
    @IBAction func serveInStepperPressed(_ sender: UIStepper) {
        updateValue(update: serveInCount, value: sender.value)
    }
    
    @IBAction func serveOutStepperPressed(_ sender: UIStepper) {
        updateValue(update: serveOutCount, value: sender.value)
    }
    
    @IBAction func hitInStepperPressed(_ sender: UIStepper) {
        updateValue(update: hitInCount, value: sender.value)
    }
    
    @IBAction func hitOutStepperPressed(_ sender: UIStepper) {
        updateValue(update: hitOutCount, value: sender.value)
    }
    
    @IBAction func tipsStepperPressed(_ sender: UIStepper) {
        updateValue(update: tipsCount, value: sender.value)
    }
    
    @IBAction func blocksStepperPressed(_ sender: UIStepper) {
        updateValue(update: blocksCount, value: sender.value)
    }
    
    @IBAction func digsStepperPressed(_ sender: UIStepper) {
        updateValue(update: digsCount, value: sender.value)
    }
    
    func updateValue(update category: UILabel!, value: Double) {
        category.text = String(Int(value))
    }
    
    //MARK: - Realm Data Handling
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Confirm submit", message: "", preferredStyle: .alert)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
    
        let action = UIAlertAction(title: "Confirm", style: .default) { (action) in
            //what will happen once the user clicks the add item button on UIalert
    
            //can add more validation to textField.text here
            let newStatItem = StatItem()
            newStatItem.serveIn = Int(self.serveInCount.text ?? "0")!
            newStatItem.serveOut = Int(self.serveOutCount.text ?? "0")!
            newStatItem.hits = Int(self.hitInCount.text ?? "0")!
            newStatItem.kills = Int(self.hitOutCount.text ?? "0")!
            newStatItem.tips = Int(self.tipsCount.text ?? "0")!
            newStatItem.blocks = Int(self.blocksCount.text ?? "0")!
            newStatItem.digs = Int(self.digsCount.text ?? "0")!
            newStatItem.dateCreated = self.datePicker.date
            newStatItem.dateString = dateFormatter.string(from: self.datePicker.date)
    
            self.save(stats: newStatItem)
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                    //Cancel Action
                }))
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func save(stats: StatItem) {
        do {
            try realm.write {
                realm.add(stats)
            }
        } catch {
            print("Error saving context \(error)")
        }
    }
}
