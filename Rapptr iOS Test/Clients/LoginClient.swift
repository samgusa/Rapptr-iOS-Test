//
//  LoginClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation
import Alamofire

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 *
*/

class LoginClient {

    var session: URLSession?

  func login(email: String, password: String, completion: @escaping (String) -> Void, error errorHandler: @escaping (String?) -> Void) {
      let login = LoginData(email: email, password: password)

      AF.request("http://dev.rapptrlabs.com/Tests/scripts/login.php",
                 method: .post,
                 parameters: login
          )
            .validate().response{ response in
          switch response.result {
          case .success:
              completion(response.metrics.map { "\($0.taskInterval.duration)s" } ?? "None")
          case .failure(let error):
              errorHandler(error.errorDescription)
          }
      }
  }

}

struct LoginData: Encodable {
  let email: String
  let password: String
}
