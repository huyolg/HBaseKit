//
//  UIApplicationExtensions.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/26.
//

import UIKit

public extension UIApplication {
    class func getKeyWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .filter({
                    $0.activationState == .foregroundActive
                })
                .map({
                    $0 as? UIWindowScene
                })
                .compactMap({
                    $0
                })
                .first?.windows.first(where: {
                    $0.isKeyWindow
                })
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
