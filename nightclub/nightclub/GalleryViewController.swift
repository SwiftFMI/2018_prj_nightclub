//
//  GalleryViewController.swift
//  nightclub
//
//  Created by Evgeniy Filipov on 17.02.19.
//  Copyright © 2019 Evgeniy Filipov. All rights reserved.
//

import Foundation
import UIKit
import SwiftPhotoGallery

struct Gallery {
    var coverImage: String
    var images: [String]
}

class GalleryTableViewCell: UITableViewCell {
    @IBOutlet weak var galleryCoverImageView: UIImageView!
}

class GalleryViewController: UITableViewController, SwiftPhotoGalleryDataSource, SwiftPhotoGalleryDelegate {
    
    var galleries: [Gallery] = []
    
    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
        return galleries[0].images.count
    }
    
    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> UIImage? {
        return UIImage(named: galleries[0].images[forIndex])
    }
    
    func galleryDidTapToClose(gallery: SwiftPhotoGallery) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTableViewBackgroundGradient(sender: self, #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))

        loadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryCell", for: indexPath) as! GalleryTableViewCell
        
        cell.galleryCoverImageView.image = UIImage(named: galleries[indexPath.row].coverImage)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gallery = SwiftPhotoGallery(delegate: self, dataSource: self)
        
        present(gallery, animated: true, completion: nil)
    }
    
    private func loadData() {
        if let path = Bundle.main.path(forResource: "nightclub", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let dictionary = jsonResult as? [String: Any] {
                    if let dictNightClub = dictionary["nightclub"] as? [String: Any] {
                        if let dictGalleries = dictNightClub["galleries"] as? [String: Any] {
                            for entry in (dictGalleries["gallery"] as? Array<AnyObject>)! {
                                var gallery: Gallery = Gallery(coverImage: entry["cover"] as! String, images: [])
                                if let dictPhotos = entry["photos"] as? [String: Any] {
                                    if let dictPhotosUrlDict = dictPhotos["photo"] as? [String: Any] {
                                        gallery.images.append(dictPhotosUrlDict["url"] as! String)
                                    } else if let dictPhotosUrlArray = dictPhotos["photo"] as? [AnyObject] {
                                        for e in dictPhotosUrlArray {
                                            gallery.images.append(e["url"] as! String)
                                        }
                                    }
                                }
                                galleries.append(gallery)
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
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
}
