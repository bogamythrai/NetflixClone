//
//  Data+Extensions.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 29/05/25.
//

import Foundation
// MARK: - Data Extensions for Decoding
extension Data {
    func decode<T: Decodable>(as type: T.Type) -> T? {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try decoder.decode(T.self, from: self)
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
