//
//  AppIntent.swift
//  IBMWeather
//
//  Created by Mac on 07.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Combine
import UIKit

class UserSettings: ObservableObject {
    @Published var signInOK: Bool = false
    @Published var showingSettings: Bool = false
    @Published var isActivityIndicatorAnimating: Bool = false

}
