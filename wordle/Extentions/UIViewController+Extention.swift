//
//  UIViewController+Extention.swift
//  wordle
//
//  Created by Hani on 6/8/2023.
//

import UIKit

extension UIViewController {

  func addViewChild(_ childController: UIViewController) {
    addChild(childController)
    childController.didMove(toParent: self)
    childController.view.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(childController.view)
  }
}
