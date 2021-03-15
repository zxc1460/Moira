//
//  TeamMakingViewController.swift
//  Moira
//
//  Created by Seok on 2021/02/27.
//

import UIKit
import TagListView

class TeamMakingViewController: BaseViewController {
    
    @IBOutlet weak var articleButton: UIButton!
    @IBOutlet weak var humanPoolButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    let tags: [String] = ["태그", "태그", "내 관심 태그", "내 관심 태그", "내 관심 태그", "내 관심 태그", "내 관심 태그", "내 관심 태그", "내 관심 태그", "내 관심 태그", "내 관심 태그", "내 관심 태그", "내 관심 태그", "내 관심 태그", "내 관심 태그", "내 관심 태그", "내 관심 태그"]
    var titleText = "두 줄 짜리 제목입니다. 두 줄 짜리 제목입니다. 두줄 짜리 "
    
    @IBAction func articleButtonClicked(_ sender: Any) {
        if !articleButton.isSelected {
            articleButton.isSelected.toggle()
        }
        
        if articleButton.isSelected && humanPoolButton.isSelected {
            humanPoolButton.isSelected.toggle()
        }
    }
    
    @IBAction func humanPoolButtonClicked(_ sender: Any) {
        if !humanPoolButton.isSelected {
            humanPoolButton.isSelected.toggle()
        }
        
        if humanPoolButton.isSelected && articleButton.isSelected {
            articleButton.isSelected.toggle()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initViews()
        initTagListView()
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
        tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        tagListView.removeAllTags()
        tagListView.addTags(tags)
        
        tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            UIView.performWithoutAnimation {
                self?.tableView.beginUpdates()
                self?.tableView.endUpdates()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if change?[.newKey] != nil {
                tableViewHeight.constant = tableView.contentSize.height
            }
        }
    }
    
    func initViews() {
        articleButton.setTitleColor(.black, for: .selected)
        articleButton.setTitleColor(UIColor(hex: 0x8E8E8E), for: .normal)
        articleButton.tintColor = .clear
        humanPoolButton.setTitleColor(.black, for: .selected)
        humanPoolButton.setTitleColor(UIColor(hex: 0x8E8E8E), for: .normal)
        humanPoolButton.tintColor = .clear
        
        articleButton.isSelected = true
        humanPoolButton.isSelected = false
    }
    
    
    func initTagListView() {
        tagListView.delegate = self
        
        tagListView.textFont = UIFont.AppleSDGothicNeo(.medium, size: 10)
        tagListView.alignment = .left
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TeamMakingTableViewLargeCell.nibName, bundle: nil), forCellReuseIdentifier: TeamMakingTableViewLargeCell.reuseIdentifier)
        tableView.register(UINib(nibName: TeamMakingTableViewSmallCell.nibName, bundle: nil), forCellReuseIdentifier: TeamMakingTableViewSmallCell.reuseIdentifier)
    
        tableView.estimatedRowHeight = 123
        tableView.separatorInset = .zero
    
    }
}

extension TeamMakingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamMakingTableViewLargeCell.reuseIdentifier, for: indexPath) as? TeamMakingTableViewLargeCell else {
                return UITableViewCell()
            }
            cell.titleLabel.text = titleText
            cell.updateTags(tags: tags)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamMakingTableViewSmallCell.reuseIdentifier, for: indexPath) as? TeamMakingTableViewSmallCell else {
                return UITableViewCell()
            }
            cell.updateTags(tags: tags)


            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }    
}

extension TeamMakingViewController: TagListViewDelegate {
}
