//
//  APIRepository.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 03/09/2023.
//

import Foundation

protocol APIRepositoryType {
    func fetchUsers(completion: @escaping ([Account]) -> Void)
    func fetchProfile(profileURL: String, completion: @escaping (Account) -> Void)
    func fetchFollowers(followerURL: String, completion: @escaping ([Account]) -> Void)
    func loadImage(stringURL: String, completion: @escaping (Data) -> ())
}

final class APIRepository: APIRepositoryType {
    
    static let shared = APIRepository()
    
    private init() {}
    
    func fetchUsers(completion: @escaping ([Account]) -> Void) {
        let apiUrl = Constant.BaseUrl.userBaseUrl + "/"
        + Constant.Endpoint.userEndpoint + "/"
        + Constant.Query.userQuery
        
        if let url = URL(string: apiUrl) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let data = data {
                        let decodedData = try JSONDecoder().decode(AccountResponse.self, from: data)
                        DispatchQueue.main.async {
                            completion(decodedData.items)
                        }
                    } else {
                        print("No data")
                    }
                } catch {
                    print("Error \(error)")
                }
            }.resume()
        }
    }
    
    func fetchProfile(profileURL: String, completion: @escaping (Account) -> Void) {
        if let url = URL(string: profileURL){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let data = data {
                        let decodedData = try JSONDecoder().decode(Account.self, from: data)
                        DispatchQueue.main.async {
                            completion(decodedData)
                        }
                    } else {
                        print("No data")
                    }
                } catch {
                    print("Error \(error)")
                }
            }.resume()
        }
    }
    
    func fetchFollowers(followerURL: String, completion: @escaping ([Account]) -> Void) {
        if let url = URL(string: followerURL){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let data = data {
                        let decodedData = try JSONDecoder().decode([Account].self, from: data)
                        DispatchQueue.main.async {
                            completion(decodedData)
                        }
                    } else {
                        print("No data")
                    }
                } catch {
                    print("Error \(error)")
                }
            }.resume()
        }
    }
    
    func loadImage(stringURL: String, completion: @escaping (Data) -> ()) {
        if let url = URL(string: stringURL){
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    completion(data)
                }
            }.resume()
        }
    }
}
