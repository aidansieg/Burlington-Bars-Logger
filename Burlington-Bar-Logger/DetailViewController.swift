//
//  DetailViewController.swift
//  Burlington-Bar-Logger
//
//  Created by Aidan Siegel on 11/2/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var ratingField: UILabel!
    @IBOutlet var descriptionField: UITextField!
    
    var bar: Bar!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = bar.name
        addressField.text = bar.address
        ratingField.text = "\(bar.rating)"
        descriptionField.text = bar.description
    }
    
}
