//
//  BaseTableCell.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/26.
//

import UIKit
import RxSwift
import RxCocoa

open class BaseTableCell: UITableViewCell, IView {
    open class var identifier: String {
        return String(describing: self)
    }
    
    open class func identifier(_ returnClass: Bool = false) -> String {
        return (returnClass ? NSStringFromClass(self.self) : String(describing: self))
    }
    
    open class func height(withItem _item: BaseCellViewModel) -> CGFloat {
        return 30.0
    }
    
    public var disposeBag: DisposeBag? = DisposeBag()
    
    private var _viewModel: BaseCellViewModel?
    public var viewModel: BaseCellViewModel? {
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
        set { viewModel = newValue as? BaseCellViewModel }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit { destroy() }
    
    private func setup() {
        self.backgroundView = UIView()
        separatorInset = .zero
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false
        
        initialize()
    }
    
    private func viewModelChanged() {
        bindViewAndViewModel()
        _viewModel?.reactIfNeeded()
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        destroy()
        _viewModel = nil
    }
    
    open func destroy() {
        disposeBag = DisposeBag()
        viewModel?.destroy()
    }
    
    open func initialize() {}
    open func bindViewAndViewModel() {}
    open func prepareForDisplay() {}
}
