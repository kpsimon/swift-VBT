//
//  GameCell.swift
//  SB-Vball
//
//  Created by Keoni Simon on 2/28/21.
//

import UIKit

class GameCell: UITableViewCell {
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height/5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
        // Configure the view for the selected state
    }
    
}
