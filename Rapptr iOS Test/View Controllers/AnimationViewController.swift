//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
import Combine

class AnimationViewController: UIViewController {

  /**
   * =========================================================================================
   * INSTRUCTIONS
   * =========================================================================================
   * 1) Make the UI look like it does in the mock-up.
   *
   * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
   *
   * 3) User should be able to drag the logo around the screen with his/her fingers
   *
   * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation
   *    section in Swfit to show off your skills. Anything your heart desires!
   *
   */

  private lazy var fadingView: UIImageView = {
    let img = UIImageView(frame: .zero)
    img.translatesAutoresizingMaskIntoConstraints = false
    img.image = UIImage(named: "ic_logo")
    img.contentMode = .scaleAspectFit
    img.isUserInteractionEnabled = true
    img.alpha = 0
    return img
  }()

  var viewModel = AnimationViewModel()

  var panGesture = UIPanGestureRecognizer()

  private var initialCenter: CGPoint = .zero

  private lazy var fadeButton: CustomButton = {
    let button = CustomButton()
    button.buttonText.text = "FADE IN"
    button.backgroundColor = .systemRed
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(didPressFade), for: .touchUpInside)
    return button
  }()

  private var textLabel: UILabel = {
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.textAlignment = .center
    lbl.textColor = .label
    lbl.text = "Try double tapping logo"
    lbl.numberOfLines = 0
    lbl.font = UIFont.systemFont(ofSize: 15)
    lbl.alpha = 0
    return lbl
  }()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Animation"
    self.view.addSubview(fadingView)
    fadingView.center = view.center
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
    fadingView.addGestureRecognizer(panGestureRecognizer)
    self.view.backgroundColor = .systemBackground
    setupView()

    viewModel.activateFading
      .receive(on: DispatchQueue.main)
      .sink { value in
        if value {
          UIView.animate(withDuration: 0.5) {
            self.fadingView.alpha = 1.0
            self.textLabel.alpha = 1.0
            self.fadeButton.buttonText.text = "FADE OUT"
          }
        } else {
          UIView.animate(withDuration: 0.5) {
            self.fadingView.alpha = 0.0
            self.fadeButton.buttonText.text = "FADE IN"
          }
        }
      }
      .store(in: &viewModel.cancellable)

    viewModel.changeBackgroundColor
      .receive(on: DispatchQueue.main)
      .sink {
        self.view.backgroundColor = .random()
      }
      .store(in: &viewModel.cancellable)

  }

  @objc func didPan(_ sender: UIPanGestureRecognizer) {
    fadingView.center = sender.location(in: view)
    switch sender.state {
    case .began:
      initialCenter = fadingView.center
    case .changed:
      let translation = sender.translation(in: view)

      fadingView.center = CGPoint(
        x: initialCenter.x + translation.x,
        y: initialCenter.y + translation.y
      )
    default:
      break
    }

  }

  func setupView() {
    self.view.addSubview(fadingView)
    self.view.addSubview(fadeButton)
    self.view.addSubview(textLabel)
    let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
    tap.numberOfTapsRequired = 2
    fadingView.addGestureRecognizer(tap)

    fadingView.center = view.center
    NSLayoutConstraint.activate([
      fadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      fadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

      fadeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
      fadeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
      fadeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
      textLabel.bottomAnchor.constraint(equalTo: fadeButton.topAnchor, constant: -10),
      textLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
      textLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
      textLabel.heightAnchor.constraint(equalToConstant: 50)

    ])
  }

  @objc func didPressFade() {
    self.viewModel.activateFading.value.toggle()
  }

  @objc func doubleTap() {
    self.viewModel.changeBackgroundColor.send()
  }

}
