//
//  Webservice.swift
//  IBMWeather
//
//  Created by Mac on 09.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation
import Combine
import CoreLocation


class Webservice {
    
    static let sharedInstance = Webservice()
    
    func fetchWeather<T: Decodable>(location: CLLocationCoordinate2D, t: T) -> AnyPublisher<T?, Error> {
        
        guard let url = URL(string: Constants.URLs(location: location).weather) else { fatalError("Invalid weather URL!") }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .map { $0 }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
}

