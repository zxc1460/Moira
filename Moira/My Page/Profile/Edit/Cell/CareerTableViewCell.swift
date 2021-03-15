//
//  CareerTableViewCell.swift
//  Moira
//
//  Created by Seok on 2021/03/09.
//

import UIKit

class CareerTableViewCell: UITableViewCell {
    static let nibName = "CareerTableViewCell"
    static let reuseIdentifier = "CareerTableViewCell"

    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var delegate: ProfileTableViewCellDelteButtonDelegate?
    var index: Int?
    var type: String?
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        if let index = index, let type = type {
            self.delegate?.deleteItem(type: type, index: index)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(delegate: ProfileTableViewCellDelteButtonDelegate?, type: String, index: Int, careerInfo: CareerInfo) {
        self.delegate = delegate
        self.type = type
        self.index = index
        
        self.companyLabel.text = careerInfo.company
        
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = "yyyy / MM"
        let toDateFormatter = DateFormatter()
        toDateFormatter.dateFormat = "yyyy.MM"
        
        var dateText = ""
        if let joinDate = careerInfo.joinDate, let date = fromDateFormatter.date(from: joinDate) {
            dateText += toDateFormatter.string(from: date)
        }
        
        if let resignDate = careerInfo.resignDate, let date = fromDateFormatter.date(from: resignDate) {
            dateText += "~\(toDateFormatter.string(from: date))"
        }
        
        dateLabel.text = dateText
    }
    
}
