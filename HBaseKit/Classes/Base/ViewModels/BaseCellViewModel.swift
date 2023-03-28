//
//  BaseCellViewModel.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/25.
//

import UIKit
import RxSwift
import RxCocoa

open class BaseCellViewModel: NSObject, IGenericViewModel, IIndexable, IReactable {
    public typealias ModelElement = Model
    
    private var _model: Model?
    public var model: Model? {
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
    public internal(set) var  isLastRow: Bool = false
    /// Bag for databindings
    public var disposeBag: DisposeBag? = DisposeBag()
    
    var isReacted = false
    
    public required init(model: Model? = nil) {
        _model = model
    }
    
    open func modelChanged() {
        reactIfNeeded()
    }
    open func react() {}
    
    func reactIfNeeded() {
        guard !isReacted else {
            return
        }
        isReacted = true
        disposeBag = DisposeBag()
        react()
    }
    
    open func destroy() {
        disposeBag = DisposeBag()
    }
}

