import Foundation

public enum WebMobileAPIError: Swift.Error {
    // Common errors
    case objectMapping
    case unknown
    // Server errors
    case serverInternalError(statusCode: Int)   // statusCode >= 500
    case resourceNotFound                       // statusCode == 404
    case notAllowed                             // statusCode == 405
    // Network errors
    case noInternetConnection
    case connectionTimeout
    
    static func buildNetworkError(from error: Swift.Error) -> WebMobileAPIError {
        let error = error as NSError
        if error.domain != NSURLErrorDomain {
            return WebMobileAPIError.unknown // Should not happen
        }
        switch error.code {
        case NSURLErrorCannotFindHost,
             NSURLErrorCannotConnectToHost,
             NSURLErrorNetworkConnectionLost,
             NSURLErrorDNSLookupFailed,
             NSURLErrorHTTPTooManyRedirects,
             NSURLErrorResourceUnavailable,
             NSURLErrorNotConnectedToInternet:
            return WebMobileAPIError.noInternetConnection
        case NSURLErrorTimedOut:
            return WebMobileAPIError.connectionTimeout
        default:
            return WebMobileAPIError.unknown // Should not happen
        }
    }
}

//MARK: - Extensions
public extension WebMobileAPIError {
    public var isNetworkOrInternalServerError: Bool {
        switch self {
        case .serverInternalError, .noInternetConnection, .connectionTimeout:
            return true
        default:
            return false
        }
    }
}
