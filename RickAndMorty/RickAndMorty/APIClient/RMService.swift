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
    
    enum RMServiceError: Error{
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Enviar chamada de API de Rick e Morty
    /// - Parametros:
    ///   - request: Instãncia da requisição
    ///   - type: O tipo de objeto que esperamos receber de volta
    ///   - completion: Callback com data ou error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        print("API call: \(request.url?.absoluteString ?? "")")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
            do {
                /// decodificando para um json padrão
                //let json = try JSONSerialization.jsonObject(with: data)
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    //MARK: - Private
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod.rawValue
        
        return request
    }
    
}
