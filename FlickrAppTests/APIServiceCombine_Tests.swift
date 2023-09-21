//
//  APIServiceCombine_Tests.swift
//  FlickrAppTests
//
//  Created by Татьяна Касперович on 21.09.23.
//

import XCTest
@testable import FlickrApp

final class APIServiceCombine_Tests: XCTestCase {
    var sut: URLSession!

    override func setUpWithError() throws {
      try super.setUpWithError()
      sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
      sut = nil
      try super.tearDownWithError()
    }
    
    func test_APIManager_ValidApiCall_GetsHTTPStatusCode200() throws {
        
        // Given
         let urlString =
           "https://api.flickr.com/services/rest/?&method=flickr.interestingness.getList&api_key=fbdbc01816f99826cef679697c8253ba&per_page=150&format=json&nojsoncallback=1&extras=url_z"
         let url = URL(string: urlString)!
         // 1
         let promise = expectation(description: "Status code: 200")

        // When
         let dataTask = sut.dataTask(with: url) { _, response, error in
             // Then
           if let error = error {
             XCTFail("Error: \(error.localizedDescription)")
             return
           } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
             if statusCode == 200 {
               // 2
               promise.fulfill()
             } else {
               XCTFail("Status code: \(statusCode)")
             }
           }
         }
         dataTask.resume()
         // 3
         wait(for: [promise], timeout: 5)
    }
    
    func test_APIManager_ApiCallCompletes() throws {
        // Given
        let urlString = "https://api.flickr.com/services/rest/?&method=flickr.interestingness.getList&api_key=fbdbc01816f99826cef679697c8253ba&per_page=150&format=json&nojsoncallback=1&extras=url_z"
         let url = URL(string: urlString)!
         let promise = expectation(description: "Completion handler invoked")
         var statusCode: Int?
         var responseError: Error?

        // When
        let dataTask = sut.dataTask(with: url) { _, response, error in
          statusCode = (response as? HTTPURLResponse)?.statusCode
          responseError = error
          promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // Then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
}
