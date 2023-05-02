//
//  Date+Extension.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 19/04/23.
//

import Foundation


extension Date {
    var calendar: Calendar {
        var auxCalendar = Calendar.current
        auxCalendar.locale = .init(identifier: "es_MX")
        return auxCalendar
    }
    
    func getDay() -> String {
        let dayComponent = self.calendar.dateComponents([Calendar.Component.day], from: self)
        return String(format: "%02d", (dayComponent.day ?? 0))
    }
    
    func getMonth() -> String {
        let monthComponent = self.calendar.dateComponents([Calendar.Component.month], from: self)
        return String((monthComponent.month ?? 0))
    }
    
    func getYear() -> String {
        let yearComponent = self.calendar.dateComponents([Calendar.Component.year], from: self)
        return String((yearComponent.year ?? 0))
    }
    
    func getShortDayName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "es_MX")
        dateFormatter.dateFormat = "EE"
        return dateFormatter.string(from: self).capitalized.removeAccentMarks()
    }
    
    
    func getMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "es_MX")
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self).capitalized
    }
    
    func getWorkDaysNames() -> [String] {
        let weekDays = self.calendar.shortWeekdaySymbols

        var weekDaysNames: [String] = []
        
        for dayIndex in 1 ..< 6 {
            weekDaysNames.append(weekDays[dayIndex].capitalized.removeAccentMarks())
        }
        
        return weekDaysNames
    }
    
    func getWorkDaysOfMonth() -> [Date] {
        let components = self.calendar.dateComponents([Calendar.Component.year, Calendar.Component.month], from: self)
        
        guard let nonNilStartOfMonth = self.calendar.date(from: components) else {
            return []
        }
            
        guard let nonNilDaysRange = self.calendar.range(of: .day, in: .month, for: nonNilStartOfMonth) else {
            return []
        }
        
        var days: [Date] = []
        for n in 0..<(nonNilDaysRange.upperBound - 1) {
            guard let nonNilDay = self.calendar.date(byAdding: Calendar.Component.day, value: n, to: nonNilStartOfMonth) else {
                return []
            }
            days.append(nonNilDay.removeTimeData())
        }
        
        let workDays = days.filter { !self.calendar.isDateInWeekend($0) }
        
        return workDays
    }
    
    func getFirstDayOfMonth() -> Date {
        return self.getWorkDaysOfMonth().first ?? Date()
    }
    
    func getWorkDayIndex() -> Int {
        let index = self.getWorkDaysNames().firstIndex(of: self.getShortDayName())
        return Int(index ?? 0)
    }
    
    func removeTimeData() -> Date {
        guard let date = self.calendar.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            return Date()
        }
        
        return date
    }
    
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "es_MX")
        dateFormatter.dateFormat = "dd-MM-YYYY"
        return dateFormatter.string(from: self)
    }
    
    func getDayNameAndDayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "es_MX")
        dateFormatter.dateFormat = "EEEE dd"
        return dateFormatter.string(from: self).capitalized
    }
    
    func isThisSame(toDate: Date, toGranularity component: Calendar.Component) -> Bool {
        self.calendar.isDate(self, equalTo: toDate, toGranularity: component)
    }
    
    func getWorkDate(addingDays: Int) -> Date {
        var auxAddingWorkDays = addingDays
        
        var endDate = Date()
        var index = 0
        
        while auxAddingWorkDays >= 0 {
            let auxDate = self.calendar.date(byAdding: .day, value: index, to: self) ?? Date()
            index += 1
            auxAddingWorkDays -= 1
            
            guard !self.calendar.isDateInWeekend(auxDate) else {
                auxAddingWorkDays += 1
                continue
            }
            endDate = auxDate
        }
        return endDate
    }
    
    func isDateBetweenDates(_ startDate: Date, _ endDate: Date) -> Bool {
        return ((self.removeTimeData() >= startDate.removeTimeData()) && (self.removeTimeData() <= endDate))
    }
}
