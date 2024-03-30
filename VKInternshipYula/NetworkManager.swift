//
//  NetworkManager.swift
//  VKInternshipYula
//
//  Created by Тимур Жексимбаев on 30.03.2024.
//

import Foundation

enum NetworkErrorMessages: String {
    case noSuchURL = "No such URL"
    case couldNotFetchActualData = "Could not fetch actual data"
    case badResponse = "Bad response"
    case fetchingData = "Error fetching data"
}

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    @Published var services = [ServiceModel]()
    
    func getData() {
        let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
        guard let url = URL(string: urlString) else {
            print(NetworkErrorMessages.noSuchURL.rawValue)
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data else {
                print(NetworkErrorMessages.couldNotFetchActualData.rawValue)
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print(NetworkErrorMessages.badResponse.rawValue)
                return
            }
            
            if let error = error {
                print("\(NetworkErrorMessages.fetchingData.rawValue): \(error)")
                return
            }
            
            do {
                
                let decodedData = try JSONDecoder().decode(Model.self, from: data)
                guard let decodedServices = decodedData.body else {
                    return
                }
                
                guard let fetchedServices = decodedServices.services else {
                    return
                }
                DispatchQueue.main.async {
                    self.services = fetchedServices
                }
                
                
                
            } catch {
                print(error.localizedDescription)
            }
                
            
        }.resume()
    }
}
