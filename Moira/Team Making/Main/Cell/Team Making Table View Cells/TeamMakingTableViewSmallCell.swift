//
//  TeamMakingTableViewSmallCell.swift
//  Moira
//
//  Created by Seok on 2021/02/28.
//

import UIKit
import TagListView

class TeamMakingTableViewSmallCell: UITableViewCell {
    static let nibName = "TeamMakingTableViewSmallCell"
    static let reuseIdentifier = "TeamMakingTableViewSmallCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewerLabel: UILabel!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var tagListViewTopMargin: NSLayoutConstraint!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tagListView.textFont = .AppleSDGothicNeo(.regular, size: 8)
        tagListView.alignment = .leading
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
