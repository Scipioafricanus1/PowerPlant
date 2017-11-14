//
//  PlantCell.swift
//  PowerPlant
//
//  Created by Ubicomp7 on 11/14/17.
//  Copyright © 2017 PowerPlantTeam. All rights reserved.
//

import UIKit

class PlantCell: UITableViewCell {

    @IBOutlet weak var Plant: UILabel!
    @IBOutlet weak var Subtitle: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
