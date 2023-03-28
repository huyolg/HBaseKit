//
//  BaseHeaderCollectionView.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/26.
//

import UIKit
import RxSwift
import RxCocoa

open class BaseHeaderCollectionView: UICollectionReusableView {
    open class var identifier: String {
        return String(describing: self)
    }
    
    open class func identifier(_ returnClassName: Bool = false) -> String {
        return (returnClassName ? NSStringFromClass(self.self) : String(describing: self))
    }
    
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
    
    open class func headerSize(withItem _item: BaseViewModel) -> CGSize {
        return CGSize(width: 30.0, height: 30.0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit { destroy() }
    
    private func setup() {
        initialize()
    }
    
    private func viewModelChanged() {
        bindViewAndViewModel()
        _viewModel?.reactIfNeeded()
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        _viewModel = nil
    }
    
    open func destroy() {
        disposeBag = DisposeBag()
        viewModel?.destroy()
    }
    
    open func initialize() {}
    open func bindViewAndViewModel() {}
    open func prepareForDisplay() {}
    
    open class func getSize(withItem data: Any?) -> CGSize? {
        return nil
    }
}

