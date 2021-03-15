//
//  Device.swift
//  Moira
//
//  Created by Seok on 2021/02/27.
//

import UIKit

struct Device {
    static var isNotch: Bool {
        return Double(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? -1) > 0
    }
    
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    static var navigationBarHeight: CGFloat {
        return UINavigationController().navigationBar.frame.height
    }

    static var tabBarHeight: CGFloat {
        return UITabBarController().tabBar.frame.height
    }
    
    static var topInset: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
    
    static var bottomInset: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
}
