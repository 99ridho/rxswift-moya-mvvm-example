//
//  RepositoryListViewModel.swift
//  RxSwift Github MVVM
//
//  Created by Muhammad Ridho on 5/2/17.
//  Copyright © 2017 Ridho Pratama. All rights reserved.
//

import Foundation
import RxSwift

struct RepositoryListViewModel {
    
    let githubAPIClient = GithubAPIClient()
    
    func getReposName(username: Observable<String>) -> Observable<[(String, String)]> {
        return githubAPIClient
            .findRepos(withUsername: username)
            .map { repos in
                return repos.map { repo in
                    return (
                        name: "\(repo.ownerUsername)/\(repo.name)",
                        detail: "\(repo.starCount) stars - \(repo.forkCount) forks"
                    )
                }
            }
    }
    
}
