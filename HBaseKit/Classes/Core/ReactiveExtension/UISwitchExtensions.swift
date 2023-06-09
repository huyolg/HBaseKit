//
//  UISwitchExtensions.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/26.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UISwitch {
    var onTintColor: Binder<UIColor> {
        return Binder(base) { $0.onTintColor = $1 }
    }
    
    var isOn: ControlProperty<Bool> {
        return UIControl.toProperty(control: self.base,
                                    getter: { view in
                                        view.isOn
                                    }, setter: { view, value in
                                        if value != view.isOn {
                                            view.setOn(value, animated: true)
                                        }
                                    })
    }
}
