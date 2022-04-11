//
//  ApiError.swift
//  GitRepos
//
//  Created by Admin on 11/04/2022.
//

import Foundation

enum ApiError: Int, Error {
    case recieveNilResponse = 0,
    recieveErrorHttpStatus,
    recieveNilBody,
    failedParse
}
