//
//  CertifiicateEditViewController.swift
//  Moira
//
//  Created by Seok on 2021/03/09.
//

import UIKit

protocol CertifiicateEditViewControllerDelegate: class {
    func setCertificateInfo(info: CertificateInfo)
}

class CertifiicateEditViewController: BaseViewController {

    @IBOutlet weak var certificateTextField: UITextField!
    @IBOutlet weak var certificateBorder: UIView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dateBorder: UIView!
    
    @IBOutlet weak var certificateBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var dateBorderHeight: NSLayoutConstraint!
    
    let datePicker = UIDatePicker()
    let toolBar = UIToolbar()
    let pickerDoneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(pickerDone(sender:)))
    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    let pickerCancelButton = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(pickerCancel(sender:)))
    
    let certificateInfo: CertificateInfo?
    weak var delegate: CertifiicateEditViewControllerDelegate?
    
    init(info: CertificateInfo = CertificateInfo(), delegate: CertifiicateEditViewControllerDelegate? = nil) {
        self.certificateInfo = info
        self.delegate = delegate
        super.init(nibName: "CertifiicateEditViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "자격증 추가하기"
        initBarButtonItem()
        initTextField()
        initDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        if let info = certificateInfo {
            certificateTextField.text = info.certificate
            dateTextField.text = info.date
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
        certificateTextField.clearButtonMode = .unlessEditing
        dateTextField.clearButtonMode = .unlessEditing
        
        certificateTextField.delegate = self
        dateTextField.delegate = self
        
        dateTextField.tintColor = .clear
    }
    
    func initDatePicker() {
        datePicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 230)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(pickerValueChanged(sender:)), for: .valueChanged)
        
        dateTextField.inputView = datePicker
        
        toolBar.sizeToFit()
        toolBar.barStyle = .default
        toolBar.backgroundColor = .white
        toolBar.barTintColor = .white
        toolBar.setItems([pickerCancelButton, space, pickerDoneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        dateTextField.inputAccessoryView = toolBar
    }
    
    
    @objc func editButtonClicked(sender: UIBarButtonItem) {
        if let certificate = certificateTextField.text, let date = dateTextField.text, certificate != "", date != "" {
            let info = CertificateInfo(certificate: certificate, date: date)
            self.delegate?.setCertificateInfo(info: info)
            self.navigationController?.popViewController(animated: true)
        } else {
            self.presentAlert(title: "입력이 완료되지 않았습니다")
        }
    }
    
    @objc func pickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func pickerDone(sender: UIBarButtonItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        dateTextField.resignFirstResponder()
    }
    
    @objc func pickerCancel(sender: UIBarButtonItem) {
        dateTextField.resignFirstResponder()
    }
}

extension CertifiicateEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case certificateTextField:
            certificateBorder.backgroundColor = UIColor(hex: 0x0066FF)
            certificateBorderHeight.constant = 2.5
        case dateTextField:
            dateBorder.backgroundColor = UIColor(hex: 0x0066FF)
            dateBorderHeight.constant = 2.5
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case certificateTextField:
            certificateBorder.backgroundColor = UIColor(hex: 0xC1C1C1)
            certificateBorderHeight.constant = 1
        case dateTextField:
            dateBorder.backgroundColor = UIColor(hex: 0xC1C1C1)
            dateBorderHeight.constant = 1
        default:
            break
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = nil
        textField.resignFirstResponder()
        return false
    }
}
