//
//  TeammateCollectionViewCell.swift
//  Moira
//
//  Created by Seok on 2021/03/03.
//

import UIKit

class TeammateCollectionViewCell: UICollectionViewCell {
    static let nibName = "TeammateCollectionViewCell"
    static let reuseIdentifier = "TeammateCollectionViewCell"

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var leaderView: UIView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var nicknameLabelLeadingConstant: NSLayoutConstraint! // if hide ? 0 : 5
    @IBOutlet weak var leaderViewWidth: NSLayoutConstraint! // if hide ? 0 : 38
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showLeaderView(show: Bool) {
        leaderView.isHidden = show
        for subView in leaderView.subviews {
            subView.isHidden = show
        }
        
        leaderViewWidth.constant = show ? 0 : 38
        nicknameLabelLeadingConstant.constant = show ? 0 : 5
    }

}
