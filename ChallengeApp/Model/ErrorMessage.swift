//
//  ErrorMessage.swift
//  ChallengeApp
//
//  Created by Joel Alcantara on 7/12/23.
//  Copyright © 2023 JoelsTeam. All rights reserved.
//

import Foundation

struct ErrorMessage: Codable {
    var value: String
    
    enum CodingKeys: CodingKey, CaseIterable {
        case message
        case error
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        var didInit = false
        if let errorMessage = try? container.decodeIfPresent(String.self, forKey: .message) {
            value = errorMessage
            didInit = true
        }
        if !didInit {
            if let errorMessage = try? container.decodeIfPresent(String.self, forKey: .error) {
                value = errorMessage
            }
        }
        let context = DecodingError.Context(codingPath: CodingKeys.allCases, debugDescription: "No cases match found")
        throw DecodingError.dataCorrupted(context)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .error)
    }
}
