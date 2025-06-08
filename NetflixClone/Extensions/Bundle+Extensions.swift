//
//  Bundle+Extensions.swift
//  NetflixClone
//
//  Created by Mythrai Boga on 29/05/25.
//

import Foundation

extension Bundle {
    /// Returns the URL for the specified resource in the bundle.
    /// - Parameter resource: The name of the resource file.
    /// - Returns: The URL of the resource file, or nil if not found.
    static func data(for resource: String, type: String) throws -> Data? {
        guard let url = Bundle.main.url(forResource: resource, withExtension: type)
        else {
            print("Resource \(resource) not found in bundle.")
            return nil
        }
        return try? Data(contentsOf: url)
    }
}
