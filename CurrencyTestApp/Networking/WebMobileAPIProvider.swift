import Moya
import ObjectMapper


public enum WebMobileAPIProviderAuthorizationType {
    case unauthorized
}

public class WebMobileAPIProvider {
    
    // MARK:- Private properties
    
    private var provider: MoyaProvider<WebMobileAPI>!
    
    // MARK:- Public properties

    public let authorizationType: WebMobileAPIProviderAuthorizationType
    
    // MARK:- Lifecycle
    
    public init(authorizationType: WebMobileAPIProviderAuthorizationType) {
        self.authorizationType = authorizationType
        self.provider = MoyaProvider<WebMobileAPI>(manager: MoyaProvider<WebMobileAPI>.customAlamofireManager(),
                                                   plugins: [])
    }
    
    // MARK:- Public methods
    
    public func request(_ target: WebMobileAPI, queue: DispatchQueue? = DispatchQueue.global(), progress: Moya.ProgressBlock? = nil, successHandler: @escaping () -> Void, errorHandler: @escaping (WebMobileAPIError) -> Void) {
        self.request(target, queue: queue, progress: progress, successHandler: { (_ : String) in
            successHandler()
        }, errorHandler: errorHandler)
    }
    
    public func request<T: ImmutableMappable>(_ target: WebMobileAPI, queue: DispatchQueue? = DispatchQueue.global(), progress: Moya.ProgressBlock? = nil, successHandler: @escaping (T) -> Void, errorHandler: @escaping (WebMobileAPIError) -> Void) {
        self.request(target, queue: queue, progress: progress, successHandler: { (jsonString: String) in
            guard let object = try? T(JSONString: jsonString) else { errorHandler(.objectMapping); return }
            successHandler(object)
        }, errorHandler: errorHandler)
    }
    
    public func request<T: Mappable>(_ target: WebMobileAPI, queue: DispatchQueue? = DispatchQueue.global(), progress: Moya.ProgressBlock? = nil, successHandler: @escaping (T) -> Void, errorHandler: @escaping (WebMobileAPIError) -> Void) {
        self.request(target, queue: queue, progress: progress, successHandler: { (jsonString: String) in
            guard let object = T(JSONString: jsonString) else { errorHandler(.objectMapping); return }
            successHandler(object)
        }, errorHandler: errorHandler)
    }
    
    public func request<T: ImmutableMappable>(_ target: WebMobileAPI, queue: DispatchQueue? = DispatchQueue.global(), progress: Moya.ProgressBlock? = nil, successHandler: @escaping ([T]) -> Void, errorHandler: @escaping (WebMobileAPIError) -> Void) {
        self.request(target, queue: queue, progress: progress, successHandler: { (jsonString: String) in
            guard let array = try? Mapper<T>().mapArray(JSONString: jsonString) else { errorHandler(.objectMapping); return }
            successHandler(array)
        }, errorHandler: errorHandler)
    }

    public func request(_ target: WebMobileAPI, queue: DispatchQueue? = DispatchQueue.global(), progress: Moya.ProgressBlock? = nil, successHandler: @escaping (Int64) -> Void, errorHandler: @escaping (WebMobileAPIError) -> Void) {
        self.request(target, queue: queue, progress: progress, successHandler: { (string : String) in
            guard let resultInt = Int64(string) else { errorHandler(.objectMapping); return }
            successHandler(resultInt)
        }, errorHandler: errorHandler)
    }
    
    public func request<T: Mappable>(_ target: WebMobileAPI, queue: DispatchQueue? = DispatchQueue.global(), progress: Moya.ProgressBlock? = nil, successHandler: @escaping ([T]) -> Void, errorHandler: @escaping (WebMobileAPIError) -> Void) {
        self.request(target, queue: queue, progress: progress, successHandler: { (jsonString: String) in
            guard let array = Mapper<T>().mapArray(JSONString: jsonString) else { errorHandler(.objectMapping); return }
            successHandler(array)
        }, errorHandler: errorHandler)
    }
    
    func request(_ target: WebMobileAPI, queue: DispatchQueue?, progress: Moya.ProgressBlock?, successHandler: @escaping (String) -> Void, errorHandler: @escaping (WebMobileAPIError) -> Void) {
        self.request(target, queue: queue, progress: progress, successHandler: { (response: Response) in
            let jsonString = String(data: response.data, encoding: String.Encoding.utf8) ?? String()
            successHandler(jsonString)
        }, errorHandler: errorHandler)
    }
    
    @discardableResult
    func request(_ target: WebMobileAPI, queue: DispatchQueue?, progress: Moya.ProgressBlock?, successHandler: @escaping (Response) -> Void, errorHandler: @escaping (WebMobileAPIError) -> Void) -> Moya.Cancellable{
        return provider.request(target, callbackQueue: queue, progress: progress, completion: { result in
            switch result {
            case .success(let response):
                successHandler(response)
            case .failure(let error):
                errorHandler(WebMobileAPIError.buildNetworkError(from: error))
            }
        })
    }
    
}
