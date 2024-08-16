//
//  File.swift
//  
//
//  Created by Kumar Basant on 14/08/24.
//

import Foundation
public protocol BGRequest{
    
   
    
    init(baseURL:URL,endPoint:String)
    
    @discardableResult
    func set(method:HTTPMetod) -> Self
    
    @discardableResult
    func set(endPoint:String) -> Self
    
    @discardableResult
    func set(headers:[String:String]?) -> Self
    
    @discardableResult
    func set(parameters:BGRequestParameters) -> Self
    
   func build() throws -> URLRequest
    
}
