//
//  File.swift
//  
//
//  Created by Kumar Basant on 14/08/24.
//

import Foundation

public enum APIError:Error{
    case urlError
    case decodingError
    case unknownError(String)
}
