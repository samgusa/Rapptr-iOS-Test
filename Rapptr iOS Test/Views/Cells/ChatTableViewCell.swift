//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatTableViewCell: UITableViewCell {

    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/

    // MARK: - Outlets


  private lazy var avatarImg: UIImageView = {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()

  private lazy var header: UILabel = {
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
    lbl.sizeToFit()
    lbl.numberOfLines = 0
    lbl.textColor = Colors.chatColor
    return lbl
  }()

  private lazy var body: PaddingLabel =  {
    let lbl = PaddingLabel()
    lbl.textColor = Colors.chatColor
    lbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    lbl.sizeToFit()
    lbl.layer.cornerRadius = 0.5
    lbl.lineBreakMode = .byWordWrapping
    lbl.adjustsFontSizeToFitWidth = true
    lbl.backgroundColor = .white
    lbl.numberOfLines = 0
    lbl.contentMode = .topLeft
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

  private func setupView() {
    self.contentView.addSubview(avatarImg)
    avatarImg.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(header)
    header.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(body)
    body.translatesAutoresizingMaskIntoConstraints = false

    avatarImg.layer.cornerRadius = avatarImg.layer.bounds.width / 2
    avatarImg.clipsToBounds = true
    body.layer.masksToBounds = true
    body.layer.cornerRadius = 10

    self.backgroundColor = Colors.chatBackground

    NSLayoutConstraint.activate([
      avatarImg.heightAnchor.constraint(equalToConstant: 50),
      avatarImg.widthAnchor.constraint(equalToConstant: 50),
      avatarImg.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
      avatarImg.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
      header.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
      header.leadingAnchor.constraint(equalTo: avatarImg.trailingAnchor, constant: 7),
      header.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -36),
      header.heightAnchor.constraint(equalToConstant: 21),

      body.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8),
      body.leadingAnchor.constraint(equalTo: header.leadingAnchor),
      body.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -36)
    ])
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setupView()
  }

    // MARK: - Public
    func setCellData(message: Message) {
        header.text = message.username
        body.text = message.text
        avatarImg.downloaded(from: message.avatarURL ?? "")

    }

}



