//
//  apiCalls.swift
//  Universities
//
//  Created by Daniyal Ahmed on 09/10/2024.
//

import Foundation

struct University: Identifiable, Codable {
    var id = UUID()
    var alpha_two_code: String
    var country: String
    var domains: [String]
    var state_province: String?
    var name: String
    var web_pages: [String]
    
    enum CodingKeys: String, CodingKey {
        case alpha_two_code
        case country
        case domains
        case state_province = "state-province"
        case name
        case web_pages
    }
}

class UniversityService {
    func fetchUniversities(country: String, completion: @escaping ([University]) -> Void) {
        let urlString = "http://universities.hipolabs.com/search?country=\(country)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let universities = try? JSONDecoder().decode([University].self, from: data)
                completion(universities ?? [])
            }
        }.resume()
    }
}
