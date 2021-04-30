//
//  APIError.swift
//  TimerAndDataTaskPublisherDemo
//
//  Created by Xing Zhao on 2021/4/30.
//

import Foundation

enum APIError: Error {
    case decodingError // error may occur when parsing data
    case httpError    // http request error
    case unknown      // unknown error
}

extension APIError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from the server"
        case .httpError:
            return "HTTP request error"
        case .unknown:
            return "Unknown Error"
        }
    }
}
