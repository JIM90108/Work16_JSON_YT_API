//
//  MusicTableViewCell.swift
//  Work16_JSON_YT_API
//
//  Created by 彭有駿 on 2022/5/5.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    @IBOutlet weak var musicImageView: UIImageView!
    
    @IBOutlet weak var musicName: UILabel!
    
    @IBOutlet weak var musicDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
