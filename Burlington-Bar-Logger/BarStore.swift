//
//  BarStore.swift
//  Burlington-Bar-Logger
//
//  Created by Aidan Siegel on 10/17/21.
//

import UIKit

class BarStore {
    var allBars = [Bar]()
    
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
}


