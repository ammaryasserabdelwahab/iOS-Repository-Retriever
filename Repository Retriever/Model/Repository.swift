//
//  Repository.swift
//  Repository Retriever
//
//  Created by Ammar Yasser on 20/10/2023.
//
import Foundation
struct Repository: Decodable {
    let name: String
    let owner: Owner
    let html_url: String
    
    struct Owner: Decodable {
        let login: String
        let avatar_url: String
    }
    
}
