//
//  UIViewExtension.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/17.
//

import UIKit

public extension UIView {
    class var nibName: String {
        return String(describing: self)
    }
    
    class var className: String {
        return NSStringFromClass(self.self)
    }
    
    func getGesture<G: UIGestureRecognizer>(_ comparison: ((G) -> Bool)? = nil) -> G? {
        return gestureRecognizers?.first(where: { g -> Bool in
            if let comparison = comparison {
                return g is G && comparison(g as! G)
            }
            
            return g is G
        }) as? G
    }
    
    func clearAll() {
        if let stackView = self as? UIStackView {
            
        } else {
            subviews.forEach { view in
//                (view as ? ide)
                view.removeFromSuperview()
            }
        }
    }
}
