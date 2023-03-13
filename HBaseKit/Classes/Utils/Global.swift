//
//  Global.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/13.
//

import UIKit

func HPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print(items, separator: separator, terminator: terminator)
    #endif
}

class Global: NSObject {
    

}
