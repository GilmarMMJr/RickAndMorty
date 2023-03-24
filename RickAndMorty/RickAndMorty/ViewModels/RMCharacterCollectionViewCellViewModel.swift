//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Gilmar Junior on 07/03/23.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
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
        
        RMImageLoader.shared.downloadImage(url, completion: completion)
        
    }
    
    //MARK: - Hashable
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
    
}
