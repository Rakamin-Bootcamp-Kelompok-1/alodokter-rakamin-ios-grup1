//
//  ProfileView.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/9/21.
//

import UIKit
import SDWebImage

class ProfileView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
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
        
        userImageView.layer.borderWidth = 1
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor.systemGray.cgColor
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.clipsToBounds = true
        if #available(iOS 13.0, *) {
            userImageView.sd_setImage(with: URL(string: userDefaults.value(forKey: "imageData") as? String ?? ""), placeholderImage: UIImage(systemName: "person.circle.fill"))
        } else {
            // Fallback on earlier versions
        }
        
        userNameLabel.text = "\(userDefaults.value(forKey: "fullName") ?? "User") 👋"
    }
    
    @IBAction func profileButton(_ sender: Any) {
        
    }
}
