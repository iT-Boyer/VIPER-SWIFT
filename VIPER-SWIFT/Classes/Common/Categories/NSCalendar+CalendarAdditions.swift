//
//  Calander.swift
//  iSmallApp
//
//  Created by admin on 2019/7/25.
//  Copyright © 2019 clcw. All rights reserved.
//

import Foundation

extension Calendar{
    
    static func gregorianCalendar() -> Calendar {
        return Calendar(identifier: .gregorian)
    }
    func dateWithYear(year:Int, month:Int, day:Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        return date(from: components)!
    }
    //dateByAddingComponents(tomorrowComponents, toDate: today, options: nil)
    func dateForTomorrowRelativeToToday(_ today: Date) -> Date {
        var tomorrowComponents = DateComponents()
        tomorrowComponents.day = 1
        return date(byAdding: tomorrowComponents, to: today)!
    }
    
    func dateForEndOfWeekWithDate(_ date: Date) -> Date {
        let daysRemainingThisWeek = daysRemainingInWeekWithDate(date: date)
        var remainingDaysComponent = DateComponents()
        remainingDaysComponent.day = daysRemainingThisWeek
        return self.date(byAdding: remainingDaysComponent, to: date)!
    }
    //components((NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay), fromDate: date)
    //dateFromComponents(newComponent)
    func dateForBeginningOfDay(_ date: Date) -> Date {
        let arr = ([Calendar.Component.year,.month,.day]) as Set<Calendar.Component>
        let newComponent:DateComponents = self.dateComponents(arr, from: date, to: date)
        let newDate = self.date(from: newComponent)
        return newDate!
    }
    
    func dateForEndOfDay(_ date: Date) -> Date {
        var components = DateComponents()
        components.day = 1
        let toDate = dateForBeginningOfDay(date)
        let nextDay = self.date(byAdding: components, to: toDate)!
        let endDay = nextDay.addingTimeInterval(-1)
        return nextDay
    }
    
    func dateForEndOfFollowingWeekWithDate(_ date: Date) -> Date {
        let endOfWeek = dateForEndOfWeekWithDate(date)
        var nextWeekComponent = DateComponents()
        nextWeekComponent.weekday = 1
        let followingWeekDate = self.date(byAdding: nextWeekComponent, to: endOfWeek)!
        return followingWeekDate
    }
}


extension Calendar{
    //components(NSCalendarUnit.WeekdayCalendarUnit, fromDate: date)
    //rangeOfUnit(NSCalendarUnit.WeekdayCalendarUnit, inUnit: NSCalendarUnit.WeekCalendarUnit, forDate: date)
    func daysRemainingInWeekWithDate(date: Date) -> Int {
        let weekdayComponent = dateComponents([.weekday], from: date)
        // https://stackoverflow.com/questions/52658744/swift-4-init-is-deprecated-countablerange-is-now-range
        let daysRange = range(of: Component.weekday, in: Component.weekOfYear, for: date)!
        let daysPerWeek = daysRange.count
        let daysRemaining = daysPerWeek - weekdayComponent.weekday!
        return daysRemaining
    }
    func isDate(_ date: Date, beforeYearMonthDay: Date) -> Bool {
        let comparison = compareYearMonthDay(date, toYearMonthDay: beforeYearMonthDay)
        let result = comparison == ComparisonResult.orderedAscending
        return result
    }
    
    func isDate(_ date: Date, equalToYearMonthDay: Date) -> Bool {
        let comparison = compareYearMonthDay(date, toYearMonthDay: equalToYearMonthDay)
        let result = comparison == ComparisonResult.orderedSame
        return result
    }
    
    func isDate(_ date: Date, duringSameWeekAsDate: Date) -> Bool {
        let arr = ([Calendar.Component.weekday]) as Set<Calendar.Component>
        let dateComponents = self.dateComponents(arr, from: date, to: date)
        let duringSameWeekComponents = self.dateComponents(arr, from: duringSameWeekAsDate, to: date)
        let result = dateComponents.weekday == duringSameWeekComponents.weekday
        return result
    }
    
    func isDate(_ date: Date, duringWeekAfterDate: Date) -> Bool {
        let nextWeek = dateForEndOfFollowingWeekWithDate(duringWeekAfterDate)
        let arr = ([Calendar.Component.weekday]) as Set<Calendar.Component>
        let dateComponents = self.dateComponents(arr, from: date, to: date)
        let nextWeekComponents = self.dateComponents(arr, from: nextWeek, to: date)
        let result = dateComponents.weekday == nextWeekComponents.weekday
        return result
    }
    
    func compareYearMonthDay(_ date: Date, toYearMonthDay: Date) -> ComparisonResult {
        let dateComponents = yearMonthDayComponentsFromDate(date)
        let yearMonthDayComponents = yearMonthDayComponentsFromDate(toYearMonthDay)
        
        var result = compareInteger(dateComponents.year!, right: yearMonthDayComponents.year!)
        
        if result == ComparisonResult.orderedSame {
            result = compareInteger(dateComponents.month!, right: yearMonthDayComponents.month!)
            
            if result == ComparisonResult.orderedSame {
                result = compareInteger(dateComponents.day!, right: yearMonthDayComponents.day!)
            }
        }
        
        return result
    }
    
    func yearMonthDayComponentsFromDate(_ date: Date) -> DateComponents {
        let arr = ([Calendar.Component.year,.month,.day]) as Set<Calendar.Component>
        let newComponents = self.dateComponents(arr, from: date, to: date)
        return newComponents
    }
    
    func compareInteger(_ left: Int, right: Int) -> ComparisonResult {
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
    
    func nearTermRelationForDate(_ date: Date, relativeToToday: Date) -> NearTermDateRelation {
        var relation = NearTermDateRelation.OutOfRange
        
        let dateForTomorrow = dateForTomorrowRelativeToToday(relativeToToday)
        
        let isDateBeforeYearMonthDay = isDate(date, beforeYearMonthDay: relativeToToday)
        let isDateEqualToYearMonthDay = isDate(date, equalToYearMonthDay: relativeToToday)
        let isDateEqualToYearMonthDayRelativeToTomorrow = isDate(date, equalToYearMonthDay: dateForTomorrow)
        let isDateDuringSameWeekAsDate = isDate(date, duringSameWeekAsDate: relativeToToday)
        let isDateDuringSameWeekAfterDate = isDate(date, duringWeekAfterDate: relativeToToday)
        
        if isDateBeforeYearMonthDay {
            relation = NearTermDateRelation.OutOfRange
        } else if isDateEqualToYearMonthDay {
            relation = NearTermDateRelation.Today
        } else if isDateEqualToYearMonthDayRelativeToTomorrow {
            let isRelativeDateDuringSameWeek = isDate(relativeToToday, duringSameWeekAsDate: date)
            
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
