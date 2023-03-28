//
//  CollectionCell.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/26.
//

import UIKit
import RxSwift
import RxCocoa

open class CollectionCell<VM: IGenericViewModel>: UICollectionViewCell, IView {
    open class var identifier: String {
        return String(describing: self)
    }
    
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
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
        (_viewModel as? IReactable)?.reactIfNeeded()
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
}
