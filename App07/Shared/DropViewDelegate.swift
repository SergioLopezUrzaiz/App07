//
//  DropViewDelegate.swift
//  App07 (iOS)
//
//  Created by user194222 on 10/14/21.
//

import SwiftUI

struct DropViewDelegate: DropDelegate {
    
    
    var dataModel: DataModel
    var image: Img
    @Binding var isCompleted: Bool
    
    func performDrop(info: DropInfo) -> Bool {
        
        let fromIndex = dataModel.images.firstIndex { (img) -> Bool in
            return img.id == dataModel.currentImage?.id
        } ?? 0
        let toIndex = dataModel.images.firstIndex { (img) -> Bool in
            return img.id == image.id
        } ?? 0
        
        if fromIndex != toIndex {
            
            print("From: \(fromIndex) to: \(toIndex)")
            dataModel.images.swapAt(fromIndex, toIndex)
            
        }
        if dataModel.currentImage!.id == dataModel.images[toIndex].id {
            if(validatePuzzle()) {
                isCompleted = true
            }
        }

        return true
    }
    
    func dropEntered(info: DropInfo) {
        
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        
        return DropProposal(operation: .move)
        
    }
    
    private func validatePuzzle() ->  Bool {
        var cont = 0
        while (cont < 16) {
            if(cont != dataModel.images[cont].id) {
                return false
            }
            cont += 1
        }
        return true
    }
    
}
