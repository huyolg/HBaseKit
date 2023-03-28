//
//  DrawerController.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/26.
//

import UIKit
import RxSwift
import Action

class OverlayView: AbstractControlView {
    public let tapGesture = UITapGestureRecognizer()
    
    override func setupView() {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        addGestureRecognizer(tapGesture)
    }
    
    static func addToPage(_ page: UIViewController) -> OverlayView {
        let overlayView = OverlayView()
        page.view.addSubview(overlayView)
//        overlayView.autoPinEdgesToSuperviewEdges()
        
        return overlayView
    }
}

public enum DrawerLayout {
    case under, over
}

public enum DrawerAnimation {
    case slide, slideAndZoom
    
    var duration: TimeInterval {
        switch self {
        case .slide:
            return 0.25
            
        case .slideAndZoom:
            return 0.3
        }
    }
}

public enum DrawerWidth {
    /// Fix drawer width
    case fix(CGFloat)
    
    /// Drawer width ratio compare to screen width
    case ratio(CGFloat)
}

