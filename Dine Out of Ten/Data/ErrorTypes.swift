//
//  ErrorTypes.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import Foundation
import SwiftUI

// MARK: User Input Errors

//enum UserInputError: Error {
//    case TagCreationError
//}

enum TagCreationError: Error {
    case TagNotUnique
    case UnknownError
}

extension TagCreationError {
    var alertTitle: Text {
        switch self {
        case .TagNotUnique:
            return Text("That Tag Already Exists")
        case .UnknownError:
            return Text("Error")
        }
    }
    
    var alertMessage: Text {
        switch self {
        case .TagNotUnique:
            return Text("Please choose a different name for your tag.")
        case .UnknownError:
            return Text("An unknown error occured.")
        }
    }
}
