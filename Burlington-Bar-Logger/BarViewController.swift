//
//  BarsViewController.swift
//  Burlington-Bar-Logger
//
//  Created by Aidan Siegel on 10/17/21.
//

//import Foundation
import UIKit

class BarViewController: UITableViewController {
    var barStore: BarStore!
    
    @IBAction func addNewBar(_ sender: UIButton) {
        let newBar = barStore.createBar()
        
        if let index = barStore.allBars.firstIndex(of: newBar) {
            
            let indexPath = IndexPath(row: index, section: 0)
            
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return barStore.allBars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let bar = barStore.allBars[indexPath.row]
        
        cell.nameLabel.text = bar.name
        cell.ratingLabel.text = "\(bar.rating)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let bar = barStore.allBars[indexPath.row]
            
            barStore.removeBar(bar)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        barStore.moveBar(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
}
