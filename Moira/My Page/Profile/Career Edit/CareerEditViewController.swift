//
//  CareerEditViewController.swift
//  Moira
//
//  Created by Seok on 2021/03/09.
//

import UIKit

protocol CareerEditViewControllerDelegate: class {
    func setCareerInfo(info: CareerInfo)
}

class CareerEditViewController: BaseViewController {

    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var companyBorder: UIView!
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var jobBorder: UIView!
    @IBOutlet weak var joinDateTextField: UITextField!
    @IBOutlet weak var joinDateBorder: UIView!
    @IBOutlet weak var resignDateTextField: UITextField!
    @IBOutlet weak var resignDateBorder: UIView!
    
    @IBOutlet weak var companyBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var jobBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var joinDateBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var resignDateBorderHeight: NSLayoutConstraint!
    
    let joinPickerView = UIPickerView()
    let resignPickerView = UIPickerView()
    
    let joinDoneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(pickerDone(sender:)))
    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    let joinCancelButton = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(pickerCancel(sender:)))
    
    let resignDoneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(pickerDone(sender:)))
    let resignCancelButton = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(pickerCancel(sender:)))
    
    let careerInfo: CareerInfo?
    weak var delegate: CareerEditViewControllerDelegate?
    let years = (2000...Calendar.current.component(.year, from: Date())).reversed().compactMap { String($0) }
    let months = (1...12).compactMap { String($0) }
    var selectedYear = ""
    var selectedMonth = ""
    
    init(info: CareerInfo = CareerInfo(), delegate: CareerEditViewControllerDelegate? = nil) {
        self.careerInfo = info
        self.delegate = delegate
        super.init(nibName: "CareerEditViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "경력 추가하기"
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
        
        if let info = careerInfo {
            companyTextField.text = info.company
            jobTextField.text = info.job
            joinDateTextField.text = info.joinDate
            resignDateTextField.text = info.resignDate
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @objc func editButtonClicked(sender: UIBarButtonItem) {
        if let company = companyTextField.text, let job = jobTextField.text, let joinDate = joinDateTextField.text, let resignDate = resignDateTextField.text, company != "", job != "", resignDate != "", joinDate != "" {
            self.delegate?.setCareerInfo(info: CareerInfo(company: company, job: job, joinDate: joinDate, resignDate: resignDate))
            self.navigationController?.popViewController(animated: true)
        } else {
            self.presentAlert(title: "입력이 완료되지 않았습니다")
        }
        
    }
    
    @objc func pickerDone(sender: UIBarButtonItem) {
        switch sender {
        case joinDoneButton:
            joinDateTextField.text = "\(years[joinPickerView.selectedRow(inComponent: 0)]) / \(months[joinPickerView.selectedRow(inComponent: 1)])"
            joinDateTextField.resignFirstResponder()
        case resignDoneButton:
            resignDateTextField.text = "\(years[resignPickerView.selectedRow(inComponent: 0)]) / \(months[resignPickerView.selectedRow(inComponent: 1)])"
            resignDateTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    @objc func pickerCancel(sender: UIBarButtonItem) {
        switch sender {
        case joinCancelButton:
            selectedYear = ""
            selectedMonth = ""
            joinDateTextField.resignFirstResponder()
        case resignCancelButton:
            selectedYear = ""
            selectedMonth = ""
            resignDateTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    func initTextField() {
        companyTextField.clearButtonMode = .unlessEditing
        jobTextField.clearButtonMode = .unlessEditing
        joinDateTextField.clearButtonMode = .unlessEditing
        resignDateTextField.clearButtonMode = .unlessEditing
        
        companyTextField.delegate = self
        jobTextField.delegate = self
        joinDateTextField.delegate = self
        resignDateTextField.delegate = self
        
        joinDateTextField.tintColor = .clear
        resignDateTextField.tintColor = .clear
    }
    
    func initPickerView() {
        joinPickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 230)
        resignPickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 230)
        
        joinPickerView.delegate = self
        joinPickerView.dataSource = self
        resignPickerView.delegate = self
        resignPickerView.delegate = self
        joinDateTextField.inputView = joinPickerView
        resignDateTextField.inputView = resignPickerView
        
        joinPickerView.backgroundColor = .white
        resignPickerView.backgroundColor = .white
        
        let joinToolbar = UIToolbar()
        
        joinToolbar.sizeToFit()
        joinToolbar.barStyle = .default
        joinToolbar.backgroundColor = .white
        joinToolbar.barTintColor = .white
        joinToolbar.setItems([joinCancelButton, space, joinDoneButton], animated: true)
        joinToolbar.isUserInteractionEnabled = true
        
        joinDateTextField.inputAccessoryView = joinToolbar
        
        let resignToolbar = UIToolbar()
        resignToolbar.sizeToFit()
        resignToolbar.barStyle = .default
        resignToolbar.backgroundColor = .white
        resignToolbar.barTintColor = .white
        resignToolbar.setItems([resignCancelButton, space, resignDoneButton], animated: true)
        resignToolbar.isUserInteractionEnabled = true
        
        resignDateTextField.inputAccessoryView = resignToolbar
    }
}

extension CareerEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case companyTextField:
            companyBorder.backgroundColor = UIColor(hex: 0x0066FF)
            companyBorderHeight.constant = 2.5
        case jobTextField:
            jobBorder.backgroundColor = UIColor(hex: 0x0066FF)
            jobBorderHeight.constant = 2.5
        case joinDateTextField:
            joinDateBorder.backgroundColor = UIColor(hex: 0x0066FF)
            joinDateBorderHeight.constant = 2.5
        case resignDateTextField:
            resignDateBorder.backgroundColor = UIColor(hex: 0x0066FF)
            resignDateBorderHeight.constant = 2.5
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case companyTextField:
            companyBorder.backgroundColor = UIColor(hex: 0xC1C1C1)
            companyBorderHeight.constant = 1
        case jobTextField:
            jobBorder.backgroundColor = UIColor(hex: 0xC1C1C1)
            jobBorderHeight.constant = 1
        case joinDateTextField:
            joinDateBorder.backgroundColor = UIColor(hex: 0xC1C1C1)
            joinDateBorderHeight.constant = 1
        case resignDateTextField:
            resignDateBorder.backgroundColor = UIColor(hex: 0xC1C1C1)
            resignDateBorderHeight.constant = 1
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

extension CareerEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        case joinPickerView:
            if component == 0 {
                selectedYear = "\(years[row]) / "
            } else {
                selectedMonth = months[row]
            }
            
            joinDateTextField.text = selectedYear + selectedMonth
        case resignPickerView:
            if component == 0 {
                selectedYear = "\(years[row]) / "
            } else {
                selectedMonth = months[row]
            }
            
            resignDateTextField.text = selectedYear + selectedMonth
        default:
            return
        }
    }
    
}
