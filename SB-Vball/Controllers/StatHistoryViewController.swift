//
//  StatHistoryViewController.swift
//  SB-Vball
//
//  Created by Keoni Simon on 2/25/21.
//

import UIKit
import RealmSwift

class StatHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    var statItems: Results<StatItem>?
    
    //MARK: - UIView Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "STAT HISTORY"
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - Data Handling Functions
    func loadData() {
        statItems = realm.objects(StatItem.self).sorted(byKeyPath: "dateCreated", ascending: false)
        tableView.reloadData()
    }
}

//MARK: - Table View Functions

extension StatHistoryViewController: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statItems?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! GameCell
        
        if let item = statItems?[indexPath.row] {
            if indexPath.row % 2 == 0 {
                cell.messageBubble.backgroundColor = UIColor.white
                cell.label.textColor = UIColor(named: K.BrandColors.blue)
            } else {
                cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.blue)
                cell.label.textColor = UIColor.white
            }
            cell.label.text = item.dateString
        } else {
            cell.textLabel?.text = "No Games Added"
        }
        
        return cell
    }
}

extension StatHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: K.segueHistoryToStat, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! StatPageViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedGame = statItems?[indexPath.row]
        }
    }
}

//MARK: - Search Bar Functions

extension StatHistoryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        statItems = statItems?.filter("dateString CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)

        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadData()
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            statItems = statItems?.filter("dateString CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        }
        
        tableView.reloadData()
    }
}
