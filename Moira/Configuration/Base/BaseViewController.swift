//
//  BaseViewController.swift
//  Moira
//
//  Created by Seok on 2021/02/27.
//

import UIKit

class BaseViewController: UIViewController {
    let backBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: nil, style: .done, target: self, action: nil)
        item.tintColor = .black
        
        return item
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
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
