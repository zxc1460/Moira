//
//  TeamMakingTableViewLargeCell.swift
//  Moira
//
//  Created by Seok on 2021/02/28.
//

import UIKit
import TagListView
import TTGTagCollectionView

class TeamMakingTableViewLargeCell: UITableViewCell {
    static let nibName = "TeamMakingTableViewLargeCell"
    static let reuseIdentifier = "TeamMakingTableViewLargeCell"

    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nicNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewerLabel: UILabel!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var tagListViewTopMargin: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tagListView.alignment = .leading
        tagListView.textFont = UIFont.AppleSDGothicNeo(.regular, size: 8)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateTags(tags: [String]?) {
        tagListView.removeAllTags()
        
        if let tags = tags, tags.count > 0 {
            tagListViewTopMargin.constant = 9
            tagListView.addTags(tags)
        } else {
            tagListViewTopMargin.constant = 0
        }
        
        tagListView.layoutIfNeeded()
    }
    
}
