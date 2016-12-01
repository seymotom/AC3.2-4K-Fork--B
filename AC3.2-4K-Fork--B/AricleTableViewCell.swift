//
//  AricleTableViewCell.swift
//  AC3.2-4K-Fork--B
//
//  Created by Tom Seymour on 12/1/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class AricleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var byLineLabel: UILabel!
    
    @IBOutlet weak var abstractLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
