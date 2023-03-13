//
//  UIButton+Util.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/13.
//

import UIKit

extension UIButton {
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        var react = self.bounds
        let deltaW = 44.0 - react.size.width > 0 ? 44.0 - react.size.width : 0
        let deltaH = 44.0 - react.size.height > 0 ? 44.0 - react.size.height : 0
        
        react = CGRectInset(react, -deltaW * 0.5, -deltaH * 0.5)
        
        return CGRectContainsPoint(react, point)
    }
}
