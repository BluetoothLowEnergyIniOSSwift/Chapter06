//
//  BlePeripheralDelegate.swift
//  sketch
//
//  Created by Adonis Gaitatzis on 1/9/17.
//  Copyright © 2017 Adonis Gaitatzis. All rights reserved.
//

import UIKit
import CoreBluetooth


/**
 BlePeripheralDelegate relays important status changes from BlePeripheral
 */
@objc protocol BlePeripheralDelegate : class {
    
    /**
     RSSI was read for a Peripheral
     
     - Parameters:
     - rssi: the RSSI
     - blePeripheral: the BlePeripheral
     */
    @objc optional func blePeripheral(stateChanged state: CBManagerState)

    
    /**
     BlePeripheral statrted adertising
     
     - Parameters:
     - error: the error message, if any
     */
    @objc optional func blePerihperal(startedAdvertising error: Error?)
    
}
