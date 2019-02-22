//
//  AboutViewController.swift
//  nightclub
//
//  Created by Evgeniy Filipov on 17.02.19.
//  Copyright © 2019 Evgeniy Filipov. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var reservationButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(colorOne: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), colorTwo: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        
        loadData()
    }
    
    @IBAction func onReservationButtonTapped(_ sender: Any) {
        callNumber()
    }

    @IBAction func onLocationButtonTapped(_ sender: Any) {
        UIApplication.shared.open(NSURL(string:"http://maps.apple.com/?ll=42.6744009,23.3284123")! as URL)
    }
    
    private func loadData() {
        reservationButton.setImage(UIImage(named: "ic_phone"), for: .normal)
        locationButton.setImage(UIImage(named: "ic_location"), for: .normal)
        
        if let path = Bundle.main.path(forResource: "nightclub", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let dictionary = jsonResult as? [String: Any] {
                    if let dictNightClub = dictionary["nightclub"] as? [String: Any] {
                        if let dictClubInfo = dictNightClub["clubinfo"] as? [String: Any] {
                            titleLabel.text = dictClubInfo["name"] as? String
                            subtitleLabel.text = dictClubInfo["slogan"] as? String
                            descriptionLabel.text = dictClubInfo["description"] as? String
                            descriptionLabel.numberOfLines = 0
                            descriptionLabel.sizeToFit()
                            
                            reservationButton.setTitle(dictClubInfo["phonenumber"] as? String, for: .normal)
                            reservationButton.titleLabel?.numberOfLines = 0
                            reservationButton.titleLabel?.sizeToFit()
                            
                            locationButton.setTitle(dictClubInfo["location"] as? String, for: .normal)
                            reservationButton.titleLabel?.numberOfLines = 0
                            reservationButton.titleLabel?.sizeToFit()
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func callNumber() {
        if let phoneCallURL:NSURL = NSURL(string:"tel://*123*3#") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.open(phoneCallURL as URL)
            }
        }
    }
}
