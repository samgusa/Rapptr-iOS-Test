//
//  MenuViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class MenuViewController: UIViewController {
  
  /**
   * =========================================================================================
   * INSTRUCTIONS
   * =========================================================================================
   *
   * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
   *
   * 2) Use Autolayout to make sure all UI works for each resolution
   *
   * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
   *    provided code if necessary. It is ok to add any classes. This is your project now!
   *
   * 4) Read the additional instructions comments throughout the codebase, they will guide you.
   *
   * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
   *
   * Thank you and Good luck. - Rapptr Labs
   * =========================================================================================
   */
  
  // MARK: - Outlets
  private lazy var chatButton: MenuButton = {
    let button = MenuButton(with: .init(menuImage: "ic_chat", menuText: "CHAT"))
    button.addTarget(self, action: #selector(didPressChatButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var loginButton: UIButton = {
    let button = MenuButton(with: .init(menuImage: "ic_login", menuText: "LOGIN"))
    button.addTarget(self, action: #selector(didPressLoginButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var animationButton: UIButton = {
    let button = MenuButton(with: .init(menuImage: "ic_animation", menuText: "ANIMATION"))
    button.addTarget(self, action: #selector(didPressAnimationButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var backgroundImg: UIImageView = {
    let img = UIImageView()
    img.image = UIImage(named: "bg_home_menu")
    img.contentMode = .scaleAspectFill
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Coding Tasks"
    setUpView()
  }
  
  
  func setUpView() {
    
    navigationItem.backButtonTitle = ""
    navigationController?.isNavigationBarHidden = false
    let navBarAppearance = UINavigationBarAppearance()
    navBarAppearance.backgroundColor = Colors.headerColor
    navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .semibold)]
    navigationController?.navigationBar.standardAppearance = navBarAppearance
    navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    
    self.view.addSubview(backgroundImg)
    self.view.addSubview(chatButton)
    self.view.addSubview(loginButton)
    self.view.addSubview(animationButton)
    NSLayoutConstraint.activate([
      backgroundImg.topAnchor.constraint(equalTo: self.view.topAnchor),
      backgroundImg.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      backgroundImg.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      backgroundImg.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      chatButton.leadingAnchor.constraint(equalTo: backgroundImg.leadingAnchor, constant: 30),
      chatButton.trailingAnchor.constraint(equalTo: backgroundImg.trailingAnchor, constant: -30),
      loginButton.leadingAnchor.constraint(equalTo: backgroundImg.leadingAnchor, constant: 30),
      loginButton.trailingAnchor.constraint(equalTo: backgroundImg.trailingAnchor, constant: -30),
      loginButton.topAnchor.constraint(equalTo: chatButton.bottomAnchor, constant: 24),
      loginButton.centerYAnchor.constraint(equalTo: backgroundImg.centerYAnchor),
      animationButton.leadingAnchor.constraint(equalTo: backgroundImg.leadingAnchor, constant: 30),
      animationButton.trailingAnchor.constraint(equalTo: backgroundImg.trailingAnchor, constant: -30),
      animationButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24)
    ])
  }
  
  // MARK: - Actions
  @objc func didPressChatButton() {
    let chatView = ChatViewController()
    self.navigationController?.pushViewController(chatView, animated: true)

  }
  
  @objc func didPressLoginButton() {
    let loginViewController = LoginViewController()
    self.navigationController?.pushViewController(loginViewController, animated: true)
  }
  
  @objc func didPressAnimationButton() {
    let animationViewController = AnimationViewController()
    self.navigationController?.pushViewController(animationViewController, animated: true)
  }
}
