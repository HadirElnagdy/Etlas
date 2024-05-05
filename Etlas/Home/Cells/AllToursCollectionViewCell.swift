//
//  AllToursCollectionViewCell.swift
//  Etlas
//
//  Created by Hadir on 23/06/2023.
//

import UIKit

class AllToursCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tourImg: UIImageView!
    @IBOutlet weak var tourName: UILabel!
    @IBOutlet weak var tourDetails: UILabel!
    @IBOutlet weak var tourRating: RatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configure(model: Tour?) {
        self.tourName.text = model?.title
        self.tourDetails.text = model?.description
        self.tourRating.cosmosView.rating = Double(model?.rating ?? 0.0)
        
        self.tourImg.image = UIImage(named: "photo")
        if let firstImage = model?.images?.first, let imageURLString = firstImage.imageURL, let imageURL = URL(string: imageURLString) {
            URLSession.shared.dataTask(with: imageURL) { [weak self] (data, _, error) in
                if let error = error {
                    print("Error downloading tour image: \(error.localizedDescription)")
                    return
                }
                
                if let imageData = data, let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.tourImg.image = image
                    }
                }
            }.resume()
        }
    }
    
    
    
}