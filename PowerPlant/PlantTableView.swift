//
//  PlantTableView.swift
//  PowerPlant
//
//  Created by Ubicomp7 on 11/14/17.
//  Copyright © 2017 PowerPlantTeam. All rights reserved.
//

import UIKit
import FirebaseDatabase


class PlantTableView: UITableViewController {
    var plants = [Plant]()
    let fbHelper = FirebaseHelper()
    let ref = Database.database().reference().child("Plants")
    var selectedPlant = Plant()

    override func viewDidLoad() {
        super.viewDidLoad()
        fbHelper.getDataAsArray(ref: ref, typeOf: plants) { (array) in
            self.plants = array
            DispatchQueue.main.async {self.tableView.reloadData() }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlantCell
        // Configure the cell...
        let plant = plants[indexPath.row]
        cell.Plant.text = plant.name
        if plant.waterNeeds.characters.count >= 3 {
            cell.Subtitle.isHidden = false
            cell.Subtitle.isHidden = false
            cell.difficulty.text = plant.waterNeeds
        } else {
            cell.Subtitle.isHidden = true
            cell.difficulty.isHidden = true
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlant = plants[indexPath.row]
        performSegue(withIdentifier: "plantsToDetails", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! DetailsViewController
        dvc.plantIn = selectedPlant.name
        dvc.descriptionIn = selectedPlant.description
        dvc.plantTypeIn = selectedPlant.plantType
        dvc.waterNeedsIn = selectedPlant.waterNeeds
    }



}
