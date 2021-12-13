//
//  SplashScreenViewController.swift
//  Alodokter_bootcamp
//
//  Created by Abdul Aziz on 20/11/21.
//

import UIKit

class SplashScreenViewController: BaseViewController {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var medikuyLabel: UILabel!
    
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        
        // MediKuy Mutable String
        let medikuyMutableString = NSMutableAttributedString(string: "MediKuy", attributes: [NSAttributedString.Key.font :UIFont(name: "Nunito-Bold", size: 50)!])
        medikuyMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(hex: "25467D"), range: NSRange(location: 0, length: 4))
        medikuyMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(hex: "7BABEB"), range: NSRange(location: 4, length: 3))
        
        // Set Label Attribute
        medikuyLabel.attributedText = medikuyMutableString
        
        // Splash Screen Delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let mainView: UINavigationController = UINavigationController(rootViewController: ProfileViewController())
            UIApplication.setRootView(mainView, options: .transitionCrossDissolve)
        }
    }
}
