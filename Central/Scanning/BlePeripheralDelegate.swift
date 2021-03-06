//
//  PeripheralDelegate.swift
//  FlowControl
//
//  Created by Adonis Gaitatzis on 12/2/16.
//  Copyright © 2016 Adonis Gaitatzis. All rights reserved.
//

import UIKit
import CoreBluetooth

/**
 BlePeripheral relays important status changes from BlePeripheral
 */
@objc protocol BlePeripheralDelegate: class {
    
    /**
     Characteristics were discovered for a Service
     
     - Parameters:
     - characteristics: the Characteristic list
     - forService: the Service these Characteristics are under
     - blePeripheral: the BlePeripheral
     */
    @objc optional func blePerihperal(discoveredCharacteristics characteristics: [CBCharacteristic], forService: CBService, blePeripheral: BlePeripheral)
    
    /**
     RSSI was read for a Peripheral
     
     - Parameters:
     - rssi: the RSSI
     - blePeripheral: the BlePeripheral
     */
    @objc optional func blePeripheral(readRssi rssi: NSNumber, blePeripheral: BlePeripheral)
}
