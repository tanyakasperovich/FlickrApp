////
////  APIManager.swift
////  FlickrApp
////
////  Created by Татьяна Касперович on 20.09.23.
////
//
//import Foundation
//
//public class APIManager {
//    public static let shared = APIManager()
//    
//    func fetchFlickrImages(completion: @escaping ([FlickrImageModel]) -> ()){
//        let apiService = APIManager.shared
//        apiService.getJSON(urlString:
//                            "https://api.flickr.com/services/rest/?&method=flickr.interestingness.getList&api_key=fbdbc01816f99826cef679697c8253ba&per_page=50&format=json&nojsoncallback=1&extras=url_z") {
//            (result: Result<FlickrImagesData,APIManager.APIError>) in
//            switch result {
//            case .success(let flickrImages):
//                DispatchQueue.main.async {
//                    let images = flickrImages.photos.photo.map { FlickrImageModel(id: $0.id, imageName: $0.title, flickrImage: $0.urlZ, owner: $0.owner)}
//                    completion(images)
//                }
//            case .failure(let apiError):
//                switch apiError {
//                case .error(let errorString):
//                    print(errorString)
//                }
//            }
//        }
//    }
//    
//    public enum APIError: Error {
//        case error(_ errorString: String)
//    }
//    
//    public func getJSON<T: Decodable>(urlString: String,
//                                      dateDecodingStategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
//                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
//                                      completion: @escaping (Result<T,APIError>) -> Void) {
//        guard let url = URL(string: urlString) else {
//            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
//            return
//        }
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                completion(.failure(.error("URLError: \(error.localizedDescription)")))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(.error(NSLocalizedString("Error: Data is corrupt.", comment: ""))))
//                return
//            }
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = dateDecodingStategy
//            decoder.keyDecodingStrategy = keyDecodingStrategy
//            do {
//                let decodedData = try decoder.decode(T.self, from: data)
//                completion(.success(decodedData))
//                return
//            } catch let decodingError {
//                completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
//                return
//            }
//            
//        }.resume()
//    }
//}
