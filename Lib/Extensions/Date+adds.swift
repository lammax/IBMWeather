//
//  Date+adds.swift
//  IBMWeather
//
//  Created by Mac on 08.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation

enum DateFormat: String {
    case short = "dd.MM.yyyy"
    case long = "MM-dd-yyyy HH:mm:ss"
    case year = "yyyy"
    case month = "MM"
    case dayMonth = "dd.MM"
    case timeShort = "HH:mm"
    case timeLong = "HH:mm:ss"
    case iso = "yyyy-MM-dd'T'HH:mm:ssZ"
}

extension Date {
    func toString(with format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
   
   func fromString(_ text: String, with format: DateFormat) -> Date? {
       let dateFormatter = DateFormatter()
       
       // doc: http://userguide.icu-project.org/formatparse/datetime
       dateFormatter.dateFormat = format.rawValue
       return dateFormatter.date(from: text)
   }
}


extension Date {
    
    var unixTimestamp: TimeInterval {
        return self.timeIntervalSince1970 * 1_000
    }

    static func from(unix time: Double?, gmt shift: Int?) -> String {
        if let unixTime = time, let gmtShift = shift {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.dateFormat = DateFormat.timeShort.rawValue
            dateFormatter.timeZone = TimeZone(secondsFromGMT: gmtShift)
            return dateFormatter.string(from: date)
        }
        
        return ""
    }

    static func from(unix time: Double?) -> String {
        if let unixTime = time {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.dateFormat = DateFormat.timeLong.rawValue
            return dateFormatter.string(from: date)
        }
        
        return ""
    }

    //2020-06-13T13:15:00-0400
    static let dateFormatterWithTime: DateFormatter = {
        let formatter = DateFormatter()

        formatter.dateFormat = DateFormat.iso.rawValue

        return formatter
    }()

    static let dateFormatterWithoutTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone() as TimeZone
        formatter.locale = NSLocale.current // NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat =  DateFormat.iso.rawValue

        return formatter
    }()
    
}
