//
//  AlertController.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/15.
//

import UIKit
import RxSwift

public protocol IAlertDelegate {
    func presentOkayAlert(title: String?, message: String?)
    func presentObservableOkayAlert(title: String?, message: String?) -> Single<Void>
    func presentObservableConfirmAlert(title: String?, message: String?, yesText: String, noText: String) -> Single<Bool>
    func presentObservaleActionSheet(title: String?, message: String?, actionTitles: [String], cancelTitle: String) -> Single<String>
}

public class AlertController: UIAlertController {
    private var alertWindow: UIWindow? = nil
    public func alert() {
        guard let rootViewController = HWindow.rootViewController else { return }
        if let popVC = self.popoverPresentationController {
            popVC.sourceView = rootViewController.view
            popVC.sourceRect = rootViewController.view.bounds
        }
        
        if rootViewController.presentedViewController == nil {
            rootViewController.present(self, animated: true)
        } else {
            rootViewController.presentedViewController?.present(self, animated: true)
        }
    }
    
    public func dismiss() {
        alertWindow?.isHidden = true
        alertWindow = nil
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss()
    }
    
    func updateFont(withMessage message: String?) {
        var myMutableStringMessage = NSMutableAttributedString()
        myMutableStringMessage = NSMutableAttributedString(string: message ?? "",
                                                           attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.baselineOffset: 1])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        paragraphStyle.alignment = .center
        
        let range = NSRange(location: 0, length: myMutableStringMessage.length)
        myMutableStringMessage.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        myMutableStringMessage.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], range: range)
        
        var myMutableStringTitle = NSMutableAttributedString()
        myMutableStringTitle = NSMutableAttributedString(string: title ?? "",
                                                         attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.baselineOffset: 1])
        
        self.setValue(myMutableStringTitle, forKey: "attributedTitle")
        self.setValue(myMutableStringMessage, forKey: "attributedMessage")
    }

}

public class AlertService: IAlertDelegate {
    public init() {}
    
    public func presentOkayAlert(title: String? = "OK", message: String? = nil) {
        let alertVC = AlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel)
        
        alertVC.addAction(okayAction)
        alertVC.updateFont(withMessage: message)
        alertVC.alert()
    }
    
    public func presentObservableOkayAlert(title: String?, message: String?) -> Single<Void> {
        return Single.create { single in
            let alertVC = AlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK",
                                           style: .cancel) { _ in
                single(.success(()))
            }
            
            alertVC.addAction(okayAction)
            alertVC.updateFont(withMessage: message)
            alertVC.alert()
            
            return Disposables.create { alertVC.dismiss() }
        }
    }
    
    public func presentObservableConfirmAlert(title: String?,
                                              message: String?,
                                              yesText: String = "Yes",
                                              noText: String = "No") -> Single<Bool> {
        return Single.create { single in
            let alertVC = AlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: yesText, style: .cancel) { _ in
                single(.success(true))
            }
            let noAction = UIAlertAction(title: noText, style: .default) { _ in
                single(.success(false))
            }
            
            alertVC.addAction(yesAction)
            alertVC.addAction(noAction)
            alertVC.updateFont(withMessage: message)
            alertVC.alert()
            
            return Disposables.create { alertVC.dismiss() }
        }
    }
    
    public func presentObservaleActionSheet(title: String?,
                                            message: String?,
                                            actionTitles: [String] = ["OK"],
                                            cancelTitle: String = "Cancel") -> Single<String> {
        return Single.create { single in
            let alertVC = AlertController(title: title, message: message, preferredStyle: UIDevice.current.userInterfaceIdiom == .pad ? .alert : .actionSheet)
            
            for title in actionTitles {
                let action = UIAlertAction(title: title, style: .default) { _ in
                    single(.success(title))
                }
                action.setValue(UIColor(hexString: "4CC9F0"), forKey: "titleTextColor")
                alertVC.addAction(action)
            }
            
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                single(.success(cancelTitle))
            }
            cancelAction.setValue(UIColor(hexString: "3B3F40"), forKey: "titleTextColor")
            
            alertVC.addAction(cancelAction)
            alertVC.updateFont(withMessage: message)
            alertVC.alert()
            
            return Disposables.create { alertVC.dismiss() }
        }
    }
}
