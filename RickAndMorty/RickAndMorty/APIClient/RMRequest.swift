//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Gilmar Junior on 02/01/23.
//

import Foundation

/// Objeto que representa uma chamada de API sigleton
class RMRequest {
    
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endPoint
    private let endPoint: RMEndpoint
    
    /// Path components for API, if any
    private let patchComponents: [String]
    
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the api request in String format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endPoint.rawValue
        
        if !patchComponents.isEmpty {
            patchComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentStrig = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentStrig
        }
        
        return string
    }
    
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired http method 
    public var httpMethod: RMHTTPMethod
    
    // MARK: - Public
    
    /// Construct request
    /// - Parametros:
    ///   - endpoint: Target endpoints
    ///   - pathComponents: collection of path components
    ///   - queryParameters: collection of query parameters
    public init(
        endpoint: RMEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = [],
        httpMethod: RMHTTPMethod
    
    ) {
        self.endPoint = endpoint
        self.patchComponents = pathComponents
        self.queryParameters = queryParameters
        self.httpMethod = httpMethod
    }
    /// Attempt to create request
    ///  - Parameter url: URL to parse
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0] //EndPoint
                var patchComponents: [String] = []
                if components.count > 1 {
                    patchComponents = components
                    patchComponents.removeFirst()
                }
                
                if let rmEndpoint = RMEndpoint(
                    rawValue: endpointString
                    
                ) {
                    self.init(endpoint: rmEndpoint,
                              pathComponents: patchComponents,
                              httpMethod: .get)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })
                
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(
                        endpoint: rmEndpoint,
                        queryParameters: queryItems,
                        httpMethod: .get
                    )
                    return
                }
            }
        }
        return nil
    }
    
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character,
                                                  httpMethod: .get)
}
