//
//  DashboardViewController.swift
//  PowerPlant
//
//  Created by Ron Borneo on 11/14/17.
//  Copyright © 2017 PowerPlantTeam. All rights reserved.
//

import UIKit

struct FeedInfo: Codable {
  var channel = ChannelInfo()
  var feeds = [Feed]()
}

struct ChannelInfo: Codable {
  var id = 0
  var name = ""
  var description = ""
  var latitude = ""
  var longitude = ""
  var field1 = ""
  var field2 = ""
  var field3 = ""
  var field4 = ""
  var created_at = ""
  var updated_at = ""
  var last_entry_id = 0
}

struct Feed: Codable {
  var created_at = ""
  var entry_id = 0
  var field1 = ""
  var field2 = ""
  var field3 = ""
  var field4 = ""
}

class DashboardViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getData(url: URL(string: "https://api.thingspeak.com/channels/357261/feeds.json?results=2")!)
    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    soilProgress.progress = Float((info?.feeds[0].field1)!)! / 100
    tankProgress.progress = Float((info?.feeds[0].field2)!)! / 100
    var previousWaterDate = ""
    for item in (info?.feeds)! {
      if item.field3 == "1" {
        previousWaterDate = item.created_at
      }
    }
    lastWateredLabel.text = previousWaterDate
  }
  
  var info: FeedInfo?
  
  func getData(url: URL) {
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let data = data {
        do {
          // Convert the data to JSON
          let jsonDecoder = JSONDecoder()
          print("data: \(data)")
          let contacts = try jsonDecoder.decode(FeedInfo.self, from: data)
          print("contacts: \(contacts)")
          self.info = contacts
          print(self.info!)
        } catch {
          print("Error trying to decode JSON object")
        }
      } else if let error = error {
        print(error.localizedDescription)
      }
    }
    task.resume()
  }
  
  var soilMoisterLevel = 0
  
  var tankProgressLevel = 0
  
  @IBOutlet weak var soilProgress: UIProgressView!
  
  @IBOutlet weak var tankProgress: UIProgressView!
  
  @IBOutlet weak var lastWateredLabel: UILabel!

}
