//
//  File.swift
//  
//
//  Created by Kumar Basant on 14/08/24.
//

import Foundation
public protocol BGRequestProtocol{
    var baseURL:URL {get}
    var endPoint:String {get}
    var method:HTTPMetod {get}
    var header:[String:String]? {get}
    var parameters:BGRequestParameters? {get}
}
