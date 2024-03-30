//
//  ContentView.swift
//  VKInternshipYula
//
//  Created by Тимур Жексимбаев on 30.03.2024.
//

import SwiftUI

enum ErrorMessages: String {
    case noLink = "There is no link"
    case noSuchURL = "No such URL"
}

let servicesConstant = "Сервисы"

struct ContentView: View {
    @StateObject private var networkManager = NetworkManager.shared
    
    init() {
        networkManager.getData()
    }
     
    var body: some View {
        VStack {
            Text(servicesConstant).font(.title).padding(.top)
            List {
                ForEach(networkManager.services, id: \.self) { service in
                    ServiceView(service: service).onTapGesture {
                        guard let serviceLink = service.link else {
                            print(ErrorMessages.noLink.rawValue)
                            return
                        }
                        guard let linkURL = URL(string: serviceLink) else {
                            print(ErrorMessages.noSuchURL.rawValue)
                            return
                        }
                        DispatchQueue.main.async {
                            UIApplication.shared.open(linkURL, options: [:], completionHandler: nil)
                        }
                    }
                }
                .padding(.top)
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
