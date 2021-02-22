//
//  RestaurantCell.swift
//  TestAppUIKit
//
//  Created by Bhaskar on 12/1/20.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtextLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /**
     Configures the appearance of the Table view cell
     */
    func configure() {
        statusLabel.layer.borderWidth = 1.0
        statusLabel.layer.borderColor = UIColor.green.cgColor
        statusLabel.layer.cornerRadius = 3.0
    }
}
