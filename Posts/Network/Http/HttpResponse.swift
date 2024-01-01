//
//  HttpResponse.swift
//
//  Created by Ahmed Abdelkarim.
//

import Foundation

/// The response of an HttpRequest.
struct HttpResponse<T> {
    var response: HTTPURLResponse
    var body: T?
}
