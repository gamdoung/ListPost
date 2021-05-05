//
//  PostData.swift
//  Posts
//
//  Created by Gam Doung on 23/2/2564 BE.
//

class DummyPosts: Codable{
    var posts: [DummyPost]?

    
    enum CodingKeys: String, CodingKey {
        case posts = "data"
    }
}

class DummyPost: Codable {
    var owner: Owner?
    var id: String?
    var image: String?
    var publishDate: String?
    var text: String?
    var tags: [String]?
    var link: String?
    var likes: Int?
    
    enum Codingkeys: String, CodingKey {
        case owner
        case id
        case image
        case publishDate
        case text
        case tags
        case link
        case likes
        
    }
}

class DummyComments: Codable{
    var comments: [DummyComment]?

    
    enum CodingKeys: String, CodingKey {
        case comments = "data"
    }
}

class DummyComment: Codable {
    var owner: Owner?
    var commentPost: DummyPost?
    var id: String?
    var message: String?
    var publishDate: String?
    
    enum CodingKeys: String, CodingKey {
        case owner
        case commentPost
        case id
        case message
        case publishDate
    }
    
}

class Owner: Codable {
    var id: String?
    var email: String?
    var title: String?
    var picture: String?
    var firstName: String?
    var lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case title
        case picture
        case firstName
        case lastName
    }
    
}
