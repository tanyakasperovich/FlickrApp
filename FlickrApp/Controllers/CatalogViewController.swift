//
//  CatalogViewController.swift
//  FlickrApp
//
//  Created by Татьяна Касперович on 21.09.23.
//

import UIKit

class CatalogViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Flickr Images"
        
        APIServiceCombine.shared.fetchFlickrImages { [weak self] images in
            DispatchQueue.main.async {
                guard let self else {return }
                self.flickrImages = images
                self.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let detailViewController = segue.destination as? DetailViewController,
           let indexPath = collectionView.indexPathsForSelectedItems?.first {
            detailViewController.flickrImage = flickrImages[indexPath.row]
        }
    }
    
    // MARK: - Private Properties...
    private var flickrImages: [FlickrImageModel] = []
    
}

// MARK: - Table view data source...
extension CatalogViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        let imageValue = flickrImages[indexPath.row].flickrImage
        cell.imageURL = imageValue
        
        return cell
    }
    
}

// MARK: - Flow Layout...
extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width / 3
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
