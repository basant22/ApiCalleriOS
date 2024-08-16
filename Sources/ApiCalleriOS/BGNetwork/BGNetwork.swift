//
//  File.swift
//  
//
//  Created by Kumar Basant on 14/08/24.
//

import Foundation
import Combine
public protocol BGNetworkProtocol{
    func makeRequest<T:Codable>(wit builder:BGRequestBuilder,type:T.Type) throws -> AnyPublisher<T,APIError>
}
public class BGNetwork:BGNetworkProtocol{
    public func makeRequest<T:Codable>(wit builder: BGRequestBuilder, type: T.Type) throws -> AnyPublisher<T, APIError>{
        do{
            let request = try builder.build()
            return URLSession.shared.dataTaskPublisher(for: request)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .tryMap{
                    data,response -> Data in
                    guard let httprespo = response as? HTTPURLResponse, (200...299).contains(httprespo.statusCode) else {
                        throw APIError.unknownError("")
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { error -> APIError in
                    if error is DecodingError{
                        return APIError.decodingError
                    }else if let error = error as? APIError{
                        return error
                    }else{
                        return APIError.unknownError("Unknown error occured")
                    }
                }
                .eraseToAnyPublisher()
        }catch{
            throw APIError.unknownError("")
        }
    }
    
    public init(){
        
    }
}
