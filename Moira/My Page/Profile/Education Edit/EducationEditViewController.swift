//
//  EducationEditViewController.swift
//  Moira
//
//  Created by Seok on 2021/03/09.
//

import UIKit

protocol EducationEditViewControllerDelegate: class {
    func setEducationInfo(info: EducationInfo)
}

class EducationEditViewController: BaseViewController {
    
    
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var schoolNameBorder: UIView!
    @IBOutlet weak var majorTextField: UITextField!
    @IBOutlet weak var majorBorder: UIView!
    @IBOutlet weak var entranceTextField: UITextField!
    @IBOutlet weak var entranceBorder: UIView!
    @IBOutlet weak var graduateTextField: UITextField!
    @IBOutlet weak var graduateBorder: UIView!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var stateBorder: UIView!
    
    @IBOutlet weak var schoolNameBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var majorBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var entranceBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var graduateBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var stateBorderHeight: NSLayoutConstraint!

    let entrancePickerView = UIPickerView()
    let graduatePickerView = UIPickerView()
    
    let entranceDoneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(pickerDone(sender:)))
    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    let entranceCancelButton = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(pickerCancel(sender:)))
    
    let graduateDoneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(pickerDone(sender:)))
    let graduateCancelButton = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(pickerCancel(sender:)))
    
    
    
    let educationInfo: EducationInfo?
    weak var delegate: EducationEditViewControllerDelegate?
    let years = (2000...Calendar.current.component(.year, from: Date())).reversed().compactMap { String($0) }
    let months = (1...12).compactMap { String($0) }
    var selectedYear = ""
    var selectedMonth = ""
    
    init(info: EducationInfo = EducationInfo(), delegate: EducationEditViewControllerDelegate? = nil) {
        self.educationInfo = info
        self.delegate = delegate
        super.init(nibName: "EducationEditViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "학력 추가하기"
        
        let button = UIBarButtonItem(title: "등록하기", style: .done, target: self, action: #selector(editButtonClicked(sender:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.AppleSDGothicNeo(.regular, size: 18)], for: .normal)
        button.tintColor = UIColor(hex: 0x767676)
        
        self.navigationItem.rightBarButtonItem = button
        initTextField()
        initPickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        if let info = educationInfo {
            schoolNameTextField.text = info.name
            majorTextField.text = info.major
            entranceTextField.text = info.entranceDate
            graduateTextField.text = info.graduateDate
            stateTextField.text = info.state
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func editButtonClicked(sender: UIBarButtonItem) {
        print("edit button clicked")
        
        if let name = schoolNameTextField.text, let major = majorTextField.text, let entrance = entranceTextField.text, let state = stateTextField.text, name != "", major != "", entrance != "", state != "" {
            if state == "졸업" {
                if let graduate = graduateTextField.text, graduate != "" {
                    let info = EducationInfo(name: name, major: major, entranceDate: entrance, graduateDate: graduate, state: state)
                    self.delegate?.setEducationInfo(info: info)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.presentAlert(title: "입력이 완료되지 않았습니다")
                }
            } else {
                let info = EducationInfo(name: name, major: major, entranceDate: entrance, state: state)
                self.delegate?.setEducationInfo(info: info)
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            self.presentAlert(title: "입력이 완료되지 않았습니다")
        }
    }
    
    @objc func pickerDone(sender: UIBarButtonItem) {
        switch sender {
        case entranceDoneButton:
            entranceTextField.text = "\(years[entrancePickerView.selectedRow(inComponent: 0)]) / \(months[entrancePickerView.selectedRow(inComponent: 1)])"
            entranceTextField.resignFirstResponder()
        case graduateDoneButton:
            graduateTextField.text = "\(years[graduatePickerView.selectedRow(inComponent: 0)]) / \(months[graduatePickerView.selectedRow(inComponent: 1)])"
            graduateTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    @objc func pickerCancel(sender: UIBarButtonItem) {
        switch sender {
        case entranceCancelButton:
            selectedYear = ""
            selectedMonth = ""
            entranceTextField.resignFirstResponder()
        case graduateCancelButton:
            selectedYear = ""
            selectedMonth = ""
            graduateTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    func initTextField() {
        schoolNameTextField.clearButtonMode = .unlessEditing
        majorTextField.clearButtonMode = .unlessEditing
        entranceTextField.clearButtonMode = .unlessEditing
        graduateTextField.clearButtonMode = .unlessEditing
        stateTextField.clearButtonMode = .unlessEditing
        
        schoolNameTextField.delegate = self
        majorTextField.delegate = self
        entranceTextField.delegate = self
        graduateTextField.delegate = self
        stateTextField.delegate = self
        
        entranceTextField.tintColor = .clear
        graduateTextField.tintColor = .clear
        stateTextField.tintColor = .clear
        
        let emptyView = UIView()
        emptyView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        stateTextField.inputView = emptyView
    }
    
    func initPickerView() {
        entrancePickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 230)
        graduatePickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 230)
        
        entrancePickerView.delegate = self
        entrancePickerView.dataSource = self
        graduatePickerView.delegate = self
        graduatePickerView.delegate = self
        entranceTextField.inputView = entrancePickerView
        graduateTextField.inputView = graduatePickerView
        
        entrancePickerView.backgroundColor = .white
        graduatePickerView.backgroundColor = .white
        
        let entranceToolbar = UIToolbar()
        
        entranceToolbar.sizeToFit()
        entranceToolbar.barStyle = .default
        entranceToolbar.backgroundColor = .white
        entranceToolbar.barTintColor = .white
        entranceToolbar.setItems([entranceCancelButton, space, entranceDoneButton], animated: true)
        entranceToolbar.isUserInteractionEnabled = true
        
        entranceTextField.inputAccessoryView = entranceToolbar
        
        let graduateToolbar = UIToolbar()
        graduateToolbar.sizeToFit()
        graduateToolbar.barStyle = .default
        graduateToolbar.backgroundColor = .white
        graduateToolbar.barTintColor = .white
        graduateToolbar.setItems([graduateCancelButton, space, graduateDoneButton], animated: true)
        graduateToolbar.isUserInteractionEnabled = true
        
        graduateTextField.inputAccessoryView = graduateToolbar
    }

}

extension EducationEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case schoolNameTextField:
            schoolNameBorder.backgroundColor = UIColor(hex: 0x0066FF)
            schoolNameBorderHeight.constant = 2.5
        case majorTextField:
            majorBorder.backgroundColor = UIColor(hex: 0x0066FF)
            majorBorderHeight.constant = 2.5
        case entranceTextField:
            entranceBorder.backgroundColor = UIColor(hex: 0x0066FF)
            entranceBorderHeight.constant = 2.5
        case graduateTextField:
            graduateBorder.backgroundColor = UIColor(hex: 0x0066FF)
            graduateBorderHeight.constant = 2.5
        case stateTextField:
            stateBorder.backgroundColor = UIColor(hex: 0x0066FF)
            stateBorderHeight.constant = 2.5
            
            let statePopUpVC = StatePopUpViewController(delegate: self)
            statePopUpVC.modalPresentationStyle = .overCurrentContext
            self.present(statePopUpVC, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case schoolNameTextField:
            schoolNameBorder.backgroundColor = UIColor(hex: 0xC1C1C1)
            schoolNameBorderHeight.constant = 1
        case majorTextField:
            majorBorder.backgroundColor = UIColor(hex: 0xC1C1C1)
            majorBorderHeight.constant = 1
        case entranceTextField:
            entranceBorder.backgroundColor = UIColor(hex: 0xC1C1C1)
            entranceBorderHeight.constant = 1
        case graduateTextField:
            graduateBorder.backgroundColor = UIColor(hex: 0xC1C1C1)
            graduateBorderHeight.constant = 1
        case stateTextField:
            stateBorder.backgroundColor = UIColor(hex: 0xC1C1C1)
            stateBorderHeight.constant = 1
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

extension EducationEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return years.count
        } else {
            return months.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return years[row]
        } else {
            return months[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case entrancePickerView:
            if component == 0 {
                selectedYear = "\(years[row]) / "
            } else {
                selectedMonth = months[row]
            }
            
            entranceTextField.text = selectedYear + selectedMonth
        case graduatePickerView:
            if component == 0 {
                selectedYear = "\(years[row]) / "
            } else {
                selectedMonth = months[row]
            }
            
            graduateTextField.text = selectedYear + selectedMonth
        default:
            return
        }
    }
}

extension EducationEditViewController: StatePopUpViewControllerDelegate {
    func stateButtonClicked(state: String) {
        self.stateTextField.text = state
        self.stateTextField.resignFirstResponder()
    }
    
    func cancelButtonClicked() {
        self.stateTextField.resignFirstResponder()
    }
    
    
}
