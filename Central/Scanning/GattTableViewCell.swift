//
//  PeripheralTableViewCell.swift
//  Services
//
//  Created by Adonis Gaitatzis on 11/21/16.
//  Copyright © 2016 Adonis Gaitatzis. All rights reserved.
//

import UIKit
import CoreBluetooth

class GattTableViewCell: UITableViewCell {
    @IBOutlet weak var uuidLabel: UILabel!
    
    
    func renderCharacteristic(characteristic: CBCharacteristic) {
        uuidLabel.text = characteristic.uuid.uuidString
        
        print(characteristic.uuid.uuidString)        
    }
    
    
}
