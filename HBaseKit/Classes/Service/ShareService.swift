//
//  ShareService.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/25.
//

import UIKit
import RxSwift
import RxCocoa

public class ShareService {
    public var rxShareServiceState = BehaviorRelay<(completed: Bool, items: [Any]?, error: Error?)?>(value: nil)
    let nvService: NavigationService = HBaseKitManager.shared.getService()
    
    public init() {}
    
    public func openShare(title: String, url: String) {
        if let myWebSite = URL(string: url) {
            let objectToShare = [myWebSite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectToShare, applicationActivities: nil)
            
            activityVC.completionWithItemsHandler = {[weak self] (_, completed: Bool, returnedItems: [Any]?, error: Error?) in
                self?.rxShareServiceState.accept((completed, returnedItems, error))
            }
            
            /// Present activity View Controller
            let window = UIApplication.shared.keyWindow
            guard let rootViewContorller = window?.rootViewController else {
                return
            }
            
            rootViewContorller.present(activityVC, animated: true)
        } else {
            let err = NSError(domain: "", code: 404, userInfo: ["message": "URL Invalid"])
            rxShareServiceState.accept((false, nil, err))
        }
    }
    
    public func openShareImage(title: String, image: UIImage) {
        let objectToShare = [image] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectToShare, applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = {[weak self] (_, completed: Bool, returnedItems: [Any]?, error: Error?) in
            self?.rxShareServiceState.accept((completed, returnedItems, error))
        }
        
        /// Present activity View Controller
        let window = UIApplication.shared.keyWindow
        guard let rootViewContorller = window?.rootViewController else {
            return
        }
        
        nvService.push(to: activityVC, options: .modal())
    }
}
