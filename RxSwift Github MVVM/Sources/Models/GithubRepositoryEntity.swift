//
//  GithubRepositoryEntity.swift
//  RxSwift Github MVVM
//
//  Created by Muhammad Ridho on 5/2/17.
//  Copyright © 2017 Ridho Pratama. All rights reserved.
//

import Foundation
import Mapper

struct GithubRepository: Mappable {
    let id              : Int
    let name            : String
    let url             : String?
    let description     : String?
    let starCount       : Int
    let forkCount       : Int
    let ownerUsername   : String
    
    init(map: Mapper) throws {
        try id              = map.from("id")
        try name            = map.from("name")
        description         = map.optionalFrom("description")
        url                 = map.optionalFrom("html_url")
        try starCount       = map.from("stargazers_count")
        try forkCount       = map.from("forks_count")
        try ownerUsername   = map.from("owner.login")
    }
}
