//
//  ViewModels.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/25.
//

import UIKit
import RxSwift
import RxCocoa

protocol IReactable {
    var isReacted: Bool { get set }
    
    func reactIfNeeded()
    func react()
}

extension Reactive where Base: IGenericViewModel {
    public typealias ModelElement = Base.ModelElement
    
    public var model: Binder<ModelElement?> {
        return Binder(base) { $0.model = $1 }
    }
}

/// A master based ViewModel for all
open class ViewModel<M>: NSObject, IViewModel, IReactable {
    public typealias ModelElement = M
    
    private var _model: M?
    public var model: M? {
        get { return _model }
        set {
            _model = newValue
            modelChanged()
        }
    }
    
    public var disposeBag: DisposeBag? = DisposeBag()
    
    public let rxViewState = BehaviorRelay<ViewState>(value: .none)
    public let rxShowLocalActivityIndicatorHud = BehaviorRelay(value: false)
    public let rxIndicator = ActivityIndicator()
    
    public let navigationService: NavigationService = HBaseKitManager.shared.getService()
    
    var isReacted = false
    
    required public init(model: M? = nil) {
        _model = model
    }
    
    open func destroy() {
        disposeBag = DisposeBag()
    }
    
    deinit {
        destroy()
    }
    
    /**
     Everytime model changed, this method will get called. Good place to update our viewModel
     */
    open func modelChanged() {}
    
    /**
     This method will be called once. Good place to initialize our viewModel (listen, subscribe...) to any signals
     */
    open func react() {}
    
    func reactIfNeeded() {
        guard !isReacted else {
            return
        }
        isReacted = true
        disposeBag = DisposeBag()
        react()
    }
}
