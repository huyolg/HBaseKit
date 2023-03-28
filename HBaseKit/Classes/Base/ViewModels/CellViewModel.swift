//
//  CellViewModel.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/25.
//

import UIKit
import RxSwift
import RxCocoa

protocol IIndexable: AnyObject {
    var indexPath: IndexPath? { get set }
    var isLastRow: Bool { get set }
}

open class CellViewModel<M>: NSObject, IGenericViewModel, IIndexable, IReactable {
    public typealias ModelElement = M
    
    private var _model: M?
    public var model: M? {
        get { return _model }
        set {
            _model = newValue
            isReacted = false
            modelChanged()
        }
    }
    
    /// Each cell will keep its own index path
    /// In some cases, each cell needs to use this index to create some customizations
    public internal(set) var indexPath: IndexPath?
    public internal(set) var  isLastRow = false
    /// Bag for databindings
    public var disposeBag: DisposeBag? = DisposeBag()
    
    var isReacted = false
    
    public required init(model: M? = nil) {
        _model = model
    }
    
    open func destroy() {
        disposeBag = DisposeBag()
    }
    
    open func modelChanged() {}
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

/// A usefull CellViewModel based class to support ListPage and CollectionPage that have more than one cell identifier
open class SuperCellViewModel: CellViewModel<Any> {
    required public init(model: Any? = nil) {
        super.init(model: model)
    }
}
