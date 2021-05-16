//
//  NetworkService.swift
//  MediaAlbumApp
//
//  Created by APPLE on 15/05/21.
//

import Foundation
import Alamofire


fileprivate enum APIs: URLRequestConvertible {

    private static let endpoint = URL(string: "https://jsonplaceholder.typicode.com/")!
    private static let apiKey = ""

    static let reachability = NetworkReachabilityManager()
    
    case albums
    case photos(albumId : Int)
    
    var path: String {
        switch self {
        case .albums:
            return "albums"
        case .photos:
            return "photos"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding : URLEncoding {
        return URLEncoding.init(destination: .queryString, arrayEncoding: .noBrackets)
    }

    func addApiHeaders(request: inout URLRequest) {
    }

    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: Self.endpoint.appendingPathComponent(path))
        var parameters = Parameters()
        switch self {
        case .albums: break

        case .photos(let albumId):
            parameters["albumId"] = albumId
        }
        addApiHeaders(request: &request)
        request = try encoding.encode(request, with: parameters)
        return request
    }

}

enum APIError : Error {

    case networkError
    case decodingError
    case responseError(Error)
    case other(Int?)
    
    var errorMessage : String {
        switch self {
        case .networkError:
            return NSLocalizedString("Please check your internet connection", comment: "")
        case .responseError(let error):
            return error.localizedDescription
        case .other(let code):
            return String(format:  NSLocalizedString("Something went wrong. Response status code was %d", comment: ""), (code ?? 0))
        case .decodingError:
            return NSLocalizedString("Something went wrong with response", comment: "")
        }
    }
}

struct NetworkManager {
   private let jsonDecoder = JSONDecoder()

    @discardableResult
    func fetchAlbums(completion: @escaping(Result<[AlbumDM],APIError>) -> ()) -> DataRequest {

        return AF.request(APIs.albums).validate().responseJSON { (response) in

            switch response.result {
            case .failure(let error):
                completion(.failure(.responseError(error)))
                
            case .success(let jsonData):
               
                guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted) else {
                    completion(.failure(.other(response.response?.statusCode)))
                    return
                }
                
                do {
                    let albums = try self.jsonDecoder.decode([AlbumDM].self,
                                                                from: jsonData)
                    completion(.success(albums))
                } catch {
                    print(error)
                    completion(.failure(.decodingError))
                }
            }
        }
    }
    
    @discardableResult
    func fetchPhotos(albumId : Int,
                     completion: @escaping(Result<[PhotoDM],APIError>) -> ()) -> DataRequest {

        return AF.request(APIs.photos(albumId : albumId)).validate().responseJSON { (response) in

            switch response.result {
            case .failure(let error):
                completion(.failure(.responseError(error)))
                
            case .success(let jsonData):
               
                guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted) else {
                    completion(.failure(.other(response.response?.statusCode)))
                    return
                }
                
                do {
                    let albums = try self.jsonDecoder.decode([PhotoDM].self,
                                                                from: jsonData)
                    completion(.success(albums))
                } catch {
                    print(error)
                    completion(.failure(.decodingError))
                }
            }
        }
    }
}
