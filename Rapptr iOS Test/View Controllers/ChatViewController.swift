//
//  ChatViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
import Combine

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  /**
   * =========================================================================================
   * INSTRUCTIONS
   * =========================================================================================
   * 1) Make the UI look like it does in the mock-up.
   *
   * 2) Using the following endpoint, fetch chat data
   *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
   *
   * 3) Parse the chat data using 'Message' model
   *
   **/

  // MARK: - Properties
  private var client: ChatClient?
  private var messages: [Message] = []
  // MARK: - Outlets
  private let chatTable: DynamicSizeTableView = {
    let table = DynamicSizeTableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    return table
  }()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Colors.viewBackColor
    messages = [Message]()
    configureTable()
    title = "Chat"

    client = ChatClient()

    client?.fetchChatData(completion: { message in
      self.messages.removeAll()
      self.messages = message

      DispatchQueue.main.async {
        self.chatTable.reloadData()
      }
    }, error: { error in
      print("there was an error with fetching chat data: \(error ?? "")")
    })

    chatTable.reloadData()
  }

  // MARK: - Private
  private func configureTable() {
    chatTable.delegate = self
    chatTable.dataSource = self
    chatTable.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatTableViewCell")
    chatTable.tableFooterView = UIView(frame: .zero)
    chatTable.separatorStyle = .none

    self.chatTable.backgroundColor = Colors.chatBackground

    self.view.addSubview(chatTable)
    NSLayoutConstraint.activate([
      chatTable.topAnchor.constraint(equalTo: self.view.topAnchor),
      chatTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      chatTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      chatTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)

    ])
  }

  // MARK: - UITableViewDataSource
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
    cell.setCellData(message: messages[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 125
  }

}
