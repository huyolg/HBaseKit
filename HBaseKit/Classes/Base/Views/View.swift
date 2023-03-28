//
//  View.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/26.
//

import UIKit
import RxSwift
import RxCocoa


open class View<VM: IGenericViewModel>: UIView, IView {
    public typealias ViewModelElement = VM
    
    public var disposeBag: DisposeBag? = DisposeBag()
    
    private var _viewModel: VM?
    public var viewModel: VM? {
        get { return _viewModel }
        set {
            if newValue != _viewModel {
                disposeBag = DisposeBag()
                
                _viewModel = newValue
                viewModelChanged()
            }
        }
    }
    
    public var anyViewModel: Any? {
        get { return _viewModel }
        set { viewModel = newValue as? VM }
    }
    
    public init(viewModel: VM? = nil) {
        self._viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }
    
    public init(frame: CGRect, viewModel: VM? = nil) {
        self._viewModel = viewModel
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit { destroy() }
    
    func setup() {
        initialize()
        viewModelChanged()
    }
    
    private func viewModelChanged() {
        bindViewAndViewModel()
        (_viewModel as? IReactable)?.reactIfNeeded()
    }
    
    open func destroy() {
        disposeBag = DisposeBag()
        viewModel?.destroy()
    }
    
    open func initialize() {}
    open func bindViewAndViewModel() {}
}
