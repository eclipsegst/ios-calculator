//
//  File.swift
//  Autolayout
//
//  Created by iOS Students on 5/12/15.
//  Copyright (c) 2015 Zhaolong Zhong. All rights reserved.
//

import Foundation

struct User {
    
    let name: String
    let company: String
    let login: String
    let password: String
    
    static func login(login: String, password: String) -> User? {
        if let user = database[login] {
            if user.password == password {
                return user
            }
        }
        return nil
    }
    
    static let database: Dictionary<String, User> = {
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(name: "Apple", company: "Apple Inc.", login: "apple", password: "lol"),
            User(name: "Google", company: "Google Inc", login: "google", password: "lol"),
            User(name: "Microsoft", company: "Microsoft Corperation", login: "microsoft", password: "lol")
            ] {
                theDatabase[user.login] = user
        }
        return theDatabase
        }()
}