import Foundation
import Moya
import Alamofire

public class WebMobileAPIURLProvider {
    public static var baseURL: URL = {
        guard let url = URL(string: "https://revolut.duckdns.org/") else {
            fatalError("Server url failure")
        }
        return url
    }()
}

public enum WebMobileAPI {
    case getCurrency(base: String)
}


extension WebMobileAPI: TargetType, AccessTokenAuthorizable {
    
    private struct Parameters {
        static let base = "base"
    }
    
    public var baseURL: URL {
        return WebMobileAPIURLProvider.baseURL
    }
    
    public var path: String {
        switch self {
        case .getCurrency(base: _):
            return "latest"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getCurrency(base: _):
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .getCurrency(base: _):
            guard let parameters = self.parameters else {
                return Task.requestPlain
            }
            return Task.requestParameters(parameters: parameters, encoding: self.parameterEncoding)
        }
    }
    
    public var authorizationType: AuthorizationType {
        switch self {
        case .getCurrency(base: _):
            return .none
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getCurrency(base: let base):
            return [Parameters.base: base]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getCurrency(base: _):
            return URLEncoding.default
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}
