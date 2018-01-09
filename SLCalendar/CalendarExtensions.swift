//
//  CalendarExtensions.swift
//  SLCalendar
//
//  Created by sergey.leonov on 26.12.16.
//  Copyright © 2016 brottys.ru. All rights reserved.
//

import Foundation

extension Calendar {

    func firstDayOfYearForDate(_ date: Date) -> Date {
        return self.date(from: dateComponents([.year], from: date))!
    }
    
    func firstDayOfMonthForDate(_ date: Date) -> Date {
        return self.date(from: dateComponents([.month, .year], from: date))!
    }

    func numberOfDaysIn(month: Date) -> Int {
        return range(of: .day, in: .month, for: firstDayOfMonthForDate(month))!.count
    }
    
    // returns the number of week day for specified date
    // the first day of week is monday
    func weekdayNumber(of date: Date) -> Int {
        let dateComps = dateComponents([.weekday], from: date)
        let weekday = (dateComps.weekday! + 7 - firstWeekday) % 7 + 1
        return weekday
    }
    
}
