//
//  Date+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation

//  MARK:- CustomDateFormat
public enum CustomDateFormat: String {
  case normal = "MMMM dd YYYY"
  case abbr = "MMM d YY"
  case fullMonthDay = "MMMM dd"
  case abbrMonthDay = "MMM dd"
  case fullMonthYear = "MMMM YYYY"
  case abbrMonthYear = "MMM YY"
  case month = "MMMM"
  case abbrMonth = "MMM"
  case timeDate = "yyyy-MM-dd'T'HH:mm:ssZ"
  case regular = "yyyy-MM-dd hh:mm a"
  case new = "@ hh:mm a"
}

//  MARK:- Date initializers
public extension Date {
   init?(day: Int, month: Int, year: Int) {
      guard let date = Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) else { return nil }
      self.init(timeIntervalSince1970: date.timeIntervalSince1970)
  }
}

//  MARK:- Calculations
public extension Date {
  func add(months: Int) -> Date? {
    return Calendar.current.date(byAdding: DateComponents(month: months), to: self)
  }

  func add(days: Int) -> Date? {
    return Calendar.current.date(byAdding: DateComponents(day: days), to: self)
  }

  func add(years: Int) -> Date? {
    return Calendar.current.date(byAdding: DateComponents(year: years), to: self)
  }

  func add(months: Int, days: Int, years: Int) -> Date? {
    return Calendar.current.date(byAdding: DateComponents(year: years, month: months, day: days), to: self)
  }

  func calcAge(birthday: String) -> Int {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "MM/dd/yyyy"
    let birthdayDate = dateFormater.date(from: birthday)
    let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
    let now = Date()
    let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
    let age = calcAge.year
    return age!
  }
}

//  MARK:- Date comparisons
public extension Date {
  func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
    return compare(dateToCompare) == ComparisonResult.orderedDescending
  }

  func isLessThanDate(_ dateToCompare: Date) -> Bool {
    return compare(dateToCompare) == ComparisonResult.orderedAscending
  }

  func isEqualToDate(_ dateToCompare: Date) -> Bool {
    return compare(dateToCompare) == ComparisonResult.orderedSame
  }

  func timeAgoDisplay() -> String {
    let calendar = Calendar.current
    let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
    let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
    let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
    let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!

    if minuteAgo < self {
        let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
        return "\(diff) sec ago"
    } else if hourAgo < self {
        let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
        return "\(diff) min ago"
    } else if dayAgo < self {
        let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
        return "\(diff) hrs ago"
    } else if weekAgo < self {
        let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
        return "\(diff) days ago"
    }
    let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
    return "\(diff) weeks ago"
  }
}

//  MARK:- Generic functions
public extension Date {
  enum Error: LocalizedError {
    case firstOfTheMonth(date: Date)
    case lastOfTheMonth(date: Date)

    public var errorDescription: String? {
      switch self {
      case .firstOfTheMonth(let date):
          return String(format: "Failed to calculate the first day the month based on %@", date.description)
      case .lastOfTheMonth(let date):
          return String(format: "Failed to calculate the last day the month based on %@", date.description)
      }
    }
  }

  func getMonth(withFormat format: CustomDateFormat = .month) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format.rawValue
    let strMonth = dateFormatter.string(from: self)
    return strMonth
  }

  func getMonth(withStringFormat format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    let strMonth = dateFormatter.string(from: self)
    return strMonth
  }

  func toString(format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }

  func toString(_ format: CustomDateFormat = .timeDate) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format.rawValue
    return dateFormatter.string(from: self)
  }
    
  func firstOfTheMonth() throws -> Date {
    let startOfDay = Calendar.current.startOfDay(for: self)
    let monthYearDateComponents = Calendar.current.dateComponents([.year, .month], from: startOfDay)
    guard let firstOfTheMonth = Calendar.current.date(from: monthYearDateComponents) else {
      throw Date.Error.firstOfTheMonth(date: self)
    }
    return firstOfTheMonth
  }
    
  func lastOfTheMonth() throws -> Date {
    let firstOfTheMonthDate = try firstOfTheMonth()
    guard let lastOfTheMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: firstOfTheMonthDate) else {
      throw Date.Error.lastOfTheMonth(date: self)
    }
    return lastOfTheMonth
  }
    
  func monthYearComponents() -> (month: Int, year: Int)? {
    let components = Calendar.current.dateComponents([.year, .month], from: self)
    guard let month = components.month, let year = components.year else { return nil }
    return (month, year)
  }

  func daysInMonth() -> Int? {
    return Calendar.current.range(of: .day, in: .month, for: self)?.count
  }
}

//  MARK:- Deprecated
public extension Date {
  func getMonthDayName() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    let strMonth = dateFormatter.string(from: self)
    return strMonth
  }

  func getMonthYearName() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM YYYY"
    let strMonth = dateFormatter.string(from: self)
    return strMonth
  }

  func getMonthDayYearName() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d YY"
    let strMonth = dateFormatter.string(from: self)
    return strMonth
  }
}


