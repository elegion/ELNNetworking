# ELFNetworking

Библиотека для работы с сетью на свифте.

##Installation

### Cocoapods

```
source 'https://github.com/elegion/ios-podspecs.git'
source 'https://github.com/CocoaPods/Specs.git'

pod 'ELNNetworking'
```
###Carthage

```
github 'elegion/ios-ELNNetworking'
```

## Usage

Каждый запрос на сервер представлен в виде двух объектов — запроса и ответа, которые должны быть объявлены так:

``` swift
import ELNNetworking

struct UserAgentResponse : ResponseObjectSerializable {

    var userAgent: String?

    init(response: NSHTTPURLResponse, representation: AnyObject) throws {
        userAgent = representation.valueForKey("user-agent") as? String
    }

}

struct UserAgentRequest : Request {

    typealias ResponseType = UserAgentResponse

    var requestParameters: RequestParameters {
        return RequestParameters(.GET, "https://httpbin.org/user-agent")
    }

}
```

Для отправки запросов существует класс `Client`, который является оберткой над `Alamofire`. Отправка запроса выглядит так:

``` swift
let request = UserAgentRequest()
let client = Client()
client.request(request) { response in
    if let error = response.result.error {
        // print error
    }
	if let value = response.result.value {
        // value is automatically inferred to have `UserAgentResponse` type
    }
}
```

## Contribution

###Cocoapods

```sh
# download source code, fix bugs, implement new features

pod repo add legion https://github.com/elegion/ios-podspecs
pod repo push legion ELNNetworking.podspec
```
##TODO

- Mocks
- Response cache for offline mode