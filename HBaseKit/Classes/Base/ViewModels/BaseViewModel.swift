//
//  BaseViewModel.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/25.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: Nongeneric Type
// Base view model sẽ đi với View tương ứng.
// Mỗi View model sẽ đi với một Base Model tưng ứng.

open class BaseViewModel: NSObject, IViewModel, IReactable {
    public typealias ModelElement = Model
    
    private var _model: Model?
    public var model: Model? {
        get { return _model }
        set {
            _model = newValue
            if viewDidLoad {
                isReacted = false
                modelChanged()
            }
        }
    }
    var viewDidLoad = false
    public var disposeBag: DisposeBag? = DisposeBag()
    
    public let rxViewState = BehaviorRelay<ViewState>(value: .none)
    public let rxShowLocalActivityIndicatorHud = BehaviorRelay(value: false)
    public let rxIndicator = ActivityIndicator()
    
    public let navigationService: NavigationService = HBaseKitManager.shared.getService()
    
    var isReacted = false
    
    public var scheduler: SchedulerType?
    
    public required init(model: Model?) {
        _model = model
    }
    
    required public init(model: Model? = nil, timerScheduler: SchedulerType? = Scheduler.shared.mainScheduler) {
        _model = model
        scheduler = timerScheduler
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
    open func modelChanged() {
        self.reactIfNeeded()
    }
    
    /**
     This method will be called once. Good place to initialize our viewModel (listen, subscribe...) to any signals
     */
    open func react() {}
    
    open func onUpdateLocalize() {}
    
    func reactIfNeeded() {
        guard !isReacted, viewDidLoad else {
            return
        }
        isReacted = true
        disposeBag = DisposeBag()
        react()
    }
}

open class PageOption {
    public var isInfinity: Bool = false
    public var transitionStyle: Int = 0
}

open class BaseUIPageViewModel: BaseViewModel {
    public let itemsSource = ReactiveCollection<UIPageItem>()
    public let rxSelectedItem = BehaviorRelay<UIPageItem?>(value: nil)
    public let rxSelectedIndex = BehaviorRelay<Int>(value: 0)
    public let rxState = BehaviorRelay<ListState>(value: .normal)
    
    public var isInfinity: Bool = false
    
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

open class UIPageItem: NSObject, IReactable {
    public internal(set) var pageIndex: Int = 0
    public var disposeBag: DisposeBag? = DisposeBag()
    
    var isReacted = false
    
    private var _model: Model?
    public var vc: UIViewController?
    
    public required init(model: Model? = nil, viewController: UIViewController? = nil) {
        self._model = model
        self.vc = viewController
    }
    
    open func modelChanged() {}
    open func react() {}
    
    func reactIfNeeded() {
        /*
         guard !isReacted else { return }
         isReacted = true
         */
        react()
    }
    
    open func destroy() {
        disposeBag = DisposeBag()
    }
}
