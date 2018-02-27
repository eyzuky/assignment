//
//  BluetoothViewModel.swift
//  OrcamEyal
//
//  Created by Eyal Silberman on 27/02/2018.
//  Copyright © 2018 Eyal Silberman. All rights reserved.
//

import Foundation
import CoreBluetooth

class BluetoothViewModel: NSObject {
    
    var centralManager = CBCentralManager()
    var data: [BluetoothDevice] = []
    
    func numberOfDevices () -> Int {
        return data.count
    }
    func loadData(){
        data = []
        if centralManager.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
}

extension BluetoothViewModel: CBCentralManagerDelegate {
        func centralManagerDidUpdateState(_ central: CBCentralManager) {
            switch central.state {
            case .poweredOn:
                print("on")
            case .unknown:
                print("unknown")
            case .resetting:
                print("resetting")
            case .unsupported:
                print("unsupported")
            case .unauthorized:
                print("unauthorized")
            case .poweredOff:
                print("powered off")
            }
        }
    

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let peripheralName = peripheral.name
        
        let bluetoothDevice = BluetoothDevice(hashValue: 0, name: peripheralName ?? "UNKNOWN", rssi: RSSI)
        data.append(bluetoothDevice)
        removeDupilcates()
        data = data.sorted(by: { Double($0.rssi) < Double($1.rssi)})
        //would usually bind the data array to the table view cells instead of posting notifications, but I assumed I should not use Cocoa pods (like RxSwift) for simplicity of the task
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstants.NotificationIdentifiers.foundBluetooth), object: nil)
    }
}
//helper methods
extension BluetoothViewModel {
    func removeDupilcates() {
        data = Array(Set<BluetoothDevice>(data))
    }
}
