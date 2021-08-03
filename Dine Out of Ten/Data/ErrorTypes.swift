//
//  ErrorTypes.swift
//  Dine Out of Ten
//
//  Created by Hunter Holland on 5/12/21.
//

import Foundation
import SwiftUI

// MARK: Tag Creation Errors
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

// MARK: - Restaurant Creation Error
enum RestaurantCreationError: Error {
    case RestaurantAlreadyExistsError
    case NoNameError
    case AddressError(type: AddressInputError)
    case UnknownError
    
    enum AddressInputError: Error {
        case NoAddressError
        case NoPlacemarkFoundError
        case FailedSearchError
        case UnknownError
    }
}

extension RestaurantCreationError {
    var alertTitle: Text {
        switch self {
        case .RestaurantAlreadyExistsError:
            return Text("Restaurant Already Exists")
        case .NoNameError:
            return Text("No Name Given")
        case .AddressError(type: let type):
            return type.alertTitle
        case .UnknownError:
            return Text("Error")
        }
    }
    
    var alertMessage: Text {
        switch self {
        case .RestaurantAlreadyExistsError:
            return Text("You may have already added this restaurant. If you don't think so, change the name and address slightly and try again")
        case .NoNameError:
            return Text("Please add a name to this restaurant.")
        case .AddressError(type: let type):
            return type.alertMessage
        case .UnknownError:
            return Text("An unknown error occured.")
        }
    }
    
    func alert(primaryButton: Alert.Button? = nil, secondaryButton: Alert.Button? = nil) -> Alert {
        switch self {
        case .RestaurantAlreadyExistsError:
            return Alert(title: alertTitle, message: alertMessage)
        case .NoNameError:
            return Alert(title: alertTitle, message: alertMessage)
        case .AddressError:
            return Alert(title: alertTitle, message: alertMessage,
                         primaryButton: primaryButton!, secondaryButton: secondaryButton!)
        case .UnknownError:
            return Alert(title: alertTitle, message: alertMessage)
        }
    }
    
}

extension RestaurantCreationError.AddressInputError {
    var alertTitle: Text {
        switch self {
        case .NoAddressError:
            return Text("No Address Given")
        case .NoPlacemarkFoundError:
            return Text("Invalid Address")
        case .FailedSearchError:
            return Text("Hmm...")
        case .UnknownError:
            return Text("Error")
        }
    }
    
    var alertMessage: Text {
        switch self {
        case .NoAddressError:
            return Text("If you add an address, we can find this place on the map and show you more information about it. It's not required though!")
        case .NoPlacemarkFoundError:
            return Text("Please type a different address and try again.")
        case .FailedSearchError:
            return Text("Something went wrong. Please try again later. Sorry about that.")
        case .UnknownError:
            return Text("An unknown error occured.")
        }
    }
}
