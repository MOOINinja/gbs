//
//  Models.swift
//  GoBetSearch
//
//  Created by Patrik Adolfsson on 2017-07-18.
//  Copyright © 2017 Patrik Adolfsson. All rights reserved.
//

import Foundation


public struct User {
    var Id: Int64
    var FirstName: String
    var LastName: String
    var Email: String
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "id" : Id,
            "firstName" : FirstName,
            "lastName" : LastName,
            "email" : Email
        ]
    }
}

public struct Operator {
    var Id: String
    var OperatorId: Int
    var Name: String
    var Rank: Int
    var Url: String
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "Id" : Id,
            "OperatorId" : OperatorId,
            "Name" : Name,
            "Rank" : Rank,
            "Url" : Url
        ]
    }
}

public struct Sport {
    var Id: String
    var SportId: Int64
    var SportName: String
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "Id" : Id,
            "SportId" : SportId,
            "SportName" : SportName
        ]
    }
}

public struct Game {
    var Id: String
    var Name: String
    var Description: String
    var Url: String
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "Id" : Id,
            "Name" : Name,
            "Description" : Description,
            "Url": Url
        ]
    }
}

public struct Leaderboard {
    var Id: String
    var Game: Game
    var Users: [User]
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "Id" : Id,
            "Game" : Game,
            "Users" : Users
        ]
    }
}

public struct Offer {
    var Id: String
    var Name: String
    var Description: String
    var Value: String
    var Operator: Operator
    var Url: String
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "Id" : Id,
            "Name" : Name,
            "Description" : Description,
            "Value": Value,
            "Operator": Operator,
            "Url": Url
        ]
    }
}

