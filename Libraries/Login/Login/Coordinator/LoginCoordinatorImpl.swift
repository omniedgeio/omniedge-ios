//
//  LoginCoordinatorImpl.swift
//  Login
//
//  Created by samuelsong(samuel.song.bc@gmail.com) on 2021/8/20.
//  
//

import Foundation
import OEPlatform
import SwiftUI
import Tattoo

class LoginCoordinatorImpl: LoginCoordinator, LoginDelegate {
    private let scope: Scope
    private let router: RoutingAPI

    init(scope: Scope, router: RoutingAPI) {
        self.scope = scope
        self.router = router
    }

    func createLoginView() -> AnyView {
        let viewModel = LoginViewModel(LoginDataStoreMock())
        viewModel.delegate = self
        return AnyView(LoginView(viewModel: viewModel))
    }

    func didLogin(token: String) {
        let deviceList = scope.getService(DeviceListAPI.self)
        let coordinator = deviceList.createHomeCoordinator(router: router)
        router.push(view: AnyView(coordinator.createHomePage().navigationBarHidden(true)))
    }

    func didRegister(email: String, password: String) {
    }

    func didReset(email: String) {
    }
}
