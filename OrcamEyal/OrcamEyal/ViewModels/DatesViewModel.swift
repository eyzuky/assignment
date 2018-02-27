//
//  DatesViewModel.swift
//  OrcamEyal
//
//  Created by Eyal Silberman on 27/02/2018.
//  Copyright © 2018 Eyal Silberman. All rights reserved.
//

import Foundation

class DatesViewModel {
    
    var data: [DateModel] = []
    
    func numberOfDaysInMonth () -> Int {
        return data.count
    }
    func loadData(){
        data = []
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .year], from: Date())
        
        guard let month = components.month, let year = components.year else {
            return
        }
        let dateComponents = DateComponents(year: year, month: month)
        guard let date = calendar.date(from: dateComponents) else {
            return
        }
        guard let range = calendar.range(of: .day, in: .month, for: date) else {
            return
        }
        let numDays = range.count
        for i in 1...numDays {
            let dateModel = DateModel(dayNumber: i, month: month, year: year)
            data.append(dateModel)
        }
    }
}
