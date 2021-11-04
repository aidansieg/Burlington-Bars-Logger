//
//  DetailViewController.swift
//  Burlington-Bar-Logger
//
//  Created by Aidan Siegel on 11/2/21.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var ratingField: UILabel!
    @IBOutlet var descriptionField: UITextField!
    
    var bar: Bar! {
        didSet {
            navigationItem.title = bar.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = bar.name
        addressField.text = bar.address
        ratingField.text = "\(bar.rating)"
        descriptionField.text = bar.description
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        bar.name = nameField.text ?? ""
        bar.address = addressField.text ?? ""
        
//        if let ratingText = ratingField.text, let rating = NumberFormatter.number(from: ratingText) {
//            bar.rating = rating.intValue
//        } else {
//            bar.rating = 0
//        }
        
        bar.description = descriptionField.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
