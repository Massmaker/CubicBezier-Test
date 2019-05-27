//
//  ViewController.swift
//  CubicBezier test
//
//  Created by Ivan Iavorin on 5/27/19.
//  Copyright © 2019 Ivan Iavorin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      let test = CurveDrawingView(frame: CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 500, height: 400)))
      test.backgroundColor = UIColor.clear
      view.addSubview(test)
   }


}

