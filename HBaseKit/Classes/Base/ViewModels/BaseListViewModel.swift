//
//  BaseListViewModel.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/25.
//

import UIKit
import RxSwift
import RxCocoa

open class BaseListViewModel: BaseViewModel, IListViewModel {
    public typealias CellViewModelElement = BaseCellViewModel
    
    public typealias ItemsSourceType = [SectionList<BaseCellViewModel>]
    
    public let itemsSource = ReactiveCollection<BaseCellViewModel>()
    public let rxSelectedItem = BehaviorRelay<BaseCellViewModel?>(value: nil)
    public let rxSelectedIndex = BehaviorRelay<IndexPath?>(value: nil)
    public let rxState = BehaviorRelay<ListState>(value: .normal)
    
    public var page: Int = 0
    public var limit: Int = 20
    
    required public init(model: Model? = nil, timerScheduler: SchedulerType? = Scheduler.shared.mainScheduler) {
        super.init(model: model, timerScheduler: timerScheduler)
    }
    
    public required init(model: Model?) {
        super.init(model: model)
    }
    
    open override func destroy() {
        super.destroy()
        
        itemsSource.forEach { _, sectionList in
            sectionList.forEach({ _, cvm in
                cvm.destroy()
            })
        }
    }
    
    open func selectedItemDidChange(_ cellViewModel: BaseCellViewModel, _ indexPath: IndexPath) { }
    open func loadMoreContent() {}
    
}
