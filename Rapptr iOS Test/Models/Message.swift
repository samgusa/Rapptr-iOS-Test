//
//  Message.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

struct ReceivedMessages: Decodable {
    let data: [Message]

    enum CodingKeys: String, CodingKey {
        case data = "data"
      }
}
struct Message: Decodable {
    var userID: String?
    var username: String
    var avatarURL: String?
    var text: String

    init(testName: String, withTestMessage message: String) {
        self.userID = "0"
        self.username = testName
        self.avatarURL =  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/220px-Smiley.svg.png"
        self.text = message
    }
}



