//
//  SearchResultTableViewCell.swift
//  Yelp
//
//  Created by Alex Choi on 9/20/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var businessNameLabelView: UILabel!
    @IBOutlet weak var addressLabelView: UILabel!
    @IBOutlet weak var categoriesLabelView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
