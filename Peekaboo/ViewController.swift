//
//  ViewController.swift
//  Peekaboo
//
//  Created by Ehud Adler on 1/2/18.
//  Copyright © 2018 Ehud Adler. All rights reserved.
//

import UIKit
import Peekaboo

class ViewController: UIViewController {
    let peekingView = Peekboo()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(peekingView) // Alignment is done for you
    }

}

