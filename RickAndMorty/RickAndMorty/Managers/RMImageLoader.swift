//
//  RMImageLoader.swift
//  RickAndMorty
//
//  Created by Gilmar Junior on 22/03/23.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    
    private var imageDataCache = NSCache<NSString,NSData>()
    
    private init() {}
    
    public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        /// Get image content with URL
        ///  - Parametrs
        ///        - url: Source URL
        ///        - completion: Callback
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            let key = url.absoluteString as NSString
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))

        }
        task.resume()
    }
}
