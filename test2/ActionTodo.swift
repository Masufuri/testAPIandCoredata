//
//  Todo.swift
//  test2
//
//  Created by User1 on 07/05/2025.
//

import Foundation
import UIKit
import Moya

struct AddData: Codable {
    let title, description, dueDate, priority: String
    let status: String
    let tags: [String]
}
struct getAllData: Codable {
    let id, title, description, dueDate: String
    let priority, status: String
    let tags: [String]
    let createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, description, dueDate, priority, status, tags, createdAt, updatedAt
        case v = "__v"
    }
}



enum ActionTodo{
    case getAll
    case create(data:AddData)
    case update(id:String,data:AddData)
    case delete(id:String)
}

extension ActionTodo:TargetType{
    var baseURL: URL {
        URL(string: "https://shrimo.com/fake-api/")!
    }
    
    var path: String {
        switch self {
        case .getAll:
            return "todos"
        case .create:
            return "todos"
        case .update(let id,_):
            return "todos/\(id)"
        case .delete(let id):
            return "todos/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAll:
            return .get
        case .create:
            return .post
        case .update(_,_):
            return .put
        case .delete(_):
            return .delete
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Moya.Task {
        switch self {
        case .getAll:
            return .requestPlain
        case .create(let data):
            return .requestJSONEncodable(data)
        case .update(let id, let data):
            return .requestJSONEncodable(data)
        case .delete(let id):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
