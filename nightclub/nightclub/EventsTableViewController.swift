//
//  EventsTableViewController.swift
//  nightclub
//
//  Created by Evgeniy Filipov on 17.02.19.
//  Copyright © 2019 Evgeniy Filipov. All rights reserved.
//

import Foundation
import UIKit

struct Event {
    let image: String
    let title: String
    let subtitle: String
    let date: String
}

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventSubtitleLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
}

class EventsTableViewController: UITableViewController {
    
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTableViewBackgroundGradient(sender: self, #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        
        loadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        
        let event = events[indexPath.row]
        cell.eventImageView?.image = UIImage(named: event.image)
        cell.eventTitleLabel?.text = event.title
        cell.eventTitleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.eventSubtitleLabel?.text = event.subtitle
        cell.eventSubtitleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.eventDateLabel?.text = event.date
        cell.eventDateLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        
        cell.contentView.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        
        cell.backgroundColor = UIColor.clear
    }
    
    private func setTableViewBackgroundGradient(sender: UITableViewController, _ topColor: UIColor, _ bottomColor: UIColor) {
        
        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations = [0.0, 1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        gradientLayer.frame = sender.tableView.bounds
        let backgroundView = UIView(frame: sender.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        sender.tableView.backgroundView = backgroundView
    }
    
    private func loadData() {
        if let path = Bundle.main.path(forResource: "nightclub", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let dictionary = jsonResult as? [String: Any] {
                    if let dictNightClub = dictionary["nightclub"] as? [String: Any] {
                        if let dictEvents = dictNightClub["events"] as? [String: Any] {
                            for event in (dictEvents["event"] as? Array<AnyObject>)! {
                                self.events.append(Event(image: event["image"] as! String, title: event["title"] as! String, subtitle: event["subtitle"] as! String, date: event["date"] as! String))
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
