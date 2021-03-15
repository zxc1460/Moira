//
//  ProfileEditViewController.swift
//  Moira
//
//  Created by Seok on 2021/03/08.
//

import UIKit
import TagListView

class ProfileEditViewController: BaseViewController {

    // MARK: IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var introduceTextField: UITextField!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var addEducationButton: UIButton!
    @IBOutlet weak var educationTableView: UITableView!
    @IBOutlet weak var addCareerButton: UIButton!
    @IBOutlet weak var careerTableView: UITableView!
    @IBOutlet weak var addCertificateButton: UIButton!
    @IBOutlet weak var certificateTableView: UITableView!
    @IBOutlet weak var addAwardsButton: UIButton!
    @IBOutlet weak var awardsTableView: UITableView!
    @IBOutlet weak var addLinkButton: UIButton!
    @IBOutlet weak var linkTableView: UITableView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var expandButton: UIButton!
    
    // MARK: Constraints
    @IBOutlet weak var educationTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var educationTableViewBottom: NSLayoutConstraint!
    @IBOutlet weak var careerTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var careerTableViewBottom: NSLayoutConstraint!
    @IBOutlet weak var awardsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var awardsTableViewBotton: NSLayoutConstraint!
    @IBOutlet weak var linkTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var linkTableViewBotton: NSLayoutConstraint!
    @IBOutlet weak var certificateTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var certificateTableViewBottom: NSLayoutConstraint!
    
    var educationData: [EducationInfo] = []
    var careerData: [CareerInfo] = []
    var certificateData: [CertificateInfo] = []
    var awardsData: [AwardsInfo] = []
    var linkData: [LinkInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTagListView()
        initButtons()
        initTableView()
        initTapGestureRecognizer()
        initOptionView()
        initExpandButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        resetTagListView()
        educationTableView.reloadData()
        careerTableView.reloadData()
        certificateTableView.reloadData()
        awardsTableView.reloadData()
        linkTableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        educationTableViewHeight.constant = educationTableView.contentSize.height
        educationTableViewBottom.constant = educationTableViewHeight.constant > 0 ? 20 : 0
        
        awardsTableViewHeight.constant = awardsTableView.contentSize.height
        awardsTableViewBotton.constant = awardsTableViewHeight.constant > 0 ? 20 : 0
        
        careerTableViewHeight.constant = careerTableView.contentSize.height
        careerTableViewBottom.constant = careerTableViewHeight.constant > 0 ? 20 : 0
        
        linkTableViewHeight.constant = linkTableView.contentSize.height
        linkTableViewBotton.constant = linkTableViewHeight.constant > 0 ? 20 : 0
        
        certificateTableViewHeight.constant = certificateTableView.contentSize.height
        certificateTableViewBottom.constant = certificateTableViewHeight.constant > 0 ? 20 : 0
    }
    
    @IBAction func expandButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            UIView.animate(withDuration: 1) {
                self.view.transform = CGAffineTransform.identity
            }
        } else {
            print("option view height: \(optionView.intrinsicContentSize.height)")
        }
    }
    
    
    func initTableView() {
        educationTableView.delegate = self
        educationTableView.dataSource = self
        educationTableView.separatorStyle = .none
        educationTableView.register(UINib(nibName: ProfileTextTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ProfileTextTableViewCell.reuseIdentifier)
        educationTableView.estimatedRowHeight = 35
        
        careerTableView.delegate = self
        careerTableView.dataSource = self
        careerTableView.separatorStyle = .none
        careerTableView.register(UINib(nibName: CareerTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CareerTableViewCell.reuseIdentifier)
        careerTableView.estimatedRowHeight = 60
        
        certificateTableView.delegate = self
        certificateTableView.dataSource = self
        certificateTableView.separatorStyle = .none
        certificateTableView.register(UINib(nibName: ProfileTextTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ProfileTextTableViewCell.reuseIdentifier)
        certificateTableView.estimatedRowHeight = 35
        
        awardsTableView.delegate = self
        awardsTableView.dataSource = self
        awardsTableView.separatorStyle = .none
        awardsTableView.register(UINib(nibName: ProfileTextTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ProfileTextTableViewCell.reuseIdentifier)
        awardsTableView.estimatedRowHeight = 35
        
        linkTableView.delegate = self
        linkTableView.dataSource = self
        linkTableView.separatorStyle = .none
        linkTableView.register(UINib(nibName: ProfileTextTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ProfileTextTableViewCell.reuseIdentifier)
        linkTableView.estimatedRowHeight = 35
        
    }
    
    func initTextField() {
        nicknameTextField.delegate = self
        positionTextField.delegate = self
        introduceTextField.delegate = self
    }
    
    func initButtons() {
        addEducationButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        addCareerButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        addCertificateButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        addAwardsButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        addLinkButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }
    
    func initTagListView() {
        
        tagListView.textFont = UIFont.AppleSDGothicNeo(.medium, size: 12)
        tagListView.alignment = .left
        
        tagListView.delegate = self
    }
    
    func initTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureOccured))
        
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.isEnabled = true
        tapGestureRecognizer.cancelsTouchesInView = false
        
        scrollView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func initOptionView() {
        optionView.clipsToBounds = true
    }
    
    func resetTagListView() {
        tagListView.removeAllTags()
        let tagView = tagListView.addTag("+ 추가하기")
        tagView.onTap = { tagView in
            let alert = UIAlertController(title: "태그를 입력하세요", message: nil, preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            let ok = UIAlertAction(title: "확인", style: .default) { (UIAlertAction) in
                if let text = alert.textFields?.first?.text {
                    self.tagListView.addTag(text)
                }
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(cancel)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func initExpandButton() {
        expandButton.setImage(UIImage(named: "btnDownArrow"), for: .normal)
        expandButton.setImage(UIImage(named: "btnUpArrow"), for: .selected)
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        switch sender {
        case addEducationButton:
            self.navigationController?.pushViewController(EducationEditViewController(delegate: self), animated: true)
        case addCareerButton:
            self.navigationController?.pushViewController(CareerEditViewController(delegate: self), animated: true)
        case addCertificateButton:
            self.navigationController?.pushViewController(CertifiicateEditViewController(delegate: self), animated: true)
        case addAwardsButton:
            self.navigationController?.pushViewController(AwardsEditViewController(delegate: self), animated: true)
        case addLinkButton:
            self.navigationController?.pushViewController(LinkEditViewController(delegate: self), animated: true)
        default:
            break
        }
    }
    
    @objc func tapGestureOccured() {
        print("tap gesutre occured")
        self.view.endEditing(true)
    }
}

extension ProfileEditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case educationTableView:
            return educationData.count
        case careerTableView:
            return careerData.count
        case certificateTableView:
            return certificateData.count
        case awardsTableView:
            return awardsData.count
        case linkTableView:
            return linkData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case educationTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTextTableViewCell.reuseIdentifier, for: indexPath) as? ProfileTextTableViewCell else {
                return UITableViewCell()
            }
            
            cell.updateUI(delegate: self, type: "education", index: indexPath.row, educationInfo: educationData[indexPath.row])
            
            return cell
        case careerTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CareerTableViewCell.reuseIdentifier, for: indexPath) as? CareerTableViewCell else {
                return UITableViewCell()
            }
            
            cell.updateUI(delegate: self, type: "career", index: indexPath.row, careerInfo: careerData[indexPath.row])
            
            return cell
        case certificateTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTextTableViewCell.reuseIdentifier, for: indexPath) as? ProfileTextTableViewCell else {
                return UITableViewCell()
            }
            
            cell.updateUI(delegate: self, type: "certificate", index: indexPath.row, certificateInfo: certificateData[indexPath.row])
            
            return cell
        case awardsTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTextTableViewCell.reuseIdentifier, for: indexPath) as? ProfileTextTableViewCell else {
                return UITableViewCell()
            }
            
            cell.updateUI(delegate: self, type: "award", index: indexPath.row, awardInfo: awardsData[indexPath.row])
            
            return cell
        case linkTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTextTableViewCell.reuseIdentifier, for: indexPath) as? ProfileTextTableViewCell else {
                return UITableViewCell()
            }
            
            cell.updateUI(delegate: self, type: "link", index: indexPath.row, linkInfo: linkData[indexPath.row])
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

extension ProfileEditViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("shoud return method called")
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileEditViewController: TagListViewDelegate {
}

extension ProfileEditViewController: EducationEditViewControllerDelegate, CareerEditViewControllerDelegate, CertifiicateEditViewControllerDelegate, AwardsEditViewControllerDelegate, LinkEditViewControllerDelegate {
    func setEducationInfo(info: EducationInfo) {
        self.educationData.append(info)
    }
    
    func setCareerInfo(info: CareerInfo) {
        self.careerData.append(info)
    }
    
    func setCertificateInfo(info: CertificateInfo) {
        self.certificateData.append(info)
    }
    
    func setAwardsInfo(info: AwardsInfo) {
        self.awardsData.append(info)
    }
    
    func setLinkInfo(info: LinkInfo) {
        self.linkData.append(info)
    }
}

extension ProfileEditViewController: ProfileTableViewCellDelteButtonDelegate {
    func deleteItem(type: String, index: Int) {
        switch type {
        case "education":
            print("삭제 버튼 클릭")
            educationData.remove(at: index)
            educationTableView.reloadData()
            self.viewWillLayoutSubviews()
        case "career":
            careerData.remove(at: index)
            careerTableView.reloadData()
            self.viewWillLayoutSubviews()
        case "certificate":
            certificateData.remove(at: index)
            certificateTableView.reloadData()
            self.viewWillLayoutSubviews()
        case "award":
            awardsData.remove(at: index)
            awardsTableView.reloadData()
            self.viewWillLayoutSubviews()
        case "link":
            linkData.remove(at: index)
            linkTableView.reloadData()
            self.viewWillLayoutSubviews()
        default:
            break
        }
    }
}
