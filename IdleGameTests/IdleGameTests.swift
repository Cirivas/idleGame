//
//  IdleGameTests.swift
//  IdleGameTests
//
//  Created by Camilo Rivas on 13-03-18.
//  Copyright © 2018 Camilo Rivas. All rights reserved.
//

import XCTest
@testable import IdleGame

class IdleGameTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testSumExp() {
        let user = User()
        
        XCTAssertEqual(1, user.sumExp(49))
        XCTAssertEqual(2, user.sumExp(1))
        XCTAssertEqual(2, user.sumExp(1))
        XCTAssertEqual(3, user.sumExp(100))
        XCTAssertEqual(1, user.currentExp)
        XCTAssertEqual(3, user.sumExp(100))
        XCTAssertEqual(4, user.sumExp(59))
        
        let user2 = User()
        
        XCTAssertEqual(6, user2.sumExp(850))
        XCTAssertEqual(10, user2.currentExp)
    }
    
    func testUpdatedGold() {
        let user = User()
        user.updatedGold = { print("value changed: \(user.currentGold)") }
        
        user.currentGold += 1
        user.currentGold += 1
        user.currentGold += 20
    }
    
    func testDoDmg() {
        let monster = Monster(level: 1, maxHp: 10, gold: 1)
        let job = Job(name: "test", dps: 1, price: 1)
        
        job.monster = monster
        XCTAssertEqual(monster.hp, 10)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            XCTAssertEqual(monster.hp, 9)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            XCTAssertEqual(monster.hp, 8)
        }
    }
}
