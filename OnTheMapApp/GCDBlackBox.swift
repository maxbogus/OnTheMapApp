//
//  GCDBlackBox.swift
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 28/03/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
