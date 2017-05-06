//
//  SampleTableViewCell.swift
//  ExpandingCellTransition
//
//  Created by MuronakaHiroaki on 2017/05/05.
//  Copyright © 2017年 MuronakaHiroaki. All rights reserved.
//

import UIKit

class SampleTableViewCell: UITableViewCell {
    
    @IBOutlet var numberLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
