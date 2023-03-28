//
//  ListViewModel.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/25.
//

import UIKit
import RxSwift
import RxCocoa

open class ListViewModel<M, CVM: IGenericViewModel>: ViewModel<M>, IListViewModel {
    public typealias CellViewModelElement = CVM
    
    public typealias ItemsSourceType = [SectionList<CVM>]
    
    public let itemsSource = ReactiveCollection<CVM>()
    public let rxSelectedItem = BehaviorRelay<CVM?>(value: nil)
    public let rxSelectedIndex = BehaviorRelay<IndexPath?>(value: nil)
    
    required public init(model: M? = nil) {
        super.init(model: model)
    }
    
    open override func destroy() {
        super.destroy()
        
        itemsSource.forEach { _, sectionList in
            sectionList.forEach { _, cvm in
                cvm.destroy()
            }
        }
    }
    
    open func selectedItemDidChange(_ cellViewModel: CVM, _ indexPath: IndexPath) { }
}

