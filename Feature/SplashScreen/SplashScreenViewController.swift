//
//  SplashScreenViewController.swift
//  Alodokter_bootcamp
//
//  Created by Abdul Aziz on 20/11/21.
//

import UIKit

class SplashScreenViewController: BaseViewController {
    
    override func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let mainView : UINavigationController = UINavigationController(rootViewController: TabBarViewController())
            UIApplication.setRootView(mainView,options: .transitionCrossDissolve)
        }
    }
}
