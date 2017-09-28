//
//  ViewController.swift
//  sketch
//
//  Created by Adonis Gaitatzis on 1/9/17.
//  Copyright © 2017 Adonis Gaitatzis. All rights reserved.
//

import UIKit
import CoreBluetooth

/**
 This view displays the state of a BlePeripheral
 */
class ViewController: UIViewController, BlePeripheralDelegate {
    
    // MARK: UI Elements
    @IBOutlet weak var advertisingLabel: UILabel!
    @IBOutlet weak var advertisingSwitch: UISwitch!

    
    // MARK: BlePeripheral
    
    // BlePeripheral
    var blePeripheral:BlePeripheral!
    
    
    
    /**
     UIView loaded
     */
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    /**
     View appeared.  Start the Peripheral
     */
    override func viewDidAppear(_ animated: Bool) {
        blePeripheral = BlePeripheral(delegate: self)
        
        advertisingLabel.text = blePeripheral.advertisingName
    }
    
    /**
     View will appear.  Stop transmitting random data
     */
    override func viewWillDisappear(_ animated: Bool) {
        blePeripheral.stop()
    }
    
    /**
     View disappeared.  Stop advertising
     */
    override func viewDidDisappear(_ animated: Bool) {
        advertisingSwitch.setOn(false, animated: true)
    }

    // MARK: BlePeripheralDelegate
    
    /**
     Bluetooth radio state changed
     
     - Parameters:
     - state: the CBManagerState
     */
    func blePeripheral(stateChanged state: CBManagerState) {
        switch (state) {
        case CBManagerState.poweredOn:
            print("Bluetooth on")
        case CBManagerState.poweredOff:
            print("Bluetooth off")
        default:
            print("Bluetooth not ready yet...")
        }
    }
    
    /**
     BlePeripheral statrted adertising
     
     - Parameters:
     - error: the error message, if any
     */
    func blePerihperal(startedAdvertising error: Error?) {
        if error != nil {
            print("Problem starting advertising: " + error.debugDescription)
        } else {
            print("adertising started")
            advertisingSwitch.setOn(true, animated: true)
        }
    }

}

