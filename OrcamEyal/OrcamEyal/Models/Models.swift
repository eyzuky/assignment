//
//  Models.swift
//  OrcamEyal
//
//  Created by Eyal Silberman on 27/02/2018.
//  Copyright © 2018 Eyal Silberman. All rights reserved.
//

import Foundation

struct DateModel {
    var dayNumber: Int
    var month: Int
    var year: Int
}

extension DateModel {
    func toString() -> String{
        return String(dayNumber) + "." + String(month) + "." + String(year)
    }
}


struct BluetoothDevice: Hashable {
    var hashValue: Int
    
    
    static func ==(lhs: BluetoothDevice, rhs: BluetoothDevice) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    var rssi: NSNumber

}
extension BluetoothDevice {
    func toString() -> String {
        return "Device name: " + name + " RSSI: " + String(describing: rssi)
    }
}
