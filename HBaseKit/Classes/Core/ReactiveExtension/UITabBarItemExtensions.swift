//
//  UITabBarItemExtensions.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/26.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UITabBarItem {
    var image: Binder<UIImage?> {
        return Binder(self.base) { $0.image = $1 }
    }
    
    var title: Binder<String?> {
        return Binder(self.base) { $0.title = $1 }
    }
    
    var badge: Binder<Int> {
        return Binder(self.base) { control, value in
            if value <= 0 {
                control.badgeValue = nil
            } else {
                control.badgeValue = "\(value)"
            }
        }
    }
}
