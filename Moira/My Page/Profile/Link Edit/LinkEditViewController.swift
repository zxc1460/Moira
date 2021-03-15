//
//  LinkEditViewController.swift
//  Moira
//
//  Created by Seok on 2021/03/09.
//

import UIKit

protocol LinkEditViewControllerDelegate: class {
    func setLinkInfo(info: LinkInfo)
}

class LinkEditViewController: UIViewController {
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var urlBorder: UIView!
    @IBOutlet weak var urlBorderHeight: NSLayoutConstraint!
    
    let linkInfo: LinkInfo?
    weak var delegate: LinkEditViewControllerDelegate?
    
    init(info: LinkInfo = LinkInfo(), delegate: LinkEditViewControllerDelegate? = nil) {
        self.linkInfo = info
        self.delegate = delegate
        super.init(nibName: "LinkEditViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "링크 추가하기"
        initBarButtonItem()
        initTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        if let info = linkInfo {
            urlTextField.text = info.url
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func initBarButtonItem() {
        let button = UIBarButtonItem(title: "등록하기", style: .done, target: self, action: #selector(editButtonClicked(sender:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.AppleSDGothicNeo(.regular, size: 18)], for: .normal)
        button.tintColor = UIColor(hex: 0x767676)
        
        self.navigationItem.rightBarButtonItem = button
    }
    
    func initTextField() {
        urlTextField.clearButtonMode = .unlessEditing
        
        urlTextField.delegate = self
    }
    
    @objc func editButtonClicked(sender: UIBarButtonItem) {
        if let url = urlTextField.text, url != "" {
            let info = LinkInfo(url: url)
            self.delegate?.setLinkInfo(info: info)
            self.navigationController?.popViewController(animated: true)
        } else {
            self.presentAlert(title: "입력이 완료되지 않았습니다")
        }
    }

}

extension LinkEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        urlBorder.backgroundColor = UIColor(hex: 0x0066FF)
        urlBorderHeight.constant = 2.5
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        urlBorder.backgroundColor = UIColor(hex: 0xC1C1C1)
        urlBorderHeight.constant = 1
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = nil
        textField.resignFirstResponder()
        return false
    }
}
