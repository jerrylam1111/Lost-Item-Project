//
//  MenuCell.swift
//  Lost Item Project
//
//  Created by Hei Lok Keith Kong on 14/9/2022.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var actionLabel: UILabel!
    
    let margin:CGFloat = -4
    
    func initializeActions(_ action: Action) {
        actionImage.image = action.image?.withAlignmentRectInsets(UIEdgeInsets(top: margin, left: margin * 4, bottom: margin, right: margin))
        actionLabel.text = action.name
    }
}
