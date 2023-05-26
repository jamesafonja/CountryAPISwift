//
//  CountryCell.swift
//  CountryAPISwift
//
//  Created by James Afonja on 5/26/23.
//

import UIKit

class CountryCell: UITableViewCell {
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryCapitalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
