//
//  DetailViewController.swift
//  Burlington-Bar-Logger
//
//  Created by Aidan Siegel on 11/2/21.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var ratingField: UILabel!
    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    var barStore: BarStore!
    var imageStore: ImageStore!
    var row: Int!
    
    @IBAction func deleteBar(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Are you sure you want to delete \(bar.name)?", message: nil, preferredStyle: .alert)
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        
        let delete = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.navigationController!.popViewController(animated: true)
            let bar = self.barStore.allBars[self.row]
            self.barStore.removeBar(bar)
            self.imageStore.deleteItem(forKey: bar.barKey)
        
        }
        
        alertController.addAction(delete)
        
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = sender
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    var bar: Bar! {
        didSet {
            navigationItem.title = bar.name
        }
    }
        
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = bar.name
        addressField.text = bar.address
        ratingField.text = "\(bar.rating)"
        descriptionField.text = bar.description
        
        let key = bar.barKey
        
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image =  imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        bar.name = nameField.text ?? ""
        bar.address = addressField.text ?? ""
        
        if let ratingText = ratingField.text, let rating = numberFormatter.number(from: ratingText) {
            bar.rating = rating.intValue
        } else {
            bar.rating = 0
        }
        
        bar.description = descriptionField.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        
        imageStore.setImage(image, forkey: bar.barKey)
        
        imageView.image = image
        
        dismiss(animated: true, completion: nil)
    }
}
