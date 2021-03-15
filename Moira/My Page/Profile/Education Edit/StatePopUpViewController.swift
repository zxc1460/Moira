//
//  StatePopUpViewController.swift
//  Moira
//
//  Created by Seok on 2021/03/09.
//

import UIKit

protocol StatePopUpViewControllerDelegate: class {
    func stateButtonClicked(state: String)
    func cancelButtonClicked()
}

class StatePopUpViewController: UIViewController {
    weak var delegate: StatePopUpViewControllerDelegate?
    
    init(delegate: StatePopUpViewControllerDelegate?) {
        self.delegate = delegate
        super.init(nibName: "StatePopUpViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.4)
    }

    @IBAction func dismissButtonClicked(_ sender: Any) {
        self.delegate?.cancelButtonClicked()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ongoingButtonClicked(_ sender: Any) {
        self.delegate?.stateButtonClicked(state: "재학")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func breakButtonClicked(_ sender: Any) {
        self.delegate?.stateButtonClicked(state: "휴학")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func graduateButtonClicked(_ sender: Any) {
        self.delegate?.stateButtonClicked(state: "졸업")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func completeButtonClicked(_ sender: Any) {
        self.delegate?.stateButtonClicked(state: "수료")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func graceButtonClicked(_ sender: Any) {
        self.delegate?.stateButtonClicked(state: "유예")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func dropButtonClicked(_ sender: Any) {
        self.delegate?.stateButtonClicked(state: "중퇴")
        self.dismiss(animated: true, completion: nil)
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
