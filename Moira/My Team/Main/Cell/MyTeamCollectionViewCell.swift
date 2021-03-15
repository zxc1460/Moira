//
//  MyTeamCollectionViewCell.swift
//  Moira
//
//  Created by Seok on 2021/03/01.
//

import UIKit

class MyTeamCollectionViewCell: UICollectionViewCell {
    static let nibName = "MyTeamCollectionViewCell"
    static let reuseIdentifier = "MyTeamCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teammateCountLabel: UILabel!
    @IBOutlet weak var evaluateButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
