//
//  CustomCalendarMonthModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 19/04/23.
//

import Foundation


internal struct CustomCalendarMonthModel {
    var month: Date
    var workDays: [CustomCalendarDayModel]
    var monthWorkDayStartIndex: Int
    
    init(month: Date = Date(), workDays: [CustomCalendarDayModel] = [], monthWorkDayStartIndex: Int = 0) {
        self.month = month
        self.workDays = workDays
        self.monthWorkDayStartIndex = monthWorkDayStartIndex
    }
}
