//
//  VenuesTableViewCell.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import UIKit

class VenuesTableViewCell: UITableViewCell {
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeTitle: UILabel!
    
    public var place: Place? {
        didSet {
            self.placeImage.load(with: place?.imageURL ?? "")
            placeTitle.text = place?.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        placeImage.clipsToBounds = true
        placeImage.layer.cornerRadius = 3
    }
    override func prepareForReuse() {
        placeImage.image = UIImage()
    }

}
