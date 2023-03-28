//
//  BaseView.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/26.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Based UIView that support BasePage
open class BaseView: UIView, IView {
    public var disposeBag: DisposeBag? = DisposeBag()
    
    private var _viewModel: BaseViewModel?
    public var viewModel: BaseViewModel? {
        get { return _viewModel }
        set {
            if newValue != _viewModel {
                disposeBag = DisposeBag()
                _viewModel = newValue
                _viewModel?.viewDidLoad = true
                _viewModel?.isReacted = false
                viewModelChanged()
            }
        }
    }
    
    public var anyViewModel: Any? {
        get { return _viewModel }
        set { viewModel = newValue as? BaseViewModel }
    }
    
    public init(viewModel: BaseViewModel? = nil) {
        self._viewModel = viewModel
        super.init(frame: .zero)
    }
    
    public init(frame: CGRect, viewModel: BaseViewModel? = nil) {
        self._viewModel = viewModel
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        initialize()
    }
    
    private func viewModelChanged() {
        bindViewAndViewModel()
        _viewModel?.reactIfNeeded()
    }
    
    open func destroy() {
        disposeBag = DisposeBag()
        viewModel?.destroy()
    }
    
    open func initialize() {}
    open func bindViewAndViewModel() {}
    
    deinit { destroy() }
}



