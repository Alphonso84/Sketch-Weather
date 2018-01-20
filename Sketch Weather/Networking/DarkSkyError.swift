//
//  DarkSkyError.swift
//  Sketch Weather
//
//  Created by user on 1/19/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//

import Foundation
enum DarkSkyError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
}
