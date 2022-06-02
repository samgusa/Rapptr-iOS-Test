import Foundation
import UIKit


public class CustomButton: UIButton {

  let buttonText: UILabel = {
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.textAlignment = .center
    lbl.textColor = .white
    lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    return lbl
  }()

  public override func layoutSubviews() {
    super.layoutSubviews()
    setupView()
  }

  func setupView() {
    self.addSubview(buttonText)
    self.backgroundColor = Colors.headerColor

    NSLayoutConstraint.activate([
      buttonText.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
      buttonText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
      buttonText.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      buttonText.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ])
  }
}
