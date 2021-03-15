//
//  UIFont.swift
//  Moira
//
//  Created by Seok on 2021/02/27.
//

import Foundation
import UIKit

extension UIFont {
    public enum AppleSDGothicNeoType: String {
        case bold = "Bold"
        case regular = "Regular"
        case thin = "Thin"
        case ultraLight = "UltraLight"
        case light = "Light"
        case medium = "Medium"
        case semiBold = "SemiBold"
        case extraBold = "ExtraBold"
        case heavy = "Heavy"
    }
    
    public enum GmarketSansType: String {
        case bold = "Bold"
        case lgith = "Light"
        case medium = "Medium"
    }

    static func AppleSDGothicNeo(_ type: AppleSDGothicNeoType, size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-\(type.rawValue)", size: size)!
    }
        
    static func GmarketSans(_ type: GmarketSansType, size: CGFloat) -> UIFont {
        return UIFont(name: "GmarketSans\(type.rawValue)", size: size)!
    }
}
