//
//  ProfileViewController.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 07/12/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileHeaderView: ProfileHeader!
    @IBOutlet weak var profileCardView1: ProfileCard!
    @IBOutlet weak var profileCardView2: ProfileCard!
    @IBOutlet weak var signOutButton: SignOutButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }
    
    func prepareUI() {
        if #available(iOS 13.0, *) {
            // Navigation Bar Title
            guard let navBarTitleFont = UIFont(name: "Nunito-SemiBold", size: 17) else {
                fatalError("""
                        Failed to load the "Nunito-SemiBold" font.
                        Make sure the font file is included in the project and the font name is spelled correctly.
                        """
                    )
            }
            
            let navBarTitleAttributes = [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .headline).scaledFont(for: navBarTitleFont)]
            
            self.navigationController?.navigationBar.titleTextAttributes = navBarTitleAttributes
            self.title = "My Profile"
            
            
            // Profile Header
            profileHeaderView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                                           y: profileHeaderView.bounds.maxY - profileHeaderView.layer.shadowRadius,
                                                                           width: profileHeaderView.bounds.width,
                                                                           height: profileHeaderView.layer.shadowRadius)).cgPath
            profileHeaderView.layer.shadowColor = UIColor.black.cgColor
            profileHeaderView.layer.shadowOpacity = 0.5
            profileHeaderView.layer.shadowOffset = .init(width: 0, height: 4)
            profileHeaderView.layer.shadowRadius = 4
            
            profileHeaderView.profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
            profileHeaderView.profileNameLabel.text = "Russi Hersiano"
            profileHeaderView.profilePhoneNumberLabel.text = "0813-7545-3367"
            
            
            // Profile Card 1
            profileCardView1.headerLabel.text = "Account"
            
            // Profile Card 1 Rounded Corners
            profileCardView1.containerView.layer.cornerRadius = 5
            
            // Profile Card 1 Shadow
//            profileCardView1.containerView.layer.shadowPath = UIBezierPath(rect: profileCardView1.containerView.bounds).cgPath
            profileCardView1.containerView.layer.shadowColor = UIColor.black.cgColor
            profileCardView1.containerView.layer.shadowOpacity = 0.25
            profileCardView1.containerView.layer.shadowOffset = .zero
            profileCardView1.containerView.layer.shadowRadius = 4
            
            // Profile Card Row 1
            profileCardView1.profileCardRow1.iconImageView.image = UIImage(systemName: "person.circle")
            profileCardView1.profileCardRow1.titleLabel.text = "Edit Profile"
            
            profileCardView1.profileCardRow2.iconImageView.image = UIImage(systemName: "lock.fill")
            profileCardView1.profileCardRow2.titleLabel.text = "Change Password"
            
            
            // Profile Card 2
            profileCardView2.headerLabel.text = "About MediKuy"
            
            // Profile Card 2 Rounded Corners
            profileCardView2.containerView.layer.cornerRadius = 5
            
            // Profile Card 2 Shadow
//            profileCardView2.containerView.layer.shadowPath = UIBezierPath(rect: profileCardView2.containerView.bounds).cgPath
            profileCardView2.containerView.layer.shadowColor = UIColor.black.cgColor
            profileCardView2.containerView.layer.shadowOpacity = 0.25
            profileCardView2.containerView.layer.shadowOffset = .zero
            profileCardView2.containerView.layer.shadowRadius = 4
            
            // Profile Card Row 2
            profileCardView2.profileCardRow1.iconImageView.image = UIImage(systemName: "house")
            profileCardView2.profileCardRow1.titleLabel.text = "About Us"
            
            profileCardView2.profileCardRow2.iconImageView.image = UIImage(systemName: "phone")
            profileCardView2.profileCardRow2.titleLabel.text = "Contact Us"
            
            
            // Sign Out Button
            signOutButton.contentView.layer.cornerRadius = 5
            
            signOutButton.layer.shadowPath = UIBezierPath(rect: profileHeaderView.bounds).cgPath
            signOutButton.contentView.layer.shadowColor = UIColor.black.cgColor
            signOutButton.contentView.layer.shadowOpacity = 0.25
            signOutButton.contentView.layer.shadowOffset = .zero
            signOutButton.contentView.layer.shadowRadius = 4
            
            guard let signOutButtonFont = UIFont(name: "Nunito-Regular", size: 17) else {
                fatalError("""
                        Failed to load the "Nunito-Regular" font.
                        Make sure the font file is included in the project and the font name is spelled correctly.
                        """
                    )
            }
            
            let signOutButtonAttributes = NSAttributedString(string: "Sign Out", attributes: [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: signOutButtonFont)])
            
            signOutButton.buttonOutlet.setAttributedTitle(signOutButtonAttributes, for: .normal)
            
        } else {
            // Fallback on earlier versions
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
