//
//  ViewController.swift
//  Json2Model
//
//  Created by 11111 on 2017/7/17.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var json : JSON = JSON.null
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData() {
        printWithTime(json.type)
    }


}

