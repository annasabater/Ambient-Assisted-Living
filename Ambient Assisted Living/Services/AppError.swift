//
//  AppError.swift
//  Ambient Assisted Living
//

import Foundation

enum AppError: LocalizedError {
    case notAuthenticated
    case networkError
    case decodingError
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .notAuthenticated:
            return "You are not signed in."
        case .networkError:
            return "Network connection lost."
        case .decodingError:
            return "Could not read server data."
        case .unknown(let error):
            return error.localizedDescription
        }
    }

    static func map(_ error: Error) -> AppError {
        if let appError = error as? AppError { return appError }
        let nsError = error as NSError
        if nsError.domain == NSURLErrorDomain { return .networkError }
        if error is DecodingError { return .decodingError }
        return .unknown(error)
    }
}
