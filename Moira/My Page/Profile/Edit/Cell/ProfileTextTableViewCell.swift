//
//  ProfileTextTableViewCell.swift
//  Moira
//
//  Created by Seok on 2021/03/09.
//

import UIKit

protocol ProfileTableViewCellDelteButtonDelegate: class {
    func deleteItem(type: String, index: Int)
}

class ProfileTextTableViewCell: UITableViewCell {
    static let nibName = "ProfileTextTableViewCell"
    static let reuseIdentifier = "ProfileTextTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func deleteButtonClicked(_ sender: Any) {
        if let index = index, let type = type {
            self.delegate?.deleteItem(type: type, index: index)
        }
    }
    
    weak var delegate: ProfileTableViewCellDelteButtonDelegate?
    var index: Int?
    var type: String?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(delegate: ProfileTableViewCellDelteButtonDelegate?, type: String, index: Int, educationInfo: EducationInfo) {
        self.delegate = delegate
        self.type = type
        self.index = index
        
        self.titleLabel.text = educationInfo.name
    }
    
    
    func updateUI(delegate: ProfileTableViewCellDelteButtonDelegate?, type: String, index: Int, certificateInfo: CertificateInfo) {
        self.delegate = delegate
        self.type = type
        self.index = index
        
        self.titleLabel.text = certificateInfo.certificate
    }
    
    func updateUI(delegate: ProfileTableViewCellDelteButtonDelegate?, type: String, index: Int, awardInfo: AwardsInfo) {
        self.delegate = delegate
        self.type = type
        self.index = index
        
        self.titleLabel.text = awardInfo.award
    }
    
    func updateUI(delegate: ProfileTableViewCellDelteButtonDelegate?, type: String, index: Int, linkInfo: LinkInfo) {
        self.delegate = delegate
        self.type = type
        self.index = index
        
        self.titleLabel.text = linkInfo.url
    }
    
}
