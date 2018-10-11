//
//  User.swift
//  IdleGame
//
//  Created by Camilo Rivas on 13-03-18.
//  Copyright © 2018 Camilo Rivas. All rights reserved.
//

import Foundation

class User {
    var level = 1 {
        didSet {
            updatedLevel!()
        }
    }
    var currentExp = 0
    var requiredExps = [1: 50, 2:100, 3:160, 4:230, 5: 300, 6: 999]
    var currentGold = 0 {
        didSet {
            updatedGold!()
        }
    }

    var updatedGold : (() -> Void)?
    var updatedLevel: (() -> Void)?
}

extension User {
    @discardableResult
    func sumExp(_ amount : Int) -> Int{
        if level == 6 {
            return level
        }
        
        currentExp += amount;
        if currentExp >= requiredExps[level]! {
            repeat {
                currentExp = currentExp - requiredExps[level]!
                level += 1
            } while currentExp >= requiredExps[level]!
        }
        
        return level
    }
}
