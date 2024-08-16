//
//  File.swift
//
//
//  Created by Kumar Basant on 14/08/24.
//

import Foundation
public final class BGRequestBuilder:BGRequest{
    
    private var baseURL:URL!
    private var endPoint:String!
    private var method:HTTPMetod = .get
    private var header:[String:String]?
    private var parameters:BGRequestParameters?
    
    public init(baseURL: URL, endPoint: String) {
        self.baseURL = baseURL
        self.endPoint = endPoint
    }
    
    public func set(method: HTTPMetod) -> Self {
        self.method = method
        return self
        
    }
    
    public func set(endPoint: String) -> Self {
        self.endPoint = endPoint
        return self
    }
    
    public func set(headers: [String : String]?) -> Self {
        self.header = headers
        return self
    }
    
    public func set(parameters: BGRequestParameters) -> Self {
        self.parameters = parameters
        return self
    }
    
    public func build() throws -> URLRequest {
        let url = baseURL.appendingPathExtension(endPoint)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = header
        setUpBody(urlRequest: &urlRequest)
        return urlRequest
    }
    
    private func setUpBody(urlRequest:inout URLRequest){
        if let parameters = parameters{
            switch parameters {
            case .body(let bodyParam):
                setupRequestBody(bodyParam, urlRequest: &urlRequest)
            case .url(let urlParam):
                setupRequestUrl(urlParam, urlRequest: &urlRequest)
            }
        }
    }
    private func setupRequestBody(_ parameters:[String:Any]?,urlRequest:inout URLRequest){
        if let parameters = parameters{
            let data = try? JSONSerialization.data(withJSONObject: parameters,options: [])
            urlRequest.httpBody = data
        }
    }
    private func setupRequestUrl(_ parameters:[String:String]?,urlRequest:inout URLRequest){
        if let parameters = parameters,let url = urlRequest.url, var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true){
            urlComponent.queryItems = parameters.map{
                URLQueryItem(name: $0.key, value: $0.value)
            }
            urlRequest.url = urlComponent.url
        }
    }
}
