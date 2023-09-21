//
//  ImageCell.swift
//  FlickrApp
//
//  Created by Татьяна Касперович on 21.09.23.
//

import UIKit
import SDWebImage

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var imageURL: String? {
        didSet {
            if let imageURL = imageURL, let url = URL(string: imageURL) {
                imageView.sd_setImage(with: url)
            } else {
                imageView.image = nil
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageURL = nil
    }
    
}
