//
//  SettingViewModel.swift
//  DeviceList
//
//  Created by samuelsong on 2021/11/28.
//

import Foundation
import Combine

protocol SettingDelegate: AnyObject {
    func logout()
}

class SettingViewModel: ObservableObject {
    weak var delegate: SettingDelegate? = nil

    func logout() {
        delegate?.logout()
    }
}
