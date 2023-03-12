//
//  HWindow.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/12.
//

import UIKit

    
public struct HWindow {
    //状态栏高度
    public static var StatBarHeight: CGFloat {
        var height = 0.0
        if #available(iOS 13, *){
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let statusBarManager = windowScene.statusBarManager else { return 0 }
            height = statusBarManager.statusBarFrame.height
        } else {
            height = UIApplication.shared.statusBarFrame.height
        }
           
        return height
    }
    // 顶部安全距离高度
    public static var SafeDistanceTopHeight: CGFloat {
        var height = 0.0
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let window = windowScene.windows.first else { return 0 }
            height = window.safeAreaInsets.top
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else { return 0 }
            height = window.safeAreaInsets.top
        }
        return height
    }
    // 底部安全距离高度
    public static var SafeDistanceBottomHeight: CGFloat {
        var height = 0.0
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let window = windowScene.windows.first else { return 0 }
            height = window.safeAreaInsets.bottom
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else { return 0 }
            height = window.safeAreaInsets.bottom
        }
        return height
    }
    // 导航栏的高度
    public static var NavigationBarHeight: CGFloat {
        return 44.0
    }
    // tabbar导航的高度
    public static var TabBarHeight: CGFloat {
        return 49.0
    }
    // tabbar导航的总高度
    public static var TabBarTotalHeight: CGFloat {
        return SafeDistanceBottomHeight + TabBarHeight
    }
    // 导航的总高度
    public static var NavigationBarTotalHeight: CGFloat {
        return SafeDistanceTopHeight + NavigationBarHeight
    }

    // safe total height
    public static var SafeTopBottomHeight: CGFloat {
        return SafeDistanceTopHeight + SafeDistanceBottomHeight
    }
//    获取根视图
    public static var rootViewController: UIViewController? {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return nil }
            guard let window = windowScene.windows.first else { return nil }
            return window.rootViewController
        } else {
            guard let window = UIApplication.shared.windows.first else { return nil }
            return window.rootViewController
        }
    }
}
