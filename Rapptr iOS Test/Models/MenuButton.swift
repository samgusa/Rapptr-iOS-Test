import Foundation
import UIKit

public class MenuButton: UIButton {

  private let menuIcon: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFit
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()

  private let menuText: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    lbl.textColor = .label
    lbl.textAlignment = .left
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()

  private let viewModel: MenuButtonViewModel?

  init(with viewModel: MenuButtonViewModel) {
    self.viewModel = viewModel
    super.init(frame: .zero)
    configure(with: viewModel)
  }

  func setUpView() {
    self.addSubview(menuIcon)
    self.addSubview(menuText)
    self.layer.masksToBounds = true
    self.layer.cornerRadius = 8
    self.backgroundColor = .white.withAlphaComponent(0.8)

    NSLayoutConstraint.activate([
      menuIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
      menuIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 22),
      menuIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -22),
      menuIcon.heightAnchor.constraint(equalToConstant: 24),
      menuIcon.widthAnchor.constraint(equalToConstant: 24),
      menuText.leadingAnchor.constraint(equalTo: menuIcon.trailingAnchor, constant: 16),
      menuText.centerYAnchor.constraint(equalTo: self.centerYAnchor)

    ])

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configure(with viewModel: MenuButtonViewModel) {
    menuIcon.image = UIImage(named: viewModel.menuImage)
    menuText.text = viewModel.menuText
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    setUpView()
  }
}
