//
//  ChefTableViewController.swift
//  FoodTracker
//
//  Created by Nedeljko Mijajlovic on 13/12/2018.
//  Copyright © 2018 Apple Inc. All rights reserved.
//
import UIKit

class ChefTableViewController: UITableViewController {
    var chefs = [SQLiteChefMeal]()
    var database: FoodTrackerDatabase?
    
    let repo = SQLChefRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = try? FoodTrackerDatabase()
        // edit button
        navigationItem.leftBarButtonItem = editButtonItem
        
        loadChefs()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chefs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ChefTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChefTableViewCell else {
            fatalError("The dequeued cell is not an instance of ChefTableViewCell.")
        }
        
        let chef = chefs[indexPath.row]
        
        cell.Name.text = chef.name
        cell.Age.text = String(chef.age)
        cell.workExp.text = String(chef.workExp)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let chef = chefs[indexPath.row]
            if let database = database {
                try? repo.removeChef(connection: database.connection, idToRemove: chef.id)
            }
            chefs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            break
            
        case "ShowDetail":
            guard let chefDetailViewController = segue.destination as?
                ChefViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
        
            
            }
            
            guard let selectedChefCell = sender as? ChefTableViewCell else {
            fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedChefCell) else {
            fatalError("The selected cell is not being displayed by the table")
                
            }
            
            let selectedChef = chefs[indexPath.row]
            chefDetailViewController.chef = selectedChef
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
        
    }
    
    @IBAction func unwindToChefList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ChefViewController, let chef = sourceViewController.chef {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: chefs.count, section: 0)
            
            chefs.append(chef)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
                
            }
        }
   
  
    private func loadChefs() {
        if let database = database {
            chefs = repo.getAllChefs(connection: database.connection)
        }
    }
}
