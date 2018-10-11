//
//  ViewController.swift
//  IdleGame
//
//  Created by Camilo Rivas on 13-03-18.
//  Copyright © 2018 Camilo Rivas. All rights reserved.
//

import UIKit

func stringFormatter(for value: Int) -> String {
    var string : String = "\(value)"
    if value > 1_000 {
        string = "\(value / 1_000)k"
    }
    
    if value > 1_000_000 {
        string = "\(value / 1_000_000)K"
    }
    
    return string
}

class ViewController: UIViewController {

    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var currentExp: UILabel!
    @IBOutlet weak var requiredExp: UILabel!
    @IBOutlet weak var poringImage: UIImageView!
    @IBOutlet weak var poringCurrentHp: UILabel!
    @IBOutlet weak var poringMaxHp: UILabel!
    @IBOutlet weak var currentGold: UILabel!
    @IBOutlet weak var jobsTable: UITableView!
    
    let user = User()
    var monster : Monster?
//    var jobs : [Job] {
//        return [novice, swordman, knight]
//    }
    let novice = Job(name: "Novice", dps: 1, price: 10)
    let swordman = Job(name: "Swordman", dps: 6, price: 50)
    let knight = Job(name: "Knight", dps: 14, price: 110)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //User setup
        user.updatedGold = {
            self.currentGold.text = stringFormatter(for: self.user.currentGold)
            
            for index in 0...2 {
                self.changeButtonState(row: index)
            }
        }
        
        user.updatedLevel = {
            self.level.text = "\(self.user.level)"
            self.requiredExp.text = "\(self.user.requiredExps[self.user.level]!)"
        }
        
        //user.currentGold = 100
        level.text = "\(user.level)"
        currentExp.text = "\(user.currentExp)"
        requiredExp.text = "\(user.requiredExps[user.level]!)"
        currentGold.text = "\(user.currentGold)"
        
        
        //Monster setup
        monster = Monster(level: user.level, maxHp: 10, gold: 1)
        poringCurrentHp.text = "\(monster!.hp)"
        poringMaxHp.text = "\(monster!.maxHp)"
        
        monster!.updatedHp = {
            if self.monster!.hp <= 0 {
                let currentLevel = self.user.sumExp(self.monster!.exp)
                self.user.currentGold += self.monster!.gold
                
                //Update labels
                self.currentExp.text = stringFormatter(for: self.user.currentExp)
                self.level.text = stringFormatter(for: currentLevel)
                
                //Create a new monster
                self.monster!.reinit(level: self.user.level, maxHp: self.user.level*10, gold: 1*self.user.level)
                
                self.poringMaxHp.text = stringFormatter(for: self.monster!.maxHp)
            }
            self.poringCurrentHp.text = stringFormatter(for: self.monster!.hp)
        }
        
        jobsTable.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func poringClick(_ sender: UITapGestureRecognizer) {
        monster!.hp -= user.level
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "jobCellIdentifier") as? JobsTableViewCell else {
            fatalError("not instance")
            }
        
        var job : Job!
        if indexPath.row == 0 {
            job = novice
        }
        if indexPath.row == 1 {
            job = swordman
        }
        
        if indexPath.row == 2 {
            job = knight
        }
        
        cell.listIndex = indexPath.row
        cell.jobName.text = job.name
        cell.jobLevel.text = stringFormatter(for: job.level)
        cell.jobDPS.text = stringFormatter(for: job.dps)
        cell.actionButton.isEnabled = false
        cell.price.text = stringFormatter(for: job.price)
        cell.user = user
        cell.job = job
        cell.monster = monster
        return cell
    }
}


private extension ViewController {
    func changeButtonState(row: Int) {
        guard let cell = self.jobsTable.cellForRow(at: IndexPath.init(row: row, section: 0)) as? JobsTableViewCell else {
            fatalError("not instance")
        }
        if user.currentGold >= cell.job!.price {
            cell.actionButton.isEnabled = true
        } else {
            cell.actionButton.isEnabled = false
        }
    }
    

}

