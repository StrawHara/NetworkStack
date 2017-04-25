NetworkStack
===========
[![Language: Swift 3.1](https://img.shields.io/badge/Swift-3.1-orange.svg?style=flat-square)](https://swift.org)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/NetworkStack.svg?style=flat-square)](https://cocoapods.org/pods/NetworkStack)
[![CocoaPods](https://img.shields.io/cocoapods/p/NetworkStack.svg?style=flat-square)]()
[![Twitter](https://img.shields.io/badge/twitter-@Niji_Digital-blue.svg?style=flat-square)](http://twitter.com/Niji_Digital)
[![Twitter](https://img.shields.io/badge/website-niji.fr-green.svg?style=flat-square)](http://niji.fr)
[![CocoaPods](https://img.shields.io/cocoapods/l/NetworkStack.svg?style=flat-square)](LICENSE)

<img src="cover.png">

`NetworkStack` is a network library to send requests easily. Based on [Alamofire](https://github.com/Alamofire/Alamofire), you will find all your habits. This is the best way to work with [RxSwift](https://github.com/ReactiveX/RxSwift) and [Alamofire](https://github.com/Alamofire/Alamofire) to add some functionnalities like automatic renewing token or upload files.
 
# Installation
 
## CocoaPods

Using [CocoaPods](https://guides.cocoapods.org) is the recommended way :

- In your Podfile, add `use_frameworks!` and pod `NetworkStack` to your main and test targets.
- Run `pod repo update` to make CocoaPods aware of the latest available Realm versions.
- Simply add `pod 'NetworkStack'` to your `Podfile`.

```ruby
pod 'NetworkStack'
```

From the command line, run `pod install`

# Documentation & Usage Examples

We have specific wikis. It will be helpful for you if you want to implement advanced or specific behaviour. We support :

----------------

<p align="center">
    <a href="Documentation/BasicRequests.md">Basic requests</a> &bull;
    <a href="Documentation/UploadRequests.md">Upload requests</a> &bull; 
    <a href="Documentation/OAuth2.md">OAuth2</a> &bull; 
    <a href="Documentation/CustomRequests.md">Custom requests</a> &bull; 
    <a href="Documentation/CustomSessionManager.md">Custom SessionManager</a> &bull; 
    <a href="Documentation/AutoRetry.md">Auto retry</a>
</p>

----------------

##Simple Usage


### Setup 
```swift
let baseStringURL = "http://networkstack.fr/api/v1"
let keychainService: KeychainService = KeychainService(serviceType: "com.networkstack.keychain")
let networkStack = NetworkStack(baseURL: baseStringURL, keychainService: keychainService)
```
To customize your request you have flexibility. Free for you to create your `SessionManager` to change behaviour of requesting inside `NetworkStack`. `NetworkStack` has two properties that you can set :

- **requestManager:** `Alamofire.SessionManager` is `Alamofire.SessionManager()` by default
- **uploadManager:**  `Alamofire.SessionManager` is `nil` by default

### Routes as Routable protocol
`NetworkStack` has **`Routable`** protocol to create path for endpoints of your requests.

```swift
public struct Route: Routable {
  public let path: String
  init(path: String) { self.path = path }
}

extension Route: CustomStringConvertible {
  public var description: String { return path }
}

extension Route {
  public static func authent() -> Route { return Route(path: "/authent") }
}
```

### RequestParameters
This is the core of requests creation. Request parameters can take : 

**`RequestParameters`** :

- **method:** ` Alamofire.HTTPMethod`
- **route:** `Routable`
- **needsAuthorization:** `Bool = false`
- **parameters:** `Alamofire.Parameters? = nil`
- **parametersEncoding:** `Alamofire.ParameterEncoding = JSONEncoding.default`
- **headers:** `Alamofire.HTTPHeaders? = nil`

```swift
let requestParameters = RequestParameters(method: .get,
                                          route: Route.authent(),
                                          parameters: nil, // [String: Any] type
                                          needsAuthorization: false,
                                          parametersEncoding: URLEncoding.httpBody,
                                          headers: nil) // [String: String] type
```


***For Upload :** **`UploadRequestParameters`** :

- **method:** ` Alamofire.HTTPMethod = .post`
- **route:** `Routable`
- **needsAuthorization:** `Bool = true`
- **uploadFiles:** `[UploadRequestParametersFile]`
- **parameters:** `Alamofire.Parameters? = nil`
- **headers:** `Alamofire.HTTPHeaders? = nil`


### Requests

```swift
func sendRequestWithDataResponse(requestParameters: RequestParameters) -> Observable<(HTTPURLResponse, Data)>

func sendRequestWithJSONResponse(requestParameters: RequestParameters) -> Observable<(HTTPURLResponse, Any)>

// For Uploads
func sendUploadRequestWithDataResponse(uploadRequestParameters: UploadRequestParameters) -> Observable<(HTTPURLResponse, Data)>

func sendUploadRequestWithDataResponse(uploadRequestParameters: UploadRequestParameters) -> Observable<(HTTPURLResponse, Any)>

func sendBackgroundUploadRequest(uploadRequestParameters: UploadRequestParameters) -> Observable<URLSessionTask>
```

### Send request and response
```swift
networkStack.sendRequestWithJSONResponse(requestParameters: requestParameters)
  .subscribe({ (event: Event<(HTTPURLResponse, Any)>) in
    switch event {
    case .next(let json):
      // do something with the json response or statusCode
      break
    case .error(let error):
      // do something with NetworkStackError
      break
    case .completed:
      // do something when observable completed
      break
    }
  }).addDisposableTo(self.disposeBag)
```

### Errors 
Network stack use several error that you can use to manage your app errors. 

```swift
public enum NetworkStackError: Error {
  /// No internet, roaming off, data not allowed, call active, …
  case noInternet(error: Error)
  /// DNS Lookup failed, Host unreachable, …
  case serverUnreachable(error: Error)
  /// Invalid request, Fail to parse JSON, Unable to decode payload…
  case badServerResponse(error: Error)
  /// Response in 4xx-5xx range
  case http(httpURLResponse: HTTPURLResponse, data: Data?)
  /// Fail to parse response
  case parseError
  /// Other, unclassified error
  case otherError(error: Error)
  /// Request building has failed
  case requestBuildFail
  /// Upload manager has not been setup
  case uploadManagerIsNotSet
  /// Unknown
  case unknown
}
```

## More examples & Help Topics
We have some examples :

- [Simple usage](Example/SimpleDemo/README.md)
- [MoyaComparison](Example/MoyaComparison/README.md)

# License

This code is distributed under [the Apache 2 License](LICENSE).