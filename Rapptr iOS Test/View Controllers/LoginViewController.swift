//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {

  /**
   * =========================================================================================
   * INSTRUCTIONS
   * =========================================================================================
   * 1) Make the UI look like it does in the mock-up.
   *
   * 2) Take email and password input from the user
   *
   * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
   *
   * 4) Calculate how long the API call took in milliseconds
   *
   * 5) If the response is an error display the error in a UIAlertController
   *
   * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
   *
   * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
   **/

  // MARK: - Properties
  private var client: LoginClient?

  private lazy var usernameField: PaddingTextField = {
    let txtField = PaddingTextField()
    txtField.translatesAutoresizingMaskIntoConstraints = false
    txtField.backgroundColor = .white.withAlphaComponent(0.6)
    txtField.autocapitalizationType = .none
    txtField.placeholder = "Username"
    return txtField
  }()

  private lazy var passwordField: PaddingTextField = {
    let txtField = PaddingTextField()
    txtField.translatesAutoresizingMaskIntoConstraints = false
    txtField.backgroundColor = .white.withAlphaComponent(0.6)
    txtField.autocapitalizationType = .none
    txtField.placeholder = "Password"
    return txtField
  }()

  private lazy var loginButton: CustomButton = {
    let btn = CustomButton()
    btn.buttonText.text = "LOGIN"
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.addTarget(self, action: #selector(didPressLoginButton), for: .touchUpInside)
    return btn
  }()

  private lazy var backgroundImg: UIImageView = {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.image = UIImage(named: "img_login")
    img.contentMode = .scaleAspectFill
    return img
  }()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Login"
    client = LoginClient()
    setupView()
  }

  func setupView() {
    self.view.addSubview(backgroundImg)
    self.view.addSubview(usernameField)
    self.view.addSubview(passwordField)
    self.view.addSubview(loginButton)

    NSLayoutConstraint.activate([
      backgroundImg.topAnchor.constraint(equalTo: self.view.topAnchor),
      backgroundImg.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      backgroundImg.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      backgroundImg.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      usernameField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
      usernameField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
      usernameField.heightAnchor.constraint(equalToConstant: 55),
      passwordField.heightAnchor.constraint(equalToConstant: 55),
      passwordField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
      passwordField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
      passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 24),
      loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
      loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
      loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 24),
      loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)

    ])
  }

  @objc func didPressLoginButton() {
    var alertMessage = UIAlertController(title: "", message: "", preferredStyle: .alert)

    if usernameField.hasText && passwordField.hasText {

      client?.login(email: usernameField.text ?? "", password: passwordField.text ?? "", completion: { response in
        alertMessage = UIAlertController(title: "Logged In", message: "It took \(response) seconds to finish this request", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { action in
          self.navigationController?.popViewController(animated: true)
        }
        alertMessage.addAction(ok)
        self.present(alertMessage, animated: true, completion: nil)
      }, error: { error in
        alertMessage = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertMessage.addAction(ok)
        self.present(alertMessage, animated: true, completion: nil)
      })
    } else {
      alertMessage = UIAlertController(title: "Text Empty", message: "Please Enter Username and Password", preferredStyle: .alert)
      let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertMessage.addAction(ok)
      self.present(alertMessage, animated: true, completion: nil)
    }
  }

}
