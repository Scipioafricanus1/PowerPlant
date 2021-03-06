//
//  DetailsViewController.swift
//  PowerPlant
//
//  Created by Ubicomp7 on 11/14/17.
//  Copyright © 2017 PowerPlantTeam. All rights reserved.
//

import UIKit


class DetailsViewController: UIViewController {
    var plantIn = ""
    var descriptionIn = ""
    var plantTypeIn = ""
    var waterNeedsIn = ""
    var maintenanceIn = ""
    var tipsIn = ""
    


    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var plantType: UILabel!
    @IBOutlet weak var maintenance: UILabel!
    @IBOutlet weak var waterNeeds: UILabel!
    @IBOutlet weak var tips: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = plantIn
        self.waterNeeds.text = waterNeedsIn
        self.plantType.text = plantTypeIn
        self.details.text = "\t" + descriptionIn
        self.maintenance.text = maintenanceIn
        var bullets = ""

        
        
        //this line should print bulleted tips now, based on the firebase with \n characters in it.
        bullets = tipsIn.replacingOccurrences(of: "\n", with: "\n\u{2022}   ")
        bullets = "\u{2022}   \(bullets)"
        
        self.tips.text = bullets

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! DashboardViewController
        dvc.plantNameIn = plantIn
        dvc.waterNeedsIn = waterNeedsIn
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
