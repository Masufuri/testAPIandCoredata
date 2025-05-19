//
//  HomeTableViewCell.swift
//  test2
//
//  Created by User1 on 10/05/2025.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet var lbTitle:UILabel!
    @IBOutlet var lbDate:UILabel!
    @IBOutlet var lbDesc:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //reset data
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
