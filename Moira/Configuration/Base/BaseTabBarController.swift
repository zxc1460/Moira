//
//  BaseTabBarController.swift
//  Moira
//
//  Created by Seok on 2021/02/27.
//

import UIKit

class BaseTabBarController: UITabBarController {
    let homeViewController = BaseViewController()
    let teamMakingViewController = TeamMakingViewController()
    let myTeamViewController = MyTeamMainViewController()
    let myPageViewController = MyPageMainViewController()
    
    let homeTabBarItem = UITabBarItem(title: "홈", image: nil, tag: 0)
    let teamMakingTabBarItem = UITabBarItem(title: "팀 만들기", image: nil, tag: 1)
    let myTeamTabBarItem = UITabBarItem(title: "나의 팀", image: nil, tag: 2)
    let myPageTabBarItem = UITabBarItem(title: "마이페이지", image: nil, tag: 3)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let teamMakingNavigationController = UINavigationController(rootViewController: teamMakingViewController)
        let myTeamNavigationController = UINavigationController(rootViewController: myTeamViewController)
        let myPageNavigationController = UINavigationController(rootViewController: myPageViewController)
        
        homeNavigationController.tabBarItem = homeTabBarItem
        teamMakingNavigationController.tabBarItem = teamMakingTabBarItem
        myTeamNavigationController.tabBarItem = myTeamTabBarItem
        myPageNavigationController.tabBarItem = myPageTabBarItem
        
        self.viewControllers = [homeNavigationController, teamMakingNavigationController, myTeamNavigationController, myPageNavigationController]
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
