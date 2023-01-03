//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Gilmar Junior on 02/01/23.
//

import Foundation

/// Representa o endpoint de API exclusivo
@frozen enum RMEndpoint: String {
    /// Endpoint para obter informações do personagem
    case character
    /// Endpoint para obter informações do localização
    case location
    /// Endpoint para obter informações do episódio
    case episode
}
