//
//  ViewController.swift
//  PowerPlant
//
//  Created by Ubicomp7 on 11/13/17.
//  Copyright © 2017 PowerPlantTeam. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func sequeButton(_ sender: UIButton) {
        performSegue(withIdentifier: "powerPlantToPlantTable", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

