//
//  AlertService.swift
//  HBaseKit_Example
//
//  Created by 胡永亮 on 2023/3/15.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import HBaseKit
import RxSwift

extension AlertService {
    @discardableResult
    public func presentConfirmAlert(title: String?, message: String?, submitText: String = "Yes", cancelText: String = "No") -> Single<Bool> {
        return Single.create { single in
            let alertVC = AlertController(title: title, message: message, preferredStyle: .alert)
            
            let submitAction = UIAlertAction(title: submitText, style: .cancel) { _ in
                single(.success(true))
            }
            /// Set value for action
            submitAction.setValue(UIColor.red, forKey: "titleTextColor")
            
            let cancelAction = UIAlertAction(title: cancelText, style: .default) { _ in
                single(.success(false))
            }
            
            alertVC.addAction(submitAction)
            alertVC.addAction(cancelAction)
            
            alertVC.alert()
            
            return Disposables.create { alertVC.dismiss() }
        }
    }
}
