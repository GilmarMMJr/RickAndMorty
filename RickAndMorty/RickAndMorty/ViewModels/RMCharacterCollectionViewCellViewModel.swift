//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Gilmar Junior on 07/03/23.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {
    
    private let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    init(characterName: String,
         characterStatusText: RMCharacterStatus,
         characterUrlImage: URL?)
    {
        self.characterName = characterName
        self.characterStatus = characterStatusText
        self.characterImageUrl = characterUrlImage
        
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public var characterNameText: String {
        return characterName
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        // TODO: Abstract to image Manager
        
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))

        }
        task.resume()
        
    }
    
}
