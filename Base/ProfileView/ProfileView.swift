//
//  ProfileView.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/9/21.
//

import UIKit

class ProfileView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var userImageButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var greetLabel: UILabel!
    
    let userDefaults = UserDefaults()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        userImageButton.setTitle("", for: .normal)
        userNameLabel.text = "\(userDefaults.value(forKey: "fullName") ?? "User") 👋"
    }
    
    @IBAction func profileButton(_ sender: Any) {
        
    }
}
