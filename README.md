
![Logo](Peekaboo/Images/Banner.png)

## Overview
![Logo](Peekaboo/Images/sampleProject.gif)

## Requirements
* Xcode 9+
* Swift 4

## Usage

### Storyboard
![Logo](Peekaboo/Images/storyboardImp.gif)

### Code
```
import UIKit
import Peekaboo

class ViewController: UIViewController {
    let peekingView = Peekboo()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(peekingView) // Alignment is done for you
    }

}
```






