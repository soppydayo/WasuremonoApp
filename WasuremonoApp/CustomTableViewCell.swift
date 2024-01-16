//
//  CustomTableViewCell.swift
//  WasuremonoApp
//
//  Created by 白川創大 on 2024/01/12.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var textFieldLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
