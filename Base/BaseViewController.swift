//
//  BaseViewController.swift
//  Alodokter_bootcamp
//
//  Created by Abdul Aziz on 20/11/21.
//

import Foundation
import UIKit

typealias callBack = () -> ()

class BaseViewController : UIViewController, UIGestureRecognizerDelegate {
    var spinnerContainer: UIView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var labelledButton : UIButton = UIButton()
    var titleTexts = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
    func onBackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onBackPressedObjc(button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        if self.view != nil{
            self.view.endEditing(true)
        }
    }
    
    func showParentSpinner() {
        guard self.parent != nil else{return}
        showSpinner(view:(self.parent?.view)!)
    }
    
    func showSpinner(view:UIView) {
        let screenSize = DeviceHelper.getScreenSize()
        if spinnerContainer == nil {
            spinnerContainer = UIView()
            spinnerContainer.frame = CGRect(x: view.center.x, y: view.center.y - 75, width: screenSize.width, height: screenSize.height + 90)
            spinnerContainer.center = view.center
            spinnerContainer.backgroundColor = UIColor.black
            spinnerContainer.alpha = 0.7
        }
        // spinner activity indicator
        activityIndicator.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 40, height: 40))
        activityIndicator.center = CGPoint(x:spinnerContainer.frame.size.width / 2, y:spinnerContainer.frame.size.height / 2);
        spinnerContainer.addSubview(activityIndicator)
        var rotationAnimation: CABasicAnimation?
        rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationAnimation?.toValue = .pi * 2.0
        rotationAnimation?.duration = 1.5
        rotationAnimation?.isCumulative = true
        rotationAnimation?.repeatCount = MAXFLOAT
        view.addSubview(spinnerContainer)
        activityIndicator.startAnimating()
    }
    
    func removeSpinner() {
        activityIndicator.stopAnimating()
        if spinnerContainer != nil {
            spinnerContainer.removeFromSuperview()
        }
    }
    
    func setNavigationBarVisibility(hide: Bool) {
        self.navigationController?.isNavigationBarHidden = hide
    }
    
    func initBackButton(withTintColor tintColor: UIColor = UIColor.white){
        hideBackbutton()
        let backButton = UIButton(frame: CGRect(x:0, y:0, width:40, height:50))
        let backImage = UIImage(named: "left_arrrow_icon")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = tintColor
        
        backButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        labelledButton = UIButton(frame: CGRect(x:0, y:0, width:140-UIScreen.main.bounds.width, height:60))
        labelledButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        labelledButton.setTitle(titleTexts, for: .normal)
        labelledButton.setTitleColor(tintColor, for: .normal)
        labelledButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        labelledButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        labelledButton.titleLabel?.adjustsFontSizeToFitWidth = false
        labelledButton.titleLabel?.lineBreakMode = .byTruncatingTail
        backButton.addTarget(self, action: #selector(self.onBackPressedObjc(button:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backButton),UIBarButtonItem(customView: labelledButton)]
    }
    
    func hideBackbutton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func setTitle(title:String) {
        labelledButton.setTitle(title, for: .normal)
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

extension UIApplication {
    public static func setRootView(_ viewController: UIViewController,
                                   options: UIView.AnimationOptions = .transitionFlipFromRight,
                                   animated: Bool = true,
                                   duration: TimeInterval = 0.5,
                                   completion: (() -> Void)? = nil) {
        guard animated else {
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            completion?()
        }
    }
}

extension UINavigationController {
public func popToSelectedController(destinationController: AnyClass) {
    var index = 0
    for i in 0 ..< viewControllers.count {
        let controller: AnyObject = viewControllers[i]
        if controller.isKind(of:destinationController) {
            index = i
            break
        }
    }
    popToViewController(viewControllers[index] , animated: true)
    }
}
