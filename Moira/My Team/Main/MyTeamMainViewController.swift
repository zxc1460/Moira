//
//  MyTeamMainViewController.swift
//  Moira
//
//  Created by Seok on 2021/03/01.
//

import UIKit

class MyTeamMainViewController: BaseViewController {

    @IBOutlet weak var progressTeamButton: UIButton!
    @IBOutlet weak var finishTeamButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBAction func progressTeamButtonClicked(_ sender: Any) {
        if !progressTeamButton.isSelected {
            progressTeamButton.isSelected.toggle()
        }
        
        if progressTeamButton.isSelected && finishTeamButton.isSelected {
            finishTeamButton.isSelected.toggle()
        }
    }
    
    @IBAction func finishTeamButtonClicked(_ sender: Any) {
        if !finishTeamButton.isSelected {
            finishTeamButton.isSelected.toggle()
        }
        
        if finishTeamButton.isSelected && progressTeamButton.isSelected {
            progressTeamButton.isSelected.toggle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
        initCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
        
//        collectionView.reloadData()
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeight.constant = height
        collectionView.layoutIfNeeded()
    }
    
    func initViews() {
        progressTeamButton.setTitleColor(.black, for: .selected)
        progressTeamButton.setTitleColor(UIColor(hex: 0x8E8E8E), for: .normal)
        progressTeamButton.tintColor = .clear
        finishTeamButton.setTitleColor(.black, for: .selected)
        finishTeamButton.setTitleColor(UIColor(hex: 0x8E8E8E), for: .normal)
        finishTeamButton.tintColor = .clear
        
        progressTeamButton.isSelected = true
        finishTeamButton.isSelected = false
    }
    
    func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: MyTeamCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MyTeamCollectionViewCell.reuseIdentifier)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 28, left: 20, bottom: 28, right: 20)
            layout.minimumInteritemSpacing = 15
            layout.minimumLineSpacing = 20
        }
    }

}

extension MyTeamMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyTeamCollectionViewCell.reuseIdentifier, for: indexPath) as? MyTeamCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = self.view.frame.width - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing
        
        return CGSize(width: width / 2, height: 245)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 28, left: 20, bottom: 28, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(MyTeamDetailViewController(), animated: true)
    }
}
