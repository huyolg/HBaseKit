//
//  ViewController.swift
//  HBaseKit
//
//  Created by Func-Dev-20 (Functional Account) on 03/12/2023.
//  Copyright (c) 2023 Func-Dev-20 (Functional Account). All rights reserved.
//

import UIKit
import HBaseKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let btn = UIButton()
        btn.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 10, height: 10))
        btn.backgroundColor = UIColor.red
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tap() {
        print("tap")
        
    }

}

