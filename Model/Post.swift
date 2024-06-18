//
//  Post.swift
//  JSONSuite
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation
import SwiftData

@Model
final class Post: Decodable, Equatable, Identifiable, Hashable {
    
    var userId: Int
    @Attribute(.unique) var id: Int
    var title: String
    var body: String
    var isFavorite: Bool
    var createdDate: Date
    
    enum CodingKeys: String, CodingKey {
         case userId
         case id
         case title
         case body
         case isFavorite
         case createdDate
     }
    
    init(userId: Int, id: Int, title: String, body: String, createdDate: Date = Date().randomDate, isFavorite: Bool = false) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
        self.createdDate = createdDate
        self.isFavorite = isFavorite
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
        self.isFavorite = false
        self.createdDate = Date().randomDate
    }
    
}

extension Post {
    var formattedDate: String {
        createdDate.formattedDate()
    }
}

extension Array where Element == Post {
    var sortedByTitle: [Post] {
        self.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
    }
    
    var topThreeSortedByTitle: [Post] {
        Array(self.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }.prefix(3))
    }
}
