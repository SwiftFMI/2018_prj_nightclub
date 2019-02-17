//
//  ViewController.swift
//  nightclub
//
//  Created by Evgeniy Filipov on 13.02.19.
//  Copyright © 2019 Evgeniy Filipov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var eventsButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), colorTwo: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        aboutButton.setImage(UIImage(named: "ic_about"), for: .normal)
        aboutButton.titleEdgeInsets.left = 20
        eventsButton.setImage(UIImage(named: "ic_events"), for: .normal)
        eventsButton.titleEdgeInsets.left = 20
        galleryButton.setImage(UIImage(named: "ic_gallery"), for: .normal)
        galleryButton.titleEdgeInsets.left = 20
        musicButton.setImage(UIImage(named: "ic_music"), for: .normal)
        musicButton.titleEdgeInsets.left = 20
        
        facebookButton.setImage(UIImage(named: "ic_fb"), for: .normal)
        twitterButton.setImage(UIImage(named: "ic_twitter"), for: .normal)
        instagramButton.setImage(UIImage(named:"ic_instagram"), for: .normal)
    }
}

