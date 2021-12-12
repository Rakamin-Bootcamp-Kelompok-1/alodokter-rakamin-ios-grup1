//
//  SplashScreenViewController.swift
//  Alodokter_bootcamp
//
//  Created by Abdul Aziz on 20/11/21.
//

import UIKit

class SplashScreenViewController: BaseViewController {
    
    override func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let mainView : UINavigationController = UINavigationController(rootViewController: MainViewController())
            UIApplication.setRootView(mainView,options: .transitionCrossDissolve)
        }
    }
}
