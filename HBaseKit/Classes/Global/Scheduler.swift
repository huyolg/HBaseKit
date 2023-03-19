//
//  Scheduler.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/19.
//

import Foundation
import RxSwift

public class Scheduler {
    public static let shared = Scheduler()
    
    public let backgroundScheduler: ImmediateSchedulerType
    public let mainScheduler: SerialDispatchQueueScheduler
    
    init() {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        
        backgroundScheduler = OperationQueueScheduler(operationQueue: operationQueue)
        mainScheduler = MainScheduler.instance
    }
}
