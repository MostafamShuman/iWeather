//
//  CityItemTableViewCell.swift
//  iWeather
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import UIKit

class CityItemTableViewCell: UITableViewCell {

    static let identifier = "CityItemTableViewCell"
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
        self.iconImageView.image = nil
    }
    
    
    func config(city: UICity) {
        self.titleLabel.text = city.title
        self.subtitleLabel.text = city.subtitle
        self.iconImageView.image = UIImage(named: city.image)
    }
    
}
