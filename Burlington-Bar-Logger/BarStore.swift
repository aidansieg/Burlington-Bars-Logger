//
//  BarStore.swift
//  Burlington-Bar-Logger
//
//  Created by Aidan Siegel on 10/17/21.
//

import UIKit

class BarStore {
    var allBars = [Bar]()
    let barArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent("bars.plist")
    }()
    
    @discardableResult func createBar() -> Bar {
        let newBar = Bar(random: true)
        allBars.append(newBar)
        
        return newBar
    }
    
    func removeBar(_ item: Bar) {
        if let index = allBars.firstIndex(of: item) {
            allBars.remove(at: index)
        }
    }
    
    func moveBar(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedBar = allBars[fromIndex]
        
        allBars.remove(at: fromIndex)
        
        allBars.insert(movedBar, at: toIndex)
    }
    
    @objc func saveChanges() -> Bool {
        print("Saving all bars to: \(barArchiveURL)")
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allBars)
            try data.write(to: barArchiveURL, options: [.atomic])
            print("Saved all of the bars")
            return true
            
        } catch let encodingError{
            print("Error encoding allBars: \(encodingError)")
            return false
        }
    }
    
    init() {
        do {
            let data = try Data(contentsOf: barArchiveURL)
            let unarchive = PropertyListDecoder()
            let bars = try unarchive.decode([Bar].self, from: data)
            allBars = bars
        } catch {
            print("Error reading in saved bars: \(error)")
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
    }
}


