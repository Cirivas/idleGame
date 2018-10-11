//
//  JobsTableViewCell.swift
//  IdleGame
//
//  Created by Camilo Rivas on 16-03-18.
//  Copyright © 2018 Camilo Rivas. All rights reserved.
//

import UIKit

class JobsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var jobName: UILabel!
    @IBOutlet weak var jobLevel: UILabel!
    @IBOutlet weak var jobDPS: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var price: UILabel!
    
    var user : User?
    var job : Job?
    var monster: Monster?
    var listIndex : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        
    }
    
    @IBAction func buyJob(_ sender: Any) {
        if(job!.bought) {
            user!.currentGold -= job!.price
            job!.dps *= 2
            job!.price *= 2
            job!.level += 1
        } else {
            user!.currentGold -= job!.price
            job!.monster = monster
            job!.bought = true
            job!.price *= 2
            actionButton.setTitle("Mejorar", for: .normal)
        }
        price.text = stringFormatter(for: job!.price)
        jobDPS.text = stringFormatter(for: job!.dps)
        jobLevel.text = stringFormatter(for: job!.level)
    }

}
