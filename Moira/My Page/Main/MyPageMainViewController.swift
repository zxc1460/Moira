//
//  MyPageMainViewController.swift
//  Moira
//
//  Created by Seok on 2021/03/06.
//

import UIKit

class MyPageMainViewController: BaseViewController {

    @IBAction func editMyProfileButtonClicked(_ sender: Any) {
        self.navigationController?.pushViewController(ProfileEditViewController(), animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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
