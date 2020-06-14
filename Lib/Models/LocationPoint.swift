//
//  LocationPoint.swift
//  IBMWeather
//
//  Created by Mac on 14.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation

/*
 {
    "location":{
       "latitude":56.86,
       "longitude":35.88,
       "city":"Тверь",
       "locale":{
          "locale1":null,
          "locale2":"Тверь",
          "locale3":null,
          "locale4":null
        },
       "neighborhood":null,
       "adminDistrict":"Тверская область",
       "adminDistrictCode":null,
       "postalCode":"170006",
       "postalKey":"1700:RU",
       "country":"Россия",
       "countryCode":"RU",
       "ianaTimeZone":"Europe/Moscow",
       "displayName":"Тверь",
       "dstEnd":null,
       "dstStart":null,
       "dmaCd":null,
       "placeId":"9d0093ab6d98b74c37bd2ff19771fc7ec71e0ba5491ec39bf568f7afdba7929b",
       "disputedArea":false,
       "canonicalCityId":"33c5a5acaa02868dc4190646cb9e2eb8ab8b1487d4d2b51265c38cdaa327c1c9",
       "countyId":null,
       "locId":null,
       "locationCategory":null,
       "pollenId":null,
       "pwsId":null,
       "regionalSatellite":"eur",
       "tideId":null,
       "type":"postal",
       "zoneId":null
    }
 }
 */

struct LocationPoint: Decodable {
    let location: Location?
    
    init(location: Location? = nil) {
        self.location = location
    }
       
    static var placeholder: LocationPoint {
       LocationPoint()
    }

}

struct Location: Decodable {
    let latitude: Double?
    let longitude: Double?
    let city: String?
    let locale: Locale?
    let neighborhood: String?
    let adminDistrict: String?
    let adminDistrictCode: String?
    let postalCode: String?
    let postalKey: String?
    let country: String?
    let countryCode: String?
    let ianaTimeZone: String?
    let displayName: String?
    let dstEnd: String?
    let dstStart: String?
    let dmaCd: String?
    let placeId: String?
    let disputedArea: Bool?
    let canonicalCityId: String?
    let countyId: String?
    let locId: String?
    let locationCategory: String?
    let pollenId: String?
    let pwsId: String?
    let regionalSatellite: String?
    let tideId: String?
    let type: String?
    let zoneId: String?
}

struct Locale: Decodable {
    let locale1: String?
    let locale2: String?
    let locale3: String?
    let locale4: String?
}
