//
//  NetworkManager.swift
//  Products-App
//
//  Created by Peter Murin on 23/02/2023.
//

import Alamofire
import Foundation

private let API_BASE_URL = "https://fakestoreapi.com"

class NetworkManager {
    private let maxWaitTime = 15.0
    
    func get(_ path: String) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(API_BASE_URL + path, requestModifier: { request in
                request.timeoutInterval = self.maxWaitTime
            }).responseData { response in
                switch(response.result) {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error))
                }
            }
        }
    }
    
    private func handleError(_ error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            
            if code == NSURLErrorNotConnectedToInternet || code == NSURLErrorTimedOut || code == NSURLErrorInternationalRoamingOff || code == NSURLErrorDataNotAllowed || code == NSURLErrorCannotFindHost || code == NSURLErrorCannotConnectToHost || code == NSURLErrorNetworkConnectionLost {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                
                return currentError
            }
        }
        
        return error
    }
}
