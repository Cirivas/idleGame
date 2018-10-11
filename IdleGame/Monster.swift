//
//  Monster.swift
//  IdleGameTests
//
//  Created by Camilo Rivas on 14-03-18.
//  Copyright © 2018 Camilo Rivas. All rights reserved.
//

import Foundation

class Monster {
    var maxHp : Int
    var hp : Int {
        didSet {
            updatedHp!()
        }
    }
    var level : Int
    var exp = 1
    var gold = 1
    
    var updatedHp : (() -> Void)?
    
    init(level: Int, maxHp : Int, gold: Int) {
        self.hp = maxHp
        self.maxHp = maxHp
        self.level = level
        self.gold = gold
    }
    
    func reinit(level: Int, maxHp : Int, gold: Int){
        self.hp = maxHp
        self.maxHp = maxHp
        self.level = level
        self.gold = gold
    }
}
