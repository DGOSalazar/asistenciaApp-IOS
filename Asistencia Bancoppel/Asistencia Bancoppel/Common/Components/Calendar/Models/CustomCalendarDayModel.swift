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
    
    init(workDay: Date = Date(), style: CustomCalendarCellStyleEnum = .unavailable) {
        self.workDay = workDay
        self.style = style
    }
}
