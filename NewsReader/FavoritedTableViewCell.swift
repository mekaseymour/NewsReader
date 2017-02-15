//
//  FavoritedTableViewCell.swift
//  NewsReader
//
//  Created by Meka Seymour on 2/14/17.
//  Copyright © 2017 Meka Seymour. All rights reserved.
//

import UIKit

class FavoritedTableViewCell: UITableViewCell {

    @IBOutlet weak var urlLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
