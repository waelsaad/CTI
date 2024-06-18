//
//  Comment.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

struct Comment: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
