//
//  APIServiceCombine.swift
//  FlickrApp
//
//  Created by Татьяна Касперович on 21.09.23.
//

import Foundation
import Combine

public class APIServiceCombine {
    public static let shared = APIServiceCombine()
    var cancellables = Set<AnyCancellable>()
    
    public enum APIError: Error {
        case error(_ errorString: String)
    }
    
    func fetchFlickrImages(completion: @escaping ([FlickrImageModel]) -> ()){
        let apiService = APIServiceCombine.shared
        apiService.getJSON(urlString:
                            "https://api.flickr.com/services/rest/?&method=flickr.interestingness.getList&api_key=fbdbc01816f99826cef679697c8253ba&per_page=150&format=json&nojsoncallback=1&extras=url_z") {
            (result: Result<FlickrImagesData,APIServiceCombine.APIError>) in
            switch result {
            case .success(let flickrImages):
                DispatchQueue.main.async {
                    let images = flickrImages.photos.photo.map { FlickrImageModel(id: $0.id, imageName: $0.title, flickrImage: $0.urlZ, owner: $0.owner)}
                    completion(images)
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    print(errorString)
                }
            }
        }
    }
  
    public func getJSON<T: Decodable>(urlString: String,
                                      dateDecodingStategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                      completion: @escaping (Result<T,APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data}
            .decode(type: T.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { (taskComplition) in
                switch taskComplition {
                case .finished:
                    return
                case .failure(let decodingError):
                    completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
                }
            } receiveValue: { (decodedData) in
                completion(.success(decodedData))
            }
            .store(in: &cancellables)
    }
}
