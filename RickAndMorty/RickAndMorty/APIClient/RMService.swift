//
//  RMService.swift
//  RickAndMorty
//
//  Created by Gilmar Junior on 02/01/23.
//

import Foundation

/// Objeto de serviço primário da API para obter dados de Rick and Morty
final class RMService {
    /// Instância singleton compartilhada
    static let shared = RMService()
    
    /// Construtor Privatizado
    private init() {}
    
    /// Enviar chamada de API de Rick e Morty
    /// - Parametros:
    ///   - request: Instãncia da requisição
    ///   - completion: Callback com data ou error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
    
    
}
