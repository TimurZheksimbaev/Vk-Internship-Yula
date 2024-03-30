//
//  ServiceView.swift
//  VKInternshipYula
//
//  Created by Тимур Жексимбаев on 30.03.2024.
//

import Foundation
import SwiftUI

enum ServiceViewErrorMessages: String {
    case errorLoadingImage = "Error loading image"
    case noName = "No name"
    case noDescription = "No description"
}

let imageSize: CGFloat = 70
let spacingBetweenImageAndText: CGFloat = 15
let spacingBetweenNameAndDescription: CGFloat = 3

struct ServiceView: View {
    let service: ServiceModel
    
    var body: some View {
        HStack(spacing: spacingBetweenImageAndText) {
            
            if let iconURL = service.icon_url {
                AsyncImage(url: URL(string: iconURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                    } else if phase.error != nil {
                        Text(ServiceViewErrorMessages.errorLoadingImage.rawValue)
                    } else {
                        ProgressView()
                    }
                }
                
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
            }
            
            
            
            VStack(alignment: .leading, spacing: spacingBetweenNameAndDescription) {
                if let name = service.name {
                    Text(name).font(.title2)
                } else {
                    Text(ServiceViewErrorMessages.noName.rawValue).font(.title2)
                }
               
                if let description = service.description {
                    Text(description).font(.caption)
                } else {
                    Text(ServiceViewErrorMessages.noDescription.rawValue).font(.caption)
                }
                
            }.padding(.bottom)
            
            
        }
        
            
        
        
        
    }
}

#Preview {
    ServiceView(service: ServiceModel(name: "Сферум", description: "Онлайн-платформа для обучения и образовательных коммуникаций", link: "https://sferum.ru/?p=start", icon_url: "https://publicstorage.hb.bizmrg.com/sirius/sferum.png"))
}
