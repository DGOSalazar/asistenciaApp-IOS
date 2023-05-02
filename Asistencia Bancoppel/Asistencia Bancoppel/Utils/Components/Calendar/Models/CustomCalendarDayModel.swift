//
//  CustomCalendarDayModel.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 19/04/23.
//

import Foundation
internal struct CustomCalendarDayModel {
    var workDay: Date
    var style: CustomCalendarCellStyleEnum
    var attendaceData: DayAttendanceModel?
    var showProfilePhoto: Bool
    var isAttendedDay: Bool
    
    init(workDay: Date = Date(),
         style: CustomCalendarCellStyleEnum = .unavailable,
         attendaceData: DayAttendanceModel? = nil,
         showProfilePhoto: Bool = false,
         isAttendedDay: Bool = false) {
        self.workDay = workDay
        self.style = style
        self.attendaceData = attendaceData
        self.showProfilePhoto = showProfilePhoto
        self.isAttendedDay = isAttendedDay
    }
}
