//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Gilmar Junior on 04/01/23.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
}

final class RMCharacterListViewViewModel: NSObject {
    
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let ViewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatusText: character.status,
                    characterUrlImage: URL(string: character.image)
                )
                cellViewModels.append(ViewModel)
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    public func fechCharacters() {
        RMService.shared.execute(.listCharactersRequests,
                                 expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
}


extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
                                                          for: indexPath) as? RMCharacterCollectionViewCell else {
          fatalError("Unsuported cell")
      }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width,
                      height: width * 1.5)
    }
    
}
