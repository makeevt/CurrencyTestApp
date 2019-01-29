import Foundation
import Alamofire
import Moya

public extension MoyaProvider {
    
    public final class func customAlamofireManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        
        configuration.timeoutIntervalForRequest = 40
        configuration.timeoutIntervalForResource = 120
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        return manager
    }

}
