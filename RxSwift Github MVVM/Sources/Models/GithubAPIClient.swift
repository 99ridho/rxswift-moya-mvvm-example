//
//  GithubAPIClient.swift
//  RxSwift Github MVVM
//
//  Created by Muhammad Ridho on 5/2/17.
//  Copyright © 2017 Ridho Pratama. All rights reserved.
//

import Foundation
import Moya
import Moya_ModelMapper
import Mapper
import RxSwift
import RxOptional

struct GithubAPIClient {
    
    let provider = RxMoyaProvider<Github>()
    
    func findRepos(withUsername username: Observable<String>) -> Observable<[GithubRepository]> {
        return username
            .flatMapLatest { uname -> Observable<[GithubRepository]?> in
                return self.provider
                    .request(Github.repos(withUsername: uname))
                    .mapArrayOptional(type: GithubRepository.self)
                    .retry(3)
            }
            .replaceNilWith([])
        
    }
    
}
