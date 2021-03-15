//
//  MyTeamEvaluateViewController.swift
//  Moira
//
//  Created by Seok on 2021/03/03.
//

import UIKit
import Cosmos

class MyTeamEvaluateViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var starRatingControl: CosmosView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewTextField: UITextView!
    @IBOutlet weak var badgeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func initStarRatingControl() {
        starRatingControl.rating = 3
        starRatingControl.settings.fillMode = .half
        starRatingControl.settings.starMargin = (Double(starRatingControl.frame.width) / 5.0) - starRatingControl.settings.starSize + 3.0
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
