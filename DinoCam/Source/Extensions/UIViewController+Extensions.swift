//
//  UIViewController+Extensions.swift
//  DinoCam
//
//  Created by Mario Vanegas on 2/7/21.
//

import SwiftUI
import TinyConstraints

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        
        view.addSubview(child.view)
        child.view.edgesToSuperview()
        child.didMove(toParent: self)
    }
    
    func addHosting<T: SwiftUI.View>(_ view: T) {
        let hostingController = UIHostingController(rootView: view)
        add(hostingController)
    }
}
