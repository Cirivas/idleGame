//
//  Jobs.swift
//  IdleGame
//
//  Created by Camilo Rivas on 16-03-18.
//  Copyright © 2018 Camilo Rivas. All rights reserved.
//

import Foundation

class Job {
    var name : String
    var dps : Int
    var price : Int
    var level : Int
    var damageTimer: Timer!
    var bought = false
    
    
    var monster : Monster? {
        didSet {
            damageTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doDmg(_:)), userInfo: monster!, repeats: true)
        }
    }
    
    init(name: String, dps: Int, price: Int) {
        self.name = name
        self.dps = dps
        self.price = price
        self.level = 1
    }
}

private extension Job {
    @objc func doDmg(_ timer : Timer) {
        let monster = timer.userInfo as! Monster
        monster.hp -= dps
    }
}
