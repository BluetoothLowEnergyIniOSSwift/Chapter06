//
//  BlePeripheral.swift
//  sketch
//
//  Created by Adonis Gaitatzis on 1/9/17.
//  Copyright © 2017 Adonis Gaitatzis. All rights reserved.
//

import UIKit
import CoreBluetooth


class BlePeripheral : NSObject, CBPeripheralManagerDelegate {
    
    
    // MARK: Peripheral properties
    
    // Advertized name
    let advertisingName = "MyDevice"
    
    // Device identifier
    let peripheralIdentifier = "8f68d89b-448c-4b14-aa9a-f8de6d8a4753"
    
    
    // MARK: GATT Profile
    
    // Service UUID
    let serviceUuid = CBUUID(string: "0000180c-0000-1000-8000-00805f9b34fb")
    
    // Characteristic UUIDs
    let readCharacteristicUuid = CBUUID(string: "00002a56-0000-1000-8000-00805f9b34fb")
    
    // Read Characteristic
    var readCharacteristic:CBMutableCharacteristic!
    
    // the size of a Characteristic
    let readCharacteristicLength = 20
    
    // MARK: Peripheral State
    
    // Peripheral Manager
    var peripheralManager:CBPeripheralManager!
    
    // Connected Central
    var central:CBCentral!
    
    // delegate
    var delegate:BlePeripheralDelegate!
    
    
    // Interval timer to update Read Characteristic
    var randomTextTimer:Timer!
    
    
    
    /**
     Initialize BlePeripheral with a corresponding Peripheral
     
     - Parameters:
     - delegate: The BlePeripheralDelegate
     - peripheral: The discovered Peripheral
     */
    init(delegate: BlePeripheralDelegate?) {
        super.init()
        
        // empty dispatch queue
        let dispatchQueue:DispatchQueue! = nil
        
        // Build Advertising options
        let options:[String : Any] = [
            //
            CBPeripheralManagerOptionShowPowerAlertKey: true,
            // Peripheral unique identifier
            CBPeripheralManagerOptionRestoreIdentifierKey: peripheralIdentifier
        ]
        
        self.delegate = delegate
        
        peripheralManager = CBPeripheralManager(delegate: self, queue: dispatchQueue, options: options)
        
    }

    /**
     Stop advertising, shut down the Peripheral
     */
    func stop() {
        randomTextTimer.invalidate()
        peripheralManager.stopAdvertising()        
    }
    
    /**
     Start Bluetooth Advertising.  This must be after building the GATT profile
     */
    func startAdvertising() {
        let serviceUuids = [serviceUuid]
        let advertisementData:[String: Any] = [
            CBAdvertisementDataLocalNameKey: advertisingName,
            CBAdvertisementDataServiceUUIDsKey: serviceUuids
        ]
        
        peripheralManager.startAdvertising(advertisementData)
    }
    
    
    /**
     Build Gatt Profile.  This must be done after Bluetooth Radio has turned on
     */
    func buildGattProfile() {
        let service = CBMutableService(type: serviceUuid, primary: true)
        
        var characteristicProperties = CBCharacteristicProperties.read
        characteristicProperties.formUnion(CBCharacteristicProperties.notify)
        var characterisitcPermissions = CBAttributePermissions.writeable
        characterisitcPermissions.formUnion(CBAttributePermissions.readable)
        readCharacteristic = CBMutableCharacteristic(type: readCharacteristicUuid, properties: characteristicProperties, value: nil, permissions: characterisitcPermissions)
        
        service.characteristics = [ readCharacteristic ]
        
        
        peripheralManager.add(service)
        
    }
    
    // MARK: CBPeripheralManagerDelegate
    
    /**
     Peripheral will become active
     */
    func peripheralManager(_ peripheral: CBPeripheralManager, willRestoreState dict: [String : Any]) {
        print("restoring peripheral state")
    }
    
    /**
     Peripheral added a new Service
     */
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        print("added service to peripheral")
        if error != nil {
            print(error.debugDescription)
        }
    }
    
    /**
     Peripheral started advertising
     */
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if error != nil {
            print ("Error advertising peripheral")
            print(error.debugDescription)
        }
        self.peripheralManager = peripheral
        
        delegate?.blePerihperal?(startedAdvertising: error)
        
        
    }
    /**
     Bluetooth Radio state changed
     */
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        peripheralManager = peripheral
        switch peripheral.state {
        case CBManagerState.poweredOn:
            buildGattProfile()
            startAdvertising()
        default: break
        }
        delegate?.blePeripheral?(stateChanged: peripheral.state)
        
    }
}
