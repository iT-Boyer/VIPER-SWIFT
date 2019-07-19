//
//  NSCalendar+CalendarAdditions.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

extension NSCalendar {
    class func gregorianCalendar() -> NSCalendar {
        return NSCalendar(calendarIdentifier: NSCalendar.Identifier(rawValue: NSGregorianCalendar))!
    }
    
    func dateWithYear(year: Int, month: Int, day: Int) -> NSDate {
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        return date(from: components as DateComponents)! as NSDate
    }
    
    func dateForTomorrowRelativeToToday(today: NSDate) -> NSDate {
        let tomorrowComponents = NSDateComponents()
        tomorrowComponents.day = 1
        let datt = self.date(byAdding: tomorrowComponents as DateComponents, to: today as Date, options: NSCalendar.Options.init(rawValue: 0))
        return datt! as NSDate
    }
    
    func dateForEndOfWeekWithDate(date: NSDate) -> NSDate {
        let daysRemainingThisWeek = daysRemainingInWeekWithDate(date: date)
        let remainingDaysComponent = NSDateComponents()
        remainingDaysComponent.day = daysRemainingThisWeek
        let datt:NSDate = self.date(byAdding: remainingDaysComponent as DateComponents, to: date as Date, options: NSCalendar.Options.init(rawValue: 0))! as NSDate
        return datt
    }
    
    func dateForBeginningOfDay(date: NSDate) -> NSDate {
        let newComponent = component((NSCalendar.Unit(rawValue: NSCalendar.Unit.year.rawValue | NSCalendar.Unit.month.rawValue | NSCalendar.Unit.day.rawValue)), from: date as Date)
        let newDate = self.date(from: newComponent as <#T##DateComponents#>)
        return newDate
    }
    
    func dateForEndOfDay(date: NSDate) -> NSDate {
        let components = NSDateComponents()
        components.day = 1
        let toDate = dateForBeginningOfDay(date: date)
        let nextDay = self.date(byAdding: components as DateComponents, to: toDate as Date, options: NSCalendar.Options.init(rawValue: 0))
        let endDay = nextDay?.addingTimeInterval(-1)
        return nextDay! as NSDate
    }
    
    func daysRemainingInWeekWithDate(date: NSDate) -> Int {
        let weekdayComponent = components(NSCalendar.Unit.weekday, from: date as Date)
        let daysRange = self.range(of: NSCalendar.Unit.weekday, in:  NSCalendar.Unit.weekday, for: date as Date)
        let daysPerWeek = daysRange.length
        let daysRemaining = daysPerWeek - weekdayComponent.weekday!
        return daysRemaining
    }
    
    func dateForEndOfFollowingWeekWithDate(date: NSDate) -> NSDate {
        let endOfWeek = dateForEndOfWeekWithDate(date: date)
        let nextWeekComponent = NSDateComponents()
        nextWeekComponent.setWeek(1)
        let followingWeekDate = self.date(byAdding: nextWeekComponent as DateComponents, to: endOfWeek as Date, options: NSCalendar.Options.init(rawValue: 0))
        return followingWeekDate as! NSDate
    }
    
    func isDate(date: NSDate, beforeYearMonthDay: NSDate) -> Bool {
        let comparison = compareYearMonthDay(date: date, toYearMonthDay: beforeYearMonthDay)
        let result = comparison == ComparisonResult.orderedAscending
        return result
    }
    
    func isDate(date: NSDate, equalToYearMonthDay: NSDate) -> Bool {
        let comparison = compareYearMonthDay(date: date, toYearMonthDay: equalToYearMonthDay)
        let result = comparison == ComparisonResult.orderedSame
        return result
    }
    
    func isDate(date: NSDate, duringSameWeekAsDate: NSDate) -> Bool {
        let dateComponents = components(NSCalendar.Unit.NSWeekCalendarUnit, from: date as Date)
        let duringSameWeekComponents = components(NSCalendar.Unit.NSWeekCalendarUnit, from: duringSameWeekAsDate as Date)
        let result = dateComponents.weekday == duringSameWeekComponents.weekday
        return result
    }
    
    func isDate(date: NSDate, duringWeekAfterDate: NSDate) -> Bool {
        let nextWeek = dateForEndOfFollowingWeekWithDate(date: duringWeekAfterDate)
        let dateComponents = components(NSCalendar.Unit.NSWeekCalendarUnit, from: date as Date)
        let nextWeekComponents = components(NSCalendar.Unit.NSWeekCalendarUnit, from: nextWeek as Date)
        let result = dateComponents.weekday == nextWeekComponents.weekday
        return result
    }
    
    func compareYearMonthDay(date: NSDate, toYearMonthDay: NSDate) -> ComparisonResult {
        let dateComponents = yearMonthDayComponentsFromDate(date: date)
        let yearMonthDayComponents = yearMonthDayComponentsFromDate(date: toYearMonthDay)
        
        var result = compareInteger(left: dateComponents.year, right: yearMonthDayComponents.year)
        
        if result == ComparisonResult.orderedSame {
            result = compareInteger(left: dateComponents.month, right: yearMonthDayComponents.month)
            
            if result == ComparisonResult.orderedSame {
                result = compareInteger(left: dateComponents.day, right: yearMonthDayComponents.day)
            }
        }
        
        return result
    }
    
    func yearMonthDayComponentsFromDate(date: NSDate) -> NSDateComponents {
        let newComponents = components((NSCalendar.Unit(rawValue: NSCalendar.Unit.year.rawValue | NSCalendar.Unit.month.rawValue | NSCalendar.Unit.day.rawValue)), from: date as Date)
        return newComponents as NSDateComponents
    }
    
    func compareInteger(left: Int, right: Int) -> ComparisonResult {
        var result = ComparisonResult.orderedDescending
        
        if left == right {
            result = ComparisonResult.orderedSame
        } else if left < right {
            result = ComparisonResult.orderedAscending
        } else {
            result = ComparisonResult.orderedDescending
        }
        
        return result
    }
    
    func nearTermRelationForDate(date: NSDate, relativeToToday: NSDate) -> NearTermDateRelation {
        var relation = NearTermDateRelation.OutOfRange
        
        let dateForTomorrow = dateForTomorrowRelativeToToday(today: relativeToToday)
        
        let isDateBeforeYearMonthDay = isDate(date: date, beforeYearMonthDay: relativeToToday)
        let isDateEqualToYearMonthDay = isDate(date: date, equalToYearMonthDay: relativeToToday)
        let isDateEqualToYearMonthDayRelativeToTomorrow = isDate(date: date, equalToYearMonthDay: dateForTomorrow)
        let isDateDuringSameWeekAsDate = isDate(date: date, duringSameWeekAsDate: relativeToToday)
        let isDateDuringSameWeekAfterDate = isDate(date: date, duringWeekAfterDate: relativeToToday)
        
        if isDateBeforeYearMonthDay {
            relation = NearTermDateRelation.OutOfRange
        } else if isDateEqualToYearMonthDay {
            relation = NearTermDateRelation.Today
        } else if isDateEqualToYearMonthDayRelativeToTomorrow {
            let isRelativeDateDuringSameWeek = isDate(date: relativeToToday, duringSameWeekAsDate: date)

            if isRelativeDateDuringSameWeek {
                relation = NearTermDateRelation.Tomorrow
            } else {
                relation = NearTermDateRelation.NextWeek
            }
        } else if isDateDuringSameWeekAsDate {
            relation = NearTermDateRelation.LaterThisWeek
        } else if isDateDuringSameWeekAfterDate {
            relation = NearTermDateRelation.NextWeek
        }
        
        return relation
    }
}
