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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return barStore.allBars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let bar = barStore.allBars[indexPath.row]
        
        cell.nameLabel.text = bar.name
        cell.ratingLabel.text = "\(bar.rating) out of 5"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let bar = barStore.allBars[indexPath.row]
        
        let alertController = UIAlertController(title: "Are you sure you want to delete \(bar.name)?", message: nil, preferredStyle: .alert)
        alertController.modalPresentationStyle = .automatic
        
        let delete = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.barStore.removeBar(bar)
            tableView.deleteRows(at: [indexPath], with: .none)
        }
        
        alertController.addAction(delete)
        
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(cancel)
     
        present(alertController, animated: true, completion: nil)
        
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
                detailViewController.barStore = barStore
                detailViewController.imageStore = imageStore
                detailViewController.row = row
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
