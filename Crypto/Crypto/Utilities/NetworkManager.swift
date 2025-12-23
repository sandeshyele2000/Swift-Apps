//
//  NetworkManager.swift
//  Crypto
//
//  Created by Sandesh on 27/09/25.
//

import Foundation
import Combine

class NetworkManager {
    
    
    // implementing localized error
    enum NetworkingError: LocalizedError {
        case badServerResponse(url: URL)
        case unknown
            
        var errorDescription: String? {
            switch self {
            case .badServerResponse(url: let url):
                return "Bad Response from URL \(url)"
            
            case .unknown:
                return "Unknow error occured."
            }
        }
        
    }
    
    static func getData(url: URL) -> AnyPublisher<Data, Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated)) // priority : .userInitiated > .default > .background
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher() // remove other type make it generic any publisher type
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 &&
            response.statusCode < 300
        else {
            throw NetworkingError.badServerResponse(url: url)
        }
        
        return output.data
    }
    
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        case .finished:
            break
        }
    }
    
    
    
}
