//
//  TotalCaseEntry.swift
//  Covid19StatsWidgetExtension
//
//  Created by Ngo Dang tan on 29/12/2020.
//

import Foundation
import WidgetKit

struct TotalCaseEntry: TimelineEntry {
    var date: Date
    let totalCount: TotalCaseCount
    var isPlaceholder = false
}
extension TotalCaseEntry {
    static var stub: TotalCaseEntry {
        TotalCaseEntry(date: Date(), totalCount: .init(title: "Global", confirmed: 200, death: 10, recovered: 100))
    }
    static var placeholder: TotalCaseEntry {
        TotalCaseEntry(date: Date(), totalCount: .init(title: "-", confirmed: 0, death: 0, recovered: 0),isPlaceholder: true)
    }
}
