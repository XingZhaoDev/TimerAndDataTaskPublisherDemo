//
//  Post.swift
//  TestingCombine-0429
//
//  Created by Xing Zhao on 2021/4/30.
//

import Foundation

struct Post: Codable,Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

