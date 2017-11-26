//
//  DashboardViewController.swift
//  PowerPlant
//
//  Created by Ron Borneo on 11/14/17.
//  Copyright © 2017 PowerPlantTeam. All rights reserved.
//

import UIKit
import Charts

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
  
  var thingSpeakUrl = "https://api.thingspeak.com/channels/357261/feeds.json?results=7"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getData(url: URL(string: thingSpeakUrl)!)
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
    
    lastWateredLabel.text = previousWaterDate == "" ? "Not in 7 Days" : previousWaterDate
    
    let values = info?.feeds.map({ (item) -> Double in
      return Double(item.field1)!
    })
  
    print(values)
    let bar_yaxis = [0, 20, 40, 60, 80, 100]
    barChartUpdate(yaxis: bar_yaxis, values: values!)
  }
  
  func barChartUpdate(yaxis: [Int], values: [Double]) {
    var entries = [BarChartDataEntry]()
    for (key, value) in values.enumerated() {
      entries.append(BarChartDataEntry(x: Double(key), y: value))
    }
    let dataSet = BarChartDataSet(values: entries, label: "Past Soil Moisture Level")
    let data = BarChartData(dataSet: dataSet)
    barChart.data = data
    barChart.chartDescription?.text = " "
    barChart.xAxis.drawGridLinesEnabled = false
    barChart.xAxis.drawLabelsEnabled = false
    barChart.notifyDataSetChanged()
    barChart.animate(xAxisDuration: 2.5, yAxisDuration: 2.5)
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
  
  @IBOutlet weak var barChart: BarChartView!
  
  var soilMoisterLevel = 0
  
  var tankProgressLevel = 0
  
  @IBOutlet weak var soilProgress: UIProgressView!
  
  @IBOutlet weak var tankProgress: UIProgressView!
  
  @IBOutlet weak var lastWateredLabel: UILabel!

}