//
//  MyTeamDetailViewController.swift
//  Moira
//
//  Created by Seok on 2021/03/03.
//

import UIKit

class MyTeamDetailViewController: BaseViewController {
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var teammateCountLabel: UILabel!
    @IBOutlet weak var teammateCollectionView: UICollectionView!
    @IBOutlet weak var teammateCollectionViewHeight: NSLayoutConstraint!
    
    let rightBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "iconInfo"), style: .plain, target: self, action: nil)
        button.tintColor = UIColor(hex: 0x6F6F6F)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initNavigationBar()
        initCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        teammateCollectionView.reloadData()
        let height = teammateCollectionView.collectionViewLayout.collectionViewContentSize.height
        teammateCollectionViewHeight.constant = height
        teammateCollectionView.layoutIfNeeded()
    }
    
    func initNavigationBar() {
        self.title = "팀 이름"
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func initCollectionView() {
        teammateCollectionView.delegate = self
        teammateCollectionView.dataSource = self
        teammateCollectionView.register(UINib(nibName: TeammateCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: TeammateCollectionViewCell.reuseIdentifier)
        
        
        if let layout = teammateCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 28, left: 20, bottom: 28, right: 20)
            layout.minimumLineSpacing = 20
            
        }
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

extension MyTeamDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeammateCollectionViewCell.reuseIdentifier, for: indexPath) as? TeammateCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == 0 {
            cell.showLeaderView(show: false)
        } else {
            cell.showLeaderView(show: true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = self.view.frame.width - layout.sectionInset.left - layout.sectionInset.right
        
        return CGSize(width: width, height: 94)
    }
    
    
}
