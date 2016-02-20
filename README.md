# ELFNetworking

Библиотека для работы с сетью на свифте.

## Usage

Каждый запрос на сервер представлен в виде двух объектов — запроса и ответа, которые должны быть объявлены так:

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
client.request(request).response { response in
	// value is instance of UserAgentResponse
	let value = response.result.value?.userAgent 
}
```

## TODO

- Mocks