//
//  GalleryViewController.swift
//  nightclub
//
//  Created by Evgeniy Filipov on 17.02.19.
//  Copyright © 2019 Evgeniy Filipov. All rights reserved.
//

import Foundation
import UIKit

class GalleryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), colorTwo: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
}
