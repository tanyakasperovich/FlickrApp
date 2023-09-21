//
//  DetailViewController.swift
//  FlickrApp
//
//  Created by Татьяна Касперович on 21.09.23.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var owner: UILabel!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flickrImage = flickrImage, let url = URL(string: flickrImage.flickrImage) {
            imageView.sd_setImage(with: url)
            owner.text = "@ \(flickrImage.owner)"
            imageName.text = "Name: \(flickrImage.imageName)"
        }
    }
    
    // MARK: - Properties...
    var flickrImage: FlickrImageModel?
}


