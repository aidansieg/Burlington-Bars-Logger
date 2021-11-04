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
    var imageStore: ImageStore!
    
    @IBAction func addNewBar(_ sender: UIBarButtonItem) {
        let newBar = barStore.createBar()
        
        if let index = barStore.allBars.firstIndex(of: newBar) {
            
            let indexPath = IndexPath(row: index, section: 0)
            
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
//    @IBAction func deleteBar(_ sender: UIBarButtonItem) {
//            
//        let indexPath = IndexPath(row: 0, section: 0)
//            
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//    }
    
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
            
            imageStore.deleteItem(forKey: bar.barKey)
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showBar":
            if let row = tableView.indexPathForSelectedRow?.row {
                let bar = barStore.allBars[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.bar = bar
                detailViewController.imageStore = imageStore
            }
        default:
            preconditionFailure("Unexpected segue indentifier.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
}
